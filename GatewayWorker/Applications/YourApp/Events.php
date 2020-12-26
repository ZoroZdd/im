<?php
/**
 * This file is part of workerman.
 *
 * Licensed under The MIT License
 * For full copyright and license information, please see the MIT-LICENSE.txt
 * Redistributions of files must retain the above copyright notice.
 *
 * @author walkor<walkor@workerman.net>
 * @copyright walkor<walkor@workerman.net>
 * @link http://www.workerman.net/
 * @license http://www.opensource.org/licenses/mit-license.php MIT License
 */

require_once __DIR__ . '/Connect.php';

require_once __DIR__.'/../../../workerman-jsonrpc/Applications/JsonRpc/Clients/RpcClient.php';

require_once __DIR__.'/IM/User.php';

/**
 * 用于检测业务代码死循环或者长时间阻塞等问题
 * 如果发现业务卡死，可以将下面declare打开（去掉//注释），并执行php start.php reload
 * 然后观察一段时间workerman.log看是否有process_timeout异常
 */
//declare(ticks=1);

use \GatewayWorker\Lib\Gateway;
use \GatewayWorker\Lib\RedisConnection;


/**
 * 主逻辑
 * 主要是处理 onConnect onMessage onClose 三个方法
 * onConnect 和 onClose 如果不需要可以不用实现并删除
 */
class Events
{
    /**
     * 当客户端连接时触发
     * 如果业务不需此回调可以删除onConnect
     * 
     * @param int $client_id 连接id
     */
    public static function onConnect($client_id)
    {
        var_dump("connect...");
        // 向所有人发送
        Gateway::sendToAll(json_encode("$client_id login\r\n"));

        $address_array = array(
            'tcp://127.0.0.1:55858',
            'tcp://127.0.0.1:55757'
        );
// 配置服务端列表
        RpcClient::config($address_array);

        $uid = 567;

// User对应applications/JsonRpc/Services/User.php 中的User类
        $user_client = RpcClient::instance('User');

// getInfoByUid对应User类中的getInfoByUid方法
        // $ret_sync = $user_client->getInfoByUid($uid);


//        $ret_sync = $user_client->login('666666','66666',(string)time());
//        var_dump($ret_sync);


        //var_dump(Connect::getInstance());
        //$all_tables = Connect::$instance->query('show tables');


        // $all_tables = $db->query('show tables');
        //var_dump(json_encode($all_tables));
    }
    
   /**
    * 当客户端发来消息时触发
    * @param int $client_id 连接id
    * @param mixed $message 具体消息
    */
   public static function onMessage($socket_client_id, $message)
   {
       $redis = new \Redis();
       $redis->connect('127.0.0.1', 6379);
       // 格式要求
       //       {
       //           'type':'xxx',
       //           'data':{...}
       //       }

       $message = json_decode($message,true);

       var_dump($message);
       // 用户client_id
       if( !$message ){
           Gateway::sendToClient($socket_client_id,Common::returnArray("error","错误的消息格式"));
           return;
       }
       if( !$message['data']['client_id'] ){
           Gateway::sendToClient($socket_client_id,Common::returnArray("error","缺失参数01"));
           return;
       }
       $client_id = $message['data']['client_id'];

       if( !isset($message['type']) ){
            Gateway::sendToClient($socket_client_id,Common::returnArray("error","缺失参数02"));
            return;
       }

       switch ($message['type']){
           case 'login':
               $app_id = $message['data']['app_id'];
               $device_id = $message['data']['device_id'];


               // 用户登录
               $res = User::login($app_id,$client_id,$socket_client_id,$device_id,$message['data']['ext']);
               if( !$res ){
                    // 日志记录 todo
//                  echo $client_id.'login error';
//                  Gateway::sendToClient($socket_client_id,Common::returnArray("error","登录失败"));
                   return false;
               }
               // 进入会话群组
//               $chatinfo = User::getUserChatGroup( $app_id,$client_id,1,10);
//               var_dump()

               return true;
               break;
       }

// 配置服务端列表
       //RpcClient::config($address_array);
       //$user_client = RpcClient::instance('User');
       //$ret_sync = $user_client->getInfoByUid($uid);
       // $uid = 567;



       //连接本地的 Redis 服务
//       $redis = new \Redis();
//       $redis->connect('127.0.0.1', 6379);
//       echo "Connection to server successfully";
//       //查看服务是否运行
//       echo "Server is running: " . $redis->ping();

        // 向所有人发送 
        //Gateway::sendToAll("$client_id said $message\r\n");
   }
   
   /**
    * 当用户断开连接时触发
    * @param int $client_id 连接id
    */
   public static function onClose($client_id)
   {
       var_dump("bbb");
       // 向所有人发送 
       GateWay::sendToAll(json_encode("$client_id logout\r\n"));
   }
}
