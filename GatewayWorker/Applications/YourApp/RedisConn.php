<?php
require_once __DIR__."/Config.php";
/**
 * Created by PhpStorm.
 * User: zorozdd
 * Date: 2020/8/30
 * Time: 8:13 PM
 */
class RedisConn{
    private static $_instance = null; //静态实例
    private function __construct(){ //私有的构造方法
        self::$_instance = new \Redis();
        self::$_instance->connect(Config::$redis_config["host"],Config::$redis_config["port"]);
        if(isset(Config::$redis_config['password'])){
            self::$_instance->auth(Config::$redis_config['password']);
        }
    }
    //获取静态实例
    public static  function getInstance(){
        if(!self::$_instance){
            new self;
        }

        return self::$_instance;
    }
    /*
     * 禁止clone
     */
    private function __clone(){}

}