<?php
/**
 * Created by PhpStorm.
 * User: zorozdd
 * Date: 2020/8/29
 * Time: 11:53 PM
 */
class Config{

    // rpc
    public static $rpc_config = array(
        'tcp://127.0.0.1:2015',
        'tcp://127.0.0.1:2015'
    );
    // sql
    public static $db_config = array(
        "host" => '127.0.0.1',
        "port" => '3306',
        "user" => 'root',
        "pwd" => '123456',
        "database" => 'im'
    );
    // redis
    public static $redis_config = array(
        "host"  => '127.0.0.1',
        "port" => '6379',
    );


}