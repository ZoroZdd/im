<?php

namespace App\Http\Controllers\IM;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Model\handlerBaseController;
use phpDocumentor\Reflection\Types\Parent_;

use App\Http\Controllers\IM\UserBaseController as UserBase;



class UserController extends handlerBaseController
{
    /**
     * Handle the incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function __invoke(Request $request)
    {
        //
    }

    public function test(){
        $unique_name = time();
        $app_id = 666666;
        $expansion = '{"nickname":"json"}';
        UserBase::checkUserExis($unique_name,$app_id,$expansion);
    }



}
