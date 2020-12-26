<?php
namespace App\Http\Controllers\IM;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Model\handlerBaseController;
use Illuminate\Support\Facades\Redis;
use Illuminate\Contracts\Support\Jsonable;
use App\Http\Controllers\JWTController;

use App\Http\Controllers\IM\UserBaseController as UserBase;
use App\Http\Controllers\IM\ImBaseController as ImBase;


use GatewayWorker\Lib\Gateway;



class IMController extends handlerBaseController
{
    /**
     * Handle the incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
//    public function __invoke()
//    {
//        //
//    }

    public function index(){
    }

    /**
     * 创建会话
     */
    public function createConv(Request $request){
        if( !$request->filled(['client_id', 'to_client_ids','conv_type']) ){
            return responseError(resCode(4001),4001);
        }

        $unique_id = $request->input('client_id');
        $to_unique_ids = $request->input('to_client_ids');
        $conv_type = $request->input('conv_type');

        // $to_unique_ids = json_decode($to_unique_ids);
        if( !is_array($to_unique_ids) ){
            return responseError(resCode(4406),4406);
        }
        foreach ( $to_unique_ids as $val ){
            $names[] = $val;
        }
        $names[] = $unique_id;
        // 获取用户信息
        $usersInfo = UserBase::getUsersBaseInfoByUniquename($names,\Request::header('app-id'),'id,client_id');
        $user_ids = array();
        foreach ( $usersInfo as $key => $val ){
            if( !$val ) return responseError(resCode(211).$key?$key:'',211);
            $user_ids[] = $val['id'];
        }

        switch ( $conv_type ){
            // 私聊
            case 1 :
                if( count($user_ids) > 2 ){
                    return responseError(resCode(4405),4405);
                }
                $conv_id = ImBase::buildConvID($user_ids);

                // $convInfo = ImBase::getConvInfo(array('conv_id'=>$conv_id,'conv_status'=>0));
                $convInfo = ImBase::getConvInfo(array('conv_id'=>$conv_id));
                // var_dump($convInfo);
                // var_dump($convInfo);
                $convInfo = $convInfo['data'];
                if( $convInfo ){
                    $convInfo = $convInfo[0];
                    // 扩展信息
                    $return_data['conv_extend'] = $convInfo['conv_extend'];
                    // 会话ID
                    $return_data['conv_id'] = $convInfo['conv_id'];

                    return responseSuccess($return_data);
                }
                break;
                // 临时会话
            case 2 :
                $conv_id = ImBase::buildTempGroupConvID($user_ids);
                break;
                // 群组
            case 3 :
                $conv_id = ImBase::buildGroupConvID();
                $data['group_id'] = ImBase::buildGroupId($usersInfo[$request->input('client_id')]['id']);
                break;
            default:
                return responseError(resCode(4405),4405);
                break;
        }
        if( !$conv_id ) return responseError('创建会话失败,请重试');

        asort($user_ids);
        sort($user_ids);

        $time = getMillisecond();

        $conv_expansion = null;

        if( $request->input('conv_extend') ){
            if( !json_decode(json_encode($request->input('conv_extend')),true) ){
                return responseError(resCode(4406),4406);
            }
            $conv_expansion = $request->input('conv_extend');
        }

        $data['conv_id'] = $conv_id;
        $data['conv_extend'] = json_encode($conv_expansion);
        $data['conv_type'] = $conv_type;
        $data['app_id'] = $request->header('app-id');
        $data['conv_creater_id'] =  $usersInfo[$request->input('client_id')]['id'];
        $data['ctime'] = $time;

        //return $data;
        parent::create('','conv_info',$data);

        ImBase::createConvRelation($conv_id,$user_ids,$conv_type,$usersInfo[$request->input('client_id')]['id']);
//        {
//            "unique":true,
//  "updatedAt":"2020-05-26T06:42:31.492Z",
//  "name":"My First Conversation",
//  "objectId":"5eccba570d3a42c5fd4e25c3",
//  "m":["BillGates","SteveJobs"],
//  "createdAt":"2020-05-26T06:42:31.482Z",
//  "uniqueId":"6c7b0e5afcae9aa1139a0afa25833dec"
//}

//        foreach( $user_ids as $uid ){
//            $client_ids = Gateway::getClientIdByUid($uid);
//            $temp[]['uid'] = $uid;
//            $temp[]['client'] = $client_ids;
//            foreach ( $client_ids as $client_id){
//                Gateway::joinGroup($client_id,$conv_id);
//            }
//        }
        // 拉入多人会话消息通知
//        if( $conv_type != 1 ){
//            foreach( $user_ids as $uid ){
//                $a[$uid]['on'] = Gateway::isUidOnline($uid);
//                if ( Gateway::isUidOnline($uid) ){
//                    $client_ids = Gateway::getClientIdByUid($uid);
//                    $a[$uid]['cl'] =$client_ids;
//                    foreach ( $client_ids as $client_id){
//                        Gateway::joinGroup($client_id,$conv_id);
//
//                    }
//                }
//            }
//            // 推送群组建立消息
//            $message = "创建多人会话";
//            $from_uid = $usersInfo[$request->input('unique_name')]['id'];
//            ImBase::sendChatMsgByConvId($from_uid,$conv_id,$message,-1,2,'system.create_conv',null,null);
//        }
        $res_conv_info = ImBase::getConvInfo(array('conv_id'=>$conv_id));
        //return responseSuccess($res_conv_info);
        $res_conv_info = $res_conv_info['data'][0];


        // 扩展信息
        $return_data['conv_extend'] = $res_conv_info['conv_extend'];
        // 会话ID
        $return_data['conv_id'] = $res_conv_info['conv_id'];

        return responseSuccess($return_data);

    }

