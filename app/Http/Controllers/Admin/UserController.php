<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class UserController extends Controller
{
    /**
     * 用户列表
     */
    public function userlist(){
        // var_dump(public_path());die;
        if( session('admin_user') ){
            return view('admin.login');
        }else{
            return view('admin.index');
        }
    }
}
