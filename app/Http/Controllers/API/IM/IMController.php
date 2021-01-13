<?php

namespace App\Http\Controllers\API\IM;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class IMController extends Controller
{
    /**
     * 创建会话
     */
    public function createConv(Request $request){
        $user_id = $request->nickname;
        $user_info = DB::table('api_user')->where('nickname', $user_id)->first();
        if( !$user_info ){
            return responseError($request->nickname.'不存在');
        }
        $to_user_id = $request->to_nickname;
        $to_user_info = DB::table('api_user')->where('nickname', $to_user_id)->first();
        if( !$to_user_info ){
            return responseError($request->to_nickname.'不存在');
        }

        $url = 'http://nginx/im/conversations';

        //
        $header = [
            'app-id: 666666',
            'app-key: '.env('APP_KEY'),
            'Content-Type: application/json'
        ];

        $conv_extend = array();

        $conv_type = 1;
        // todo 创建会话 关于会话扩展信息的解决方案
        switch ($conv_type){
            case 1 :
                $conv_extend['conv_name'][$user_id] = $to_user_info->nickname;
                $conv_extend['conv_name'][$to_user_id] = $user_info->nickname;

                $conv_extend['conv_avatar'][$user_id] = "http://127.0.0.1/img/timg.jpeg";
                $conv_extend['conv_avatar'][$to_user_id] = "http://127.0.0.1/img/img2.jpg";
                break;
            default:
                $conv_extend['conv_name'] = 'unknow chat name';
                break;
        }


        if( $conv_type == 1 ){
            $conv_extend['conv_name'][$user_id] = $to_user_info->nickname;
            $conv_extend['conv_name'][$to_user_id] = $user_info->nickname;
        }

        $data['client_id']  = $user_info->id;
        $data['to_client_ids'] = array($to_user_info->id);
        $data['conv_type'] = 1;
        $data['conv_extend'] = $conv_extend;

        return requestForIM('POST',$url,$header,$data);  // ( $type,$url,$header,$data ){
    }
    /**
     * 获取会话列表
     */
    public function getConvList(Request $request){
        $id = $request->client_id;
        $res = DB::table('api_user')->where('id', $id)->first();
        if( !$res) {
            return responseError(resCode( $res['code']), $res['code']);
        }
        $url = 'http://nginx/im/conversations';
        $header[] = 'app-id:666666';
        $data['where'] = '[["user_id","=",'.$res->id.']]';

        //requestForIM( $type,$url,$header,$data )
        $res = requestForIM('GET',$url,$header,$data);

        if( !$res ){
            return responseError(json_encode("xxxxxxx.error"));
        }
        if( $res['code'] == 0  ){
            return responseSuccess($res['data'],true);
        }else{
            return responseError(json_encode($res));
        }
    }
    /**
     * 获取消息列表
     */
    public function getChatMsgs(Request $request){
        $conv_id = $request->conv_id;
        $url = 'http://nginx/im/conversations/'.$conv_id.'/message';
        $header[] = 'app-id:666666';

        $where['page'] = $request->page ? $request->page : 1;
        $where['size'] = $request->size ? $request->size : 20;
        //var_dump($where);

        //requestForIM( $type,$url,$header,$data )
        $res = requestForIM('GET',$url,$header,$where);

        if( $res['code'] == 0 ){
            return responseSuccess($res['data'],true);
        }else{
            return responseError(json_encode($res));
        }
    }
}