    /**
     * 查询会话
     * @param Request $request
     * @return false|string
     */
    public function getConv(Request $request){
        if( !$request->filled(['where']) ){
            return responseError(resCode(4001),4001);
        }

        $where = $request->input('where');
        $where = json_decode($where,true);

        $where['app_id'] = \Request::header('app-id');

        // todo 限制查询条件
        if( !$where || !is_array($where) ){
            return responseError(resCode(4406),4406);
        }

        // {"results"=>[{"name"=>"test conv1", "m"=>["tom", "jerry"], "createdAt"=>"2018-01-17T04:15:33.386Z", "updatedAt"=>"2018-01-17T04:15:33.386Z", "objectId"=>"5a5ecde6c3422b738c8779d7"}]}

        $page = $request->input('page') ?: 1;
        $size = $request->input('size') ?: 20;

        $whereIn = array();
        foreach ( $where as $key => $value ){
            $where_x['app_id'] = $where['app_id'];
            //目前可以带的条件 1 conv_create_id 创建者
            if($value[0] =='conv_creater_id' ){
                // return responseError($value[2]);
                $create_user_info = UserBase::getUserBaseInfoByUniquename($value[2],\Request::header('app-id'));
                if( !$create_user_info ){
                    return responseError(resCode(211),211);
                }

                $where_x['conv_creater_id'] = $create_user_info['id'];

            }
            // 目前可以带的条件 2 conv_ids
            // 目前可以带的条件 3 user_id （该用户加入的会话）
            if( $value[0] =='user_id' ){

                $user_info = UserBase::getUserBaseInfoByUniquename($value[2],\Request::header('app-id'));
                if( !$user_info ){
                    return responseError(resCode(211),211);
                }
                $whereTemp['app_id'] = $where['app_id'];
                $whereTemp['user_id'] = $user_info['id'];
                $res = ImBase::getRelationInfo($whereTemp,  '','',array(),1,100);
                $conv_ids= array();
                foreach ( $res['data'] as $val ){
                    $conv_ids[] = $val['conv_id'];
                }
                if( $conv_ids ){
                    $whereIn = array("conv_id"=>$conv_ids);
                }
                //return responseSuccess($conv_id);
            }
        }

        $res = ImBase::getConvInfo($where_x,$whereIn,array('mtime'=>'desc'),'',$page,$size);

        foreach ( $res['data'] as &$val ){

            unset($val['id']);
            unset($val['status']);
            unset($val['app_id']);
            $val['mtime'] = $val['mtime'] ?  date("Y-m-d H:i:s",$val['mtime']/1000) : null;

            $val['ctime'] = date("Y-m-d H:i:s",$val['ctime']/1000);

            // 最后一天聊天记录 暂时
            // $res = ImBase::get

        }
        return responseSuccess($res);
    }

    /**
     * 更新对话
     * @param Request $request
     * @return false|string
     */
    public function updateConv(Request $request){
        if( !$request->filled(['where','update']) ){
            return responseError(resCode(4001),4001);
        }
        $where = $request->input('where');
        //var_dump($where);die;
        $update = $request->input('update');

        if( !$where || !is_array($where) ){
            return responseError(resCode(4406),4406);
        }

        return responseSuccess(ImBase::updateConv($where,$update));
        // return responseError(resCode(4406),4406);
    }


