<?php
require_once __DIR__ . '/RedisConn.php';
require_once __DIR__.'/Config.php';

/**
 * Created by PhpStorm.
 * User: zorozdd
 * Date: 2020/8/28
 * Time: 4:51 PM
 */

class Common{
    /**
     *
     */
    public static function getCatchByClientId($client_id){
        $redis = RedisConn::getInstance();
        return $redis->get("user:socket:socket_client_id:".$client_id);
    }
    public static function getCatchByUserId($user_id){
        $redis = RedisConn::getInstance();
        return $redis->get("user:socket:user_id:".$user_id);
    }

    /**
     * 获取毫秒级别时间戳
     * @return float
     */
    public static function getMillisecond() {
        list($t1, $t2) = explode(' ', microtime());
        return (float)sprintf('%.0f',(floatval($t1)+floatval($t2))*1000);
    }

    /**
     * @param $data
     * @return array
     */
    public static function returnSuccessJson($data,$json = 1){
        $tmp = [
            "code" =>0,
            "msg"  =>'ok',
            "data" =>$data
        ];
        if( $json ){
            return json_encode($tmp);
        }else{
            return $tmp;
        }

    }

    /**
     * @param $code
     * @param $msg
     * @param $data
     * @return array
     */
    public static function returnErrorJson($code = 1,$msg = '',$json = 1){
        if( self::resCode($code) ){
            $msg = self::resCode($code);
        }

        $tmp = [
            "code" =>$code,
            "msg"  =>$msg,
            "data" =>null
        ];

        if( $json ){
            return json_encode($tmp);
        }else{
            return $tmp;
        }
    }

    /**
     * @param $code
     * @param $msg
     * @param $data
     * @return array
     */
    public static function returnArray($type,$msg = '',$data = array(),$json = 1){
        $tmp = [
            "type" =>$type,
            "msg"  =>$msg,
            "data" =>$data
        ];

        if( $json ){
            return json_encode($tmp);
        }else{
            return $tmp;
        }
    }

    /**
     *
     * 返回对应的错误码
     * @param $code
     * @return mixed
     */
    public static function resCode($code){
        $code = (string)$code;
        $resCode = array(
            '0' => 'Success',
            '1' => 'Error',

            // 用户类
            '211' => '未知用户',
            '212' => 'unique_id 不符合要求',
            '213' => '当前用户被禁用',
            // im类

            '4001' => '参数缺失',
            '4011' => '未知会话',
            '4405' => '错误的聊天类型',
            '4406' => '错误的参数格式'
        );

        return isset($resCode[$code]) ? $resCode[$code] : null;
    }
}