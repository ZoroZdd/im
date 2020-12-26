<?php

namespace App\Http\Controllers\API\User;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class UserController extends Controller
{

    /**
     * 注册
     *
     * @param Request $request
     * @return false|string
     */
    public function register(Request $request){
        $res = DB::table('api_user')->where('nickname', $request->nickname)->first();
        if(!$res){
            $data['nickname'] = $request->nickname;
            $data['pwd'] = md5($request->pwd.'im');
            $data['avatar'] = 'https://cdfy120.cdu.edu.cn/dfiles/10172/images/qyy.jpg';
            $user_id = DB::table('api_user')->insertGetId($data);
        }
        return responseSuccess('ok');
    }

    /**
     * 登录
     *
     * @param Request $request
     * @return false|string
     */
    public function login(Request $request){
        $res = DB::table('api_user')->where('nickname', $request->nickname)->first();

        if( !$res ){
            return responseError(resCode(211),211);
        }

        if( md5($request->pwd.'im') != $res->pwd ){
            return responseError(resCode(214),214);
        }
        return responseSuccess($res);
    }

    /**
     * 获取用户信息
     */
    public function userInfo(Request $request){
        if(isset($request->nickname)){
            $res = DB::table('api_user')->where('nickname', $request->nickname)->first();
        }else{
            $res = DB::table('api_user')->where('id', $request->id)->first();
        }
        return responseSuccess($res);

        // $res = DB::table('api_user')->where('nickname', $request->nickname)->first();

        if( !$res ){
            return responseError(resCode(211),211);
        }

        return responseSuccess($res);
    }



    public function cerateConv(Request $request){
        $to_user_id = $request->to_user_id;
        $user_id = $request->user_id;

        // DB::table('api_user')->where('nickname', $request->nickname)->first();

    }

    /**
     * 通过conv_id获取用户id
     */
    public function getUserListByConvid(Request $request){
        $conv_id = $request->conv_id;
        $url = 'http://nginx/im/conversations/'. $conv_id .'/members';
        $header[] = 'app-id:666666';

        //requestForIM( $type,$url,$header,$data )
        $res = requestForIM('GET',$url,$header,'');
        if( $res['code'] == 0 ){
            return responseSuccess($res['data'],true);
        }else{
            return responseError(json_encode($res));
        }
    }
}