    /**
     * 删除对话
     * @param Request $request
     * @return false|string
     */
    public function delConv(Request $request,$conv_id){
//        if( !$request->filled(['where']) ){
//            return responseError(resCode(4001),4001);
//        }
//        $where = $request->input('where');
//
//        if( !$where || !is_array($where) ){
//            return responseError(resCode(4406),4406);
//        }

        $update = array(
            "status"=>2,
        );

        return responseSuccess(ImBase::updateConv(array(["conv_id","=",$conv_id]),$update));
    }

    /**
     * 新增成员
     *
     * @param Request $request
     * @return false|string
     */
    public function addMember(Request $request,$conv_id){
        if( !$request->filled(['client_ids']) ){
            return responseError(resCode(4001),4001);
        }
        $client_ids = $request->input('client_ids');

        //
        $res = ImBase::getConvInfo(array("conv_id"=>$conv_id,"app_id"=>\Request::header('app-id')),array(),array('mtime'=>'desc'),'');
        if( isset($res['data'][0]) ){
            $convInfo = $res['data'][0];
        }else{
            return responseError(resCode(4011),4011);
        }

        $usersInfo = UserBase::getUsersBaseInfoByUniquename($client_ids,\Request::header('app-id'),'id,client_id');
        $user_ids = array();
        foreach ( $client_ids as $value ){
            if( !$usersInfo[$value] ){
                return responseError(resCode(211).$value,211);
            }
            $user_ids[] = $usersInfo[$value]['id'];
        }
        if( count($user_ids)<1 ){
            return responseError('无可操作用户');
        }

        $client_relartion = ImBase::getRelationInfo(array('conv_id'=>$conv_id,'app_id'=>\Request::header('app-id')),'',"user_id",array("user_id"=>$user_ids));
        // var_dump($client_relartion);
        foreach ( $user_ids as $value ){
            if( isset($client_relartion['data'][$value]) ){
                unset($user_ids[array_search($value,$user_ids)]);
            }
        }
        ImBase::createConvRelation($conv_id,$user_ids,$convInfo['conv_type']);

        return responseSuccess(null);
    }

    /**
     * 移除用户
     *
     * @param Request $request
     * @param $conv_id
     * @return false|string
     * @throws \RpcBusinessException
     */
    public function removeMember(Request $request,$conv_id){
        if( !$request->filled(['client_ids']) ){
            return responseError(resCode(4001),4001);
        }
        $client_ids = $request->input('client_ids');

        $res = ImBase::getConvInfo(array("conv_id"=>$conv_id,"app_id"=>\Request::header('app-id')),array(),array('mtime'=>'desc'),'');
        if( isset($res['data'][0]) ){
            $convInfo = $res['data'][0];
        }else{
            return responseError(resCode(4011),4011);
        }

        $usersInfo = UserBase::getUsersBaseInfoByUniquename($client_ids,\Request::header('app-id'),'id,client_id,unique_id');
        $user_ids = array();
        foreach ( $client_ids as $value ){
            if( !$usersInfo[$value] ){
                return responseError(resCode(211).$value,211);
            }
            $user_ids[] = $usersInfo[$value]['id'];
        }
        if( count($user_ids)<1 ){
            return responseError('无可操作用户');
        }
        //
        $client_relartion = ImBase::getRelationInfo(array('conv_id'=>$conv_id,'app_id'=>\Request::header('app-id')),'',"user_id",array("user_id"=>$user_ids));
        foreach ( $user_ids as $value ){
            if( !$client_relartion['data'][$value] ){
                unset($client_ids[array_search($value,$client_ids)]);
            }
        }
        Db::table("conv_relation")->where(['conv_id'=>$conv_id,'app_id'=>\Request::header('app-id')])->whereIn('user_id',$user_ids)->update(["status"=>2]);
        // ImBase::updateRelation();
        return responseSuccess(null);
    }

    /**
     * 查询成员
     * @param Request $request
     * @param $conv_id
     * todo 貌似缺少校验
     */
    public function getMembers(Request $request,$conv_id){
        $res = ImBase::getConvInfo(array("conv_id"=>$conv_id,"app_id"=>\Request::header('app-id')),array(),array('mtime'=>'desc'),'');
        if( isset($res['data'][0]) ){
            $convInfo = $res['data'][0];
        }else{
            return responseError(resCode(4011),4011);
        }
        $client_relartion = ImBase::getRelationInfo(array('conv_id'=>$conv_id,'app_id'=>\Request::header('app-id')),'',"user_id");

        $client_ids = array();
        foreach ( $client_relartion['data'] as $k => $v ){

            $user_info = UserBase::getUserBaseInfoById($k);
            $client_ids[] = $user_info['client_id'];
        }

        return responseSuccess($client_ids);
    }

