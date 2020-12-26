<?php
/**
 * Created by PhpStorm.
 * User: zorozdd
 * Date: 2020/8/30
 * Time: 8:02 PM
 */

class Config{
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
        "port" => '3306',
    );
}