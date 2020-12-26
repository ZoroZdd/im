<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class testController extends Controller
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

    public function index(){

        // $user = DB::table("test")->find(1);
        $where = array(
            ["conv_id","1d72310edc006dadf2190caad5802983"]
        );
        $user = parent::getOne('','conv_relation',$where);
        var_dump($user);

        echo '<br>';
//        $where_tmp = array(
//            ['mobile','like','%111']
//        );
//        $user = parent::getAll('','conv_detail',$where_tmp,'username',array(['id','desc']),2);
//        foreach ( $user as $val ){
//            var_dump($val['username']);
//        }
        // var_dump($user);


    }
}
