<?php
require_once __DIR__ . '/../Connect.php';
require_once __DIR__ . '/../Common.php';
require_once __DIR__.'/../../../../workerman-jsonrpc/Applications/JsonRpc/Clients/RpcClient.php';
require_once __DIR__ . '/../RedisConn.php';
require_once __DIR__.'/../Config.php';

use \GatewayWorker\Lib\Gateway;

/**
 * Created by PhpStorm.
 * User: zorozdd
 * Date: 2020/8/29
 * Time: 11:48 PM
 */
class User{

    /**
     *
     * login
     *
     * jwt
     *
     * @param $app_id
     * @param $client_id
     * @param $device_id
     * @return bool
     *
     */
    public static function login( $app_id,$client_id,$socket_client_id,$device_id,$ext = array() ){
        RpcClient::config(Config::$rpc_config);
        // User对应applications/JsonRpc/Services/User.php 中的User类
        $res = RpcClient::instance('User')->getOneUserInfo(['client_id'=>$client_id,'app_id'=>$app_id]);

        Gateway::$registerAddress = '127.0.0.1:1238';

        // new user
        if( $res && $res['code'] == '211' ){
            $insert['app_id'] = $app_id;
            $insert['client_id'] = $client_id;
            $insert['status'] = 0;
            $insert['extend'] = json_encode($ext);
            $insert['ctime'] = Common::getMillisecond();
            $createRes = RpcClient::instance('User')->createData($insert);
            if( $createRes && $createRes['code'] == '0' ){
                $res = RpcClient::instance('User')->getOneUserInfo(['client_id'=>$client_id,'app_id'=>$app_id]);
            }else{
                Gateway::sendToClient($socket_client_id,Common::returnErrorJson(1));
                return false;
            }
        }
        if( !$res || $res['code'] != 0 ){
            Gateway::sendToClient($socket_client_id,Common::returnErrorJson(211));
            return false;
        }
        $user_info = $res['data'];
        if( $user_info['status'] == 1 ){
            Gateway::sendToClient($socket_client_id,Common::returnErrorJson(213));
            return false;
        }

        $user_id = $user_info['id'];
        $redis = RedisConn::getInstance();

        $client_info = Common::getCatchByUserId($user_id);
        if( $client_info ){
            $client_info = json_decode($client_info,true);
            foreach ( $client_info as $key => $val ){
                // 设备号相同 但是client_id不同 踢出
                if( $device_id == $val['device_id'] ){
                    if( $socket_client_id != $key){
                        $data['time'] = Common::getMillisecond();
                        Gateway::sendToClient($key,Common::returnArray("logout.kick","error",$data));
                        Gateway::unbindUid($key,$user_id);
                        Gateway::closeClient($key);
                        return false;
                    }
                }
            }
        }
        // 踢掉上一次链接socket [暂时]
        $socketids = Gateway::getClientIdByUid($user_id);
        foreach ( $socketids as $cval ){
            if( $cval != $socket_client_id ){
                $data['time'] = Common::getMillisecond();
                Gateway::sendToClient($cval,Common::returnArray("logout.kick","error",$data));
                Gateway::unbindUid($cval,$user_id);
                Gateway::closeClient($cval);
                return false;
            }
        }

        // 绑定用户
        Gateway::bindUid($socket_client_id,$user_id);
        // 登录 并且记录标示
        $client_info[$socket_client_id] = array(
            "login_time" => time(),
            "device_id"  => $device_id,
            "user_id"    => $user_info['id']
        );
        $redis->set("user:socket:user_id:".$user_id,json_encode($client_info));
        $redis->set("user:socket:socket_client_id:".$socket_client_id,json_encode($client_info[$socket_client_id]));

        $login['time'] = Common::getMillisecond();
        Gateway::sendToClient($socket_client_id,Common::returnArray('login.success',"success",$login));

        self::loginChat($app_id,$client_id,$socket_client_id);


        return true;
    }

    /**
     * 加入聊天相关会话群组
     *
     * @param $app_id
     * @param $client_id
     * @param $socket_client_id
     */
    public static function loginChat($app_id,$client_id,$socket_client_id){
        //进入相关会话组
        $chatinfo = RpcClient::instance('User')->getUserChatGroup( $app_id,$client_id,1,100); // 这里条件写死  默认先100个会话
        if( $chatinfo['data']['total'] >= 1 ){
            foreach ($chatinfo['data']['data'] as $val){
                Gateway::joinGroup($socket_client_id,$val['conv_id']);
                $temp_msg = array(
                    "count"=>Gateway::getClientCountByGroup($val['conv_id']),
                    "client_ids"=>Gateway::getUidListByGroup($val['conv_id'])
                );
                Gateway::sendToGroup($val['conv_id'],json_encode($temp_msg));
            }
        }
    }



}