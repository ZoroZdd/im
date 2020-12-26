<?php

namespace App\Http\Controllers\IM;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Model\handlerBaseController;
use App\Http\Controllers\IM\UserBaseController as UserBase;

class IMBaseController extends handlerBaseController
{
    /**
     * Handle the incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
//    public function __invoke(Request $request)
//    {
//        //
//    }

    public function index(){
    }


    /**
     * 获取消息id
     * @return string
     */
    public static function buildMsgId(){
        return md5(getMillisecond().getRandStr(10));
    }

    /**
     * 获取私聊聊天ID
     * @param $user_ids
     * @return bool
     */
    public static function buildConvID($user_ids){
        asort($user_ids);
        sort($user_ids);
        $conv_id = md5( json_encode( $user_ids ) );
        if( $conv_id ){
            return $conv_id;
        }
        return false;
    }
    /**
     * 获取临时聊天ID
     * @param $user_ids
     * @return bool
     */
    public static function buildTempGroupConvID($user_ids){
        asort($user_ids);
        $conv_id = md5( json_encode( $user_ids ).getMillisecond().rand(99,999) );
        if( $conv_id ){
            return $conv_id;
        }
        return false;
    }

    /**
     * 获取群聊聊天ID
     * @param $user_ids
     * @return bool
     */
    public static function buildGroupConvID(){
        $conv_id = md5( 'group'.getMillisecond().rand(99,999) );
        if( $conv_id ){
            return $conv_id;
        }
        return false;
    }

    /**
     * 获取conv的详细信息
     *
     * @param $where
     * @param string $order
     * @param string $keyIndex
     * @return array
     * @throws ContainerException
     * @throws ReflectionException
     * @throws Swoft\Db\Exception\DbException
     */
    public static function getConvInfo($where = array(),$whereIn = array(),$order = array(),$keyIndex = '',$page = 1,$size = 20){
        $sqlObject = DB::table('conv_info');

        if( $where ){
            $sqlObject->where($where);
        }
        if( $whereIn ){
            foreach ( $whereIn as $k => $v ){
                $sqlObject->whereIn($k,$v);
            }
        }

        if( $order ){
            foreach ( $order as $k => $v ){
                $sqlObject->orderBy($k,$v);
            }
        }
        $result = $sqlObject->paginate($size,['*'], 'page', $page)->toJson();
        $result = json_decode($result,true);

        $result_temp = array();
        foreach ( $result['data'] as $key => $val ){
            // $val = object_array($val);
            $val['conv_extend']  = $val['conv_extend'] ? json_decode($val['conv_extend'],true) : null; // json_decode($val['conv_extend'],true) : null;
            //return $val;
            if( $keyIndex && isset($val[$keyIndex]) ){
                $result_temp[$val[$keyIndex]] = $val;
            }else{
                $result_temp[$key] = $val;
            }
        }
        $result['data'] = $result_temp;

        unset($result['first_page_url']);
        unset($result['last_page_url']);
        unset($result['next_page_url']);
        unset($result['path']);
        unset($result['prev_page_url']);
        unset($result['from']);
        unset($result['to']);

        return $result;
    }

    /**
     * 绑定聊天ID和用户ID
     * @param $conv_id
     * @param $uids
     * @param $type
     * @param $group_id
     * @return bool
     * @throws \RpcBusinessException
     */
    public static function createConvRelation($conv_id,$uids,$type,$create_user_id = ''){
        foreach ( $uids as $val ){
            if( $create_user_id == $val ){
                $data['role'] = 1;
            }else{
                $data['role'] = 0;
            }
            $data['app_id'] = \Request::header('app-id') ? \Request::header('app-id') :'';
            $data['user_id'] = $val;
            $data['conv_id'] = $conv_id;
            $data['conv_type'] = $type;
            $data['ctime'] = getMillisecond();

            parent::create('','conv_relation',$data);
        }
        return true;
    }

