<?php

namespace App\Http\Controllers\IM;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Model\handlerBaseController;
use Illuminate\Support\Facades\Redis;

class UserBaseController extends handlerBaseController
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
     * 检查用户是否存在
     *s
     * @param $unique_name
     * @param $app_id
     * @param null $expansion
     * @return array|bool|false|\Illuminate\Database\Eloquent\Model|\Illuminate\Database\Query\Builder|mixed|null|object|string
     */
    public static function checkUserExis($unique_id,$app_id,$expansion = null){
        $unique_id = (string)$unique_id;
        if( !preg_match('/^[0-9a-zA-Z]+$/',$unique_id) ){
            return responseArrayError(resCode(212),212);
        }
        if( mb_strlen($unique_id) > 16 ){
            return responseArrayError(resCode(212),212);
        }

        $userInfo = self::getUserBaseInfoByUniquename($unique_id,$app_id);
        if( !$userInfo ){
            return self::register($unique_id,$app_id,$expansion);
        }else{
            if( $expansion !== null && $userInfo['expansion'] != $expansion ){
                $updateData['expansion'] = $expansion;
            }
            if( isset($updateData) ){
                self::updateUserBaseInfo(array('unique_id'=>$unique_id,"app_id"=>$app_id),$updateData);
            }
        }
        return self::getUserBaseInfoByUniquename($unique_id,$app_id);
    }

    /**
     * 获取多个用户基本信息 通过 unique_name 和 bid
     * @RequestMapping("getUsersBaseInfoByUniqueame")
     * @param user_id|bool
     * @return array
     * @throws Throwable
     *
     */
    public static function getUsersBaseInfoByUniquename($unique_names, $bid ,$param = '')//: Response
    {
        $result = array();
        foreach ( $unique_names as $val ){
            $result[$val] = self::getUserBaseInfoByUniquename($val,$bid,$param);
        }
        return $result;
    }

    /**
     * 获取单个用户信息
     *
     * @param $unique_name
     * @param $app_id
     * @param string $param
     * @return array|bool|mixed
     */
    public static function getUserBaseInfoByUniquename($unique_name, $app_id ,$param = '')//: Response
    {
        $userInfo = Redis::get("user:basethirdinfo:".$app_id.":".$unique_name);
        $userInfo = false;
        if( $userInfo ){
            $userInfo = json_decode($userInfo,true);

            if( $param ){
                $param = explode(',',$param);
                $res = array();
                foreach ( $param as $val ){
                    $res[$val] = $userInfo[$val] ?: false ;
                }
                return $res;
            }
            return $userInfo;

        }else{
            $userInfo = parent::getOne('','user',['client_id'=>$unique_name,'app_id'=>$app_id]);
        }
        if ( $userInfo ) {
            if( !empty($userInfo['extend']) ){
                $userInfo['extend'] = json_decode($userInfo['extend'],true);
            }else{
                $userInfo['extend'] = null;
            }

            Redis::set("user:basethirdinfo:".$app_id.":".$unique_name,json_encode($userInfo),5);
            if( $param ){
                $param = explode(',',$param);
                $res = array();
                foreach ( $param as $val ){
                    $res[$val] = isset($userInfo[$val]) ? $userInfo[$val] : false ;
                }
                return $res;
            }
            return $userInfo;
        }
        return false;
    }

    public static function register($unique_name,$app_id,$expansion = null)//: Response
    {
        $data['unique_id'] = $unique_name;
        $data['app_id'] = $app_id;
        $data['user_id'] = time();
        $userInfo = self::getUserBaseInfoByUniquename($unique_name,$app_id);
        if( !$userInfo ){
            // 判断是json字符串还是对象
            $data['extend'] = $expansion ?: json_encode($expansion, JSON_FORCE_OBJECT);
        }
        $data['ctime'] = time();

        $id = parent::create('','user',$data);
        // $id = DB::table('user')->insertGetId($data);

        if($id){
            return self::getUserBaseInfoByUniquename($unique_name,$app_id);
        }else{
            return false;
        }
    }

    public static function updateUserBaseInfo($where,$update)//: Response
    {


        $userInfo = parent::getOne('','user',$where);
        if ($userInfo) {
            $res = DB::table('user')->where($where)->update($update);
            if( $res ){
                if(isset($update['expansion'])){
//                    $client_ids = Gateway::getClientIdByUid($userInfo['id']);
//                    foreach ( $client_ids as $val ){
//                        Gateway::updateSession($val,array('expansion'=>json_decode($update['expansion'],true)));
//                    }
                }
                // ID => info
                Redis::del("user:baseinfo:".$userInfo['id']);
                // unique_name => info
                Redis::del("user:basethirdinfo:".$userInfo['app_id'].":".$userInfo['unique_name']);
                return true;
            }
            return false;
        }
        return false;
    }
    /**
     * 获取单个用户基本信息
     * @RequestMapping("getuserinfobyid")
     * @param user_id
     * @return array|bool
     * @throws Throwable
     *
     */
    public static function getUserBaseInfoById($user_id,$param = '')//: Response
    {
        $userInfo = Redis::get("user:base_info:".$user_id);
        if( $userInfo ){
            $userInfo = json_decode($userInfo,true);
            if( $param ){
                $param = explode(',',$param);
                $res = array();
                foreach ( $param as $val ){
                    $res[$val] = $userInfo[$val] ?: null ;
                }
                return $res;
            }
            return $userInfo;
        }else{
            $userInfo =  parent::getOne('','user',['id'=>$user_id]);

        }

        if ($userInfo) {
            if( !empty($userInfo['extend']) ){
                $userInfo['extend'] = json_decode($userInfo['extend'],true);
            }else{
                $userInfo['extend'] = null;
            }

            Redis::set("user:base_info:".$user_id,json_encode($userInfo),60 * 60 * 24 * 7);
            if( $param ){
                $param = explode(',',$param);
                $res = array();
                foreach ( $param as $val ){
                    $res[$val] = $userInfo[$val] ?: null ;
                }
                return $res;
            }
            return $userInfo;
        }
        return false;
    }
}
