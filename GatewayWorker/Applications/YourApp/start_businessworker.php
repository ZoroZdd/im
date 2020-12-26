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
use \Workerman\Worker;
use \Workerman\WebServer;
use \GatewayWorker\Gateway;
use \GatewayWorker\BusinessWorker;
use \Workerman\Autoloader;

// 自动加载类
require_once __DIR__ . '/../../vendor/autoload.php';
require_once __DIR__ . '/Connect.php';
require_once __DIR__.'/../../../workerman-jsonrpc/Applications/JsonRpc/Clients/RpcClient.php';
require_once __DIR__.'/Config.php';

// bussinessWorker 进程
$worker = new BusinessWorker();
// worker名称
$worker->name = 'YourAppBusinessWorker';
// bussinessWorker进程数量
$worker->count = 4;
// 服务注册地址
$worker->registerAddress = '0.0.0.0:1238';




/**
 * 初始化数据库
 * @param $worker
 */
$worker->onWorkerStart = function()
{

    //var_dump('cccc');
    // 将db实例存储在全局变量中(也可以存储在某类的静态成员中)
    // global $db;
    //Connect::$instance = new \Workerman\MySQL\Connection('mysql', '3306', 'root', '123456', 'im');
    //$all_tables = Connect::$instance->query('show tables');
    //var_dump(json_encode($all_tables));

    var_dump(Config::$rpc_config);
    // 初始化Rpc配置
    RpcClient::config(Config::$rpc_config);
    // sql 初始化
    Connect::$instance = new \Workerman\MySQL\Connection(Config::$db_config["host"], Config::$db_config["port"], Config::$db_config["user"], Config::$db_config["pwd"], Config::$db_config["database"]);
    if( !Connect::$instance ){
        echo "sql 初始化失败";
    }
    // redis 初始化
//    $redis = new \Redis();
//    RedisConn::$instance = $redis->connect(Config::$redis_config["host"], Config::$redis_config["port"]);
//    if( !RedisConn::$instance ){
//        echo "redis 初始化失败";
//    }

};
$worker->onMessage = function($connection, $data)
{
};


// 如果不是在根目录启动，则运行runAll方法
if(!defined('GLOBAL_START'))
{
    Worker::runAll();
}

