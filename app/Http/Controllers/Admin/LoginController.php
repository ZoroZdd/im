<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class LoginController extends Controller
{
    /**
     * 登录
     * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
     */
    public function login(){
        // var_dump(session('admin_user'));die;
        if( session(config('key.s.admin_user')) ){
            return view('admin.index2');
        }else{
            return view('admin.login');

        }
    }
    public  function login_do(Request $request){
        if( !$request->filled(['loginName','Password']) ){
            return responseError(resCode(4001),4001);
        }
        $userName = $request->input('loginName');
        $Password = $request->input('Password');
        $user_info = DB::table('admin_user')->where('username', $userName)->first();
        if( !$user_info ){
            return responseError($userName.'不存在');
        }
        if( $user_info->password != $Password ) {
            return responseError('密码错误');
        }else{
            session([config('key.s.admin_user')=>$userName]);
        }
        return responseSuccess();
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

    /**
     * 测试用
     */
    public function test(){
        return view('admin.main');
    }
}