    /**
     * 通过 conv_id 获取群组用户信息
     * @param $conv_id
     * @param int $page
     * @param int $size
     * @return mixed
     * @throws \RpcBusinessException
     */
    public static function getUserByConvIdByPage($conv_id,$page=1,$size=10){
        $where['conv_id'] = $conv_id;
        $relations = self::getRelationInfo($where,'','client_id','',$page,$size);
        $users_ids = array();
        foreach ( $relations['data'] as $k => $v ){
            $users_ids[] = $k;
        }
        $user_info = array();
        foreach ( $users_ids as $user_id ){
            $data = UserBase::getUserBaseInfoById($user_id,'unique_id');
            $user_info[] = $data;
        }
        $res['page_info'] = $relations['page_info'];
        $res['list'] = $user_info;
        return $res;
    }
    /**
     * 获取关系联系的详细信息
     * @param $where
     * @param string $order
     * @param string $keyIndex
     * @return array
     * @throws \RpcBusinessException
     */
    public static function getRelationInfo($where = array(),$order = '',$keyIndex = '',$whereIn = array(),$page = 1,$size = 20){
        // $result = ConvRelation::getAll(  implode(',',ConvRelation::getFields()),$where,$order,$key );
        $sqlObject = DB::table('conv_relation');

        if( $where ){
            $sqlObject->where($where);
//            foreach ( $where as $k => $v ){
//                $sqlObject->where($k,$v);
//            }
        }
        if( $whereIn ){
            foreach ( $whereIn as $k => $v ){
                $sqlObject->whereIn($k,$v);
            }
        }

        if( $order ){
            foreach ( $order as $k => $v ){
                $sqlObject->orderBy($k,$v);
            }
        }
        $result = $sqlObject->paginate($size,['*'], 'page', $page)->toJson();
        $result = json_decode($result,true);


        $result_temp = array();
        foreach ( $result['data'] as $key => $val ){
            // $val = object_array($val);
            //return $val;
            if( $keyIndex && isset($val[$keyIndex]) ){
                $result_temp[$val[$keyIndex]] = $val;
            }else{
                $result_temp[$key] = $val;
            }
        }
        $result['data'] = $result_temp;

        unset($result['first_page_url']);
        unset($result['last_page_url']);
        unset($result['next_page_url']);
        unset($result['path']);
        unset($result['prev_page_url']);
        unset($result['from']);
        unset($result['to']);

        return $result;
    }
    /**
     * 更新会话
     * @param $where 更新条件
     * @param $update 更新内容
     * @return bool
     * @throws ContainerException
     * @throws ReflectionException
     * @throws Swoft\Db\Exception\DbException
     */
    public static function updateConv( $where , $update ){
        $conv_info = self::getConvInfo($where);
        if( !$conv_info ){
            return false;
        }
        $update['mtime'] = getMillisecond();
        $res = parent::update('','conv_info',$update,$where);
        // $res = DB::table('conversation_info')->where($where)->update($update);
        if( $res ){
            return true;
        }
        return false;
    }

    /**
     * 更新会话
     * @param $where 更新条件
     * @param $update 更新内容
     * @return bool
     * @throws ContainerException
     * @throws ReflectionException
     * @throws Swoft\Db\Exception\DbException
     */
    public static function updateRelation( $where , $update ){
        $conv_info = self::getRelationInfo($where);
        if( !$conv_info ){
            return false;
        }
        $update['mtime'] = getMillisecond();
        $res = parent::update('','conv_relation',$update,$where);
        // $res = DB::table('conversation_info')->where($where)->update($update);
        if( $res ){
            return true;
        }
        return false;
    }


    /**
     * 创建消息详情
     * @param $data
     * @return bool
     */
    public static function createMsg($data)
    {
        $data['msg_id'] = self::buildMsgId();
        $data['ctime'] = getMillisecond();
        if( parent::create('', 'conv_detail', $data) ){
            return $data;
        }else{
            return false;
        }
    }

    /**
     * 获取消息详情(多条)
     */
    public static function getMsgs($where,$page=1,$size=20,$order='',$keyIndex = '',$whereIn = array(),$fields = '*'){
        $res = parent::getAll('','conv_detail',$where,$order,'',$whereIn,$page,$size,$fields);

        if( $res['total'] ){
            foreach ( $res['data'] as &$val ){
                $val['attr'] = json_decode($val['attr'],true);
                unset($val['id']);
                $user_info = UserBase::getUserBaseInfoById($val['user_id'],'');
                $val['client_id'] = $user_info['client_id'];
                unset($val['user_id']);
            }

        }
        return $res;
    }

    /**
     * 获取消息详情(单条)
     */
    public static function getMsg($msg_id){
        $res = parent::getOne($lib = '','conv_detail',array('msg_id'=>$msg_id));

        if( $res ){
            $res['attr'] = json_decode($res['attr'],true);
            return $res;
        }else{
            return false;
        }
    }

}
