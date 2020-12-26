<?php

/**
 * Created by PhpStorm.
 * User: zorozdd
 * Date: 2020/8/26
 * Time: 4:47 PM
 */
class Connect{
//    //私有属性，用于保存实例
//    private static $instance;
//    //构造方法私有化，防止外部创建实例
//    private function __construct(){
//        self::$instance = new \Workerman\MySQL\Connection('mysql', '3306', 'root', '123456', 'im');
//    }
//    //公有方法，用于获取实例
//    public static function getInstance(){
//        //判断实例有无创建，没有的话创建实例并返回，有的话直接返回
//        if(!(self::$instance instanceof self)){
//            self::$instance = new self();
//        }
//        return self::$instance;
//    }
//    //克隆方法私有化，防止复制实例
//    private function __clone(){}

    public static $instance;

}