<?php
require_once __DIR__ . '/../../../vendor/autoload.php';

require_once __DIR__ . '/../../Config/Connect.php';

require_once __DIR__ . '/Base.php';

require_once __DIR__ . '/Common.php';

/**
 *  测试
 * @author walkor <worker-man@qq.com>
 */
class User extends Base
{
   public static function getInfoByUid($uid)
   {

       //var_dump(parent::getOne('id,client_id,app_id','user',array("app_id"=>"666666")));

       $a = parent::getAll('id,client_id,app_id','user',array("app_id"=>"666666") , array('desc'=>'id'), 'client_id', $limit = '0,2');
       // var_dump($a);


       $data['app_id'] = '123456';
       $data['client_id'] = time();
       $data['extend'] = json_encode(["x"=>"123"]);
       $data['status'] = 1;
       $data['ctime'] = Common::getMillisecond();

       $res = parent::create('user',$data);
       // var_dump($res);
       return $res;
   }

    /**
     *
     *  获取单个用户信息
     * @param $where
     * @return mixed
     * @throws RpcBusinessException
     */
    public static function getOneUserInfo($where){
        $user_info = parent::getOne('id,client_id,extend,status','user',$where);
        if( !$user_info ){
           return Common::returnErrorArray(211,Common::resCode(211));
        }
        // var_dump(Common::returnSuccessArray($user_info));
        return Common::returnSuccessArray($user_info);
    }

    /**
     *
     *  插入
     * @param $where
     * @return mixed
     * @throws RpcBusinessException
     */
    public static function createData($data){
        $info = parent::create('user',$data);
        if( !$info ){
            return Common::returnErrorArray(1,Common::resCode(1));
        }
        return Common::returnSuccessArray('ok');
    }

    /**
     *
     *
     * @param $app_id
     * @param $client_id
     * @param $device_id
     * @return array
     * @throws RpcBusinessException
     */
   public static function login( $app_id,$client_id,$device_id ){

       $user_info = parent::getOne('id,client_id,extend,status','user',['app_id'=>$app_id,'client_id'=>$client_id]);
       // 获取用户身份
       if( !$user_info ){
            return Common::returnErrorArray(211,Common::resCode(211));
       }

       if( $user_info['status'] == 1 ){
           return Common::returnErrorArray(213,Common::resCode(213));
       }

       // 校验之后绑定
   }

    /**
     * 获取用户聊天列表
     *
     * @param $app_id
     * @param $client_id
     * @param int $page
     * @param int $size
     * @return array
     * @throws RpcBusinessException
     * @throws \Db\Exception
     */
   public static function getUserChatGroup( $app_id,$client_id,$page = 1,$size = 10){
       $user_info = parent::getOne('id,client_id,extend,status','user',['app_id'=>$app_id,'client_id'=>$client_id]);
       if( !$user_info ){
           return Common::returnErrorArray(211,Common::resCode(211));
       }
       $where[] = 'app_id = '.$app_id;
       $where[] = 'user_id = '.$user_info['id'];
       $where[] = 'status = 1';

       $chat_info = parent::getAll('id,app_id,user_id,role,conv_id,conv_type,mtime','conv_relation',$where, array('mtime'=>'desc'), '', $page,$size,'');
       return Common::returnSuccessArray($chat_info);
   }

}
