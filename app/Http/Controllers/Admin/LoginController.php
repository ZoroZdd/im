<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class LoginController extends Controller
{
    /**
     * 登录
     * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
     */
    public function login(){
        // var_dump(public_path());die;
        return view('admin.login');
    }

    public  function login_do(Request $request){
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
    }

    /**
     * 主页
     * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
     */
    public function index(){
        return view('admin.index2');
    }


    public function start(){
        return view('admin.start');
    }
}