    /**
     * @param Request $request
     * @param $conv_id
     * @return false|string
     *
     *
     *  消息相关介绍
     *  消息类型 type -1文本 -2图片 -3语音 -4视频 -5位置 -6文件
     *  文本 text
     *  自定义属性 attrs 开发者自定义属性
     *  资源地址 url
     */
    public function sendMsg(Request $request,$conv_id){
        if( !$request->filled(['from_client','type']) ){
            return responseError(resCode(4001),4001);
        }

        $res = ImBase::getConvInfo(array("conv_id"=>$conv_id,"app_id"=>\Request::header('app-id')),array(),array('mtime'=>'desc'),'');
        if( isset($res['data'][0]) ){
            $convInfo = $res['data'][0];
        }else{
            return responseError(resCode(4011),4011);
        }
        // 消息来源
        $client_id = $request->input('from_client');

        $userInfo = UserBase::getUserBaseInfoByUniquename($client_id,\Request::header('app-id'));

        if( !$userInfo ){
            return responseError(resCode(211).$client_id,211);
        }
        // todo 用户权限校验


        // 消息类型过滤 todo
        if( !in_array($request->input('type'),[-1,-2,-3,-4,-5,-6]) ){
            return responseError(resCode(4406),4406);
        }


        // 消息详情表
        $data['user_id'] = $userInfo['id'];
        $data['conv_id'] = $conv_id;
        // 消息类型
        $data['type'] = $request->input('type');
        // 文本内容
        $data['text'] = $request->input('text','');
        // 自定义属性
        $data['attr'] = json_encode($request->input('attr',null));
        // 资源地址
        $data['url'] = json_encode($request->input('url',null));
        // 是否暂态
        $data['transient'] = json_encode($request->input('transient',0));
        // 是否同步
        $data['no_sync'] = $request->input('no_sync',0);
        // 全员@
        $data['mention_all'] = $request->input('mention_all',0);
        // 单独@
        $data['mention_client_ids'] = json_encode($request->input('mention_client_ids',null));

        $msg_info = ImBase::createMsg($data);
        $msg_id = $msg_info['msg_id'];
        $msg_ctime = $msg_info['ctime'];

        if( !$msg_id){
            return responseError("发送失败，稍后再试");
        }
        // relation表
        $where['conv_id'] = $conv_id;
        $update['mtime'] = getMillisecond();
        ImBase::updateRelation($where,$update);

        // todo socket消息分发
        Gateway::$registerAddress = env('GATEWAYADDRESS');

        $msg_data['type'] = 'msg.new';
        $msg['from_client'] = $client_id;
        $msg['conv_id'] = $conv_id;
        $msg['msg_id'] = $msg_id;
        $msg['ctime'] = $msg_ctime;
        $msg['type'] = $data['type'];
        $msg['text'] = $data['text'];
        $msg['attr'] = $data['attr'];
        $msg['url'] = $data['url'];
        $msg['transient'] = $data['transient'];
        $msg['mention_all'] = $data['mention_all'];
        $msg['mention_client_ids'] = $data['mention_client_ids'];
        $msg_data['data'] = $msg;

        Gateway::sendToGroup($conv_id,json_encode($msg_data));
        return responseSuccess(['msg_id'=>$msg_id,'time'=>$update['mtime']]);
    }

    // TODO 查询最后一条消息
    /**
     * 单条信息查询
     */
    public function getMsg(){

    }


    /**
     *
     * 历史消息
     * @param Request $request
     * @param $conv_id
     * @return false|string
     */
    public function getChatMsgs(Request $request,$conv_id){
//        if( !$request->filled(['conv_id']) ){
//            return responseError(resCode(4001),4001);
//        }

        $where[] = ['conv_id',$conv_id];
        $page = $request->input('page') ? $request->input('page') : 1;
        $size = $request->input('size') ? $request->input('size') : 25;

        $res = ImBase::getMsgs($where,$page,$size,['ctime'=>'DESC'], '',array(), '*');
        return responseSuccess($res);
    }
}
