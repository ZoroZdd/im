<?php

require_once __DIR__ . '/../../../vendor/autoload.php';
require_once __DIR__ . '/../../Config/Connect.php';

/**
 *  测试
 * @author walkor <worker-man@qq.com>
 */
class Base
{

    /**
     * 获取一条数据
     *
     * @param $fields
     * @param $table_name
     * @param $where
     * @param array $order
     * @return mixed
     * @throws RpcBusinessException
     */
    public static function getOne($fields,$table_name, $where, $order = array('id'))
    {
        $db = Connect::$instance;

        $where_str = '';
        $num = count($where);
        $i = 1;
        foreach ( $where as $k => $v ){
            if( is_int($k) ){
                $where_str .= $v;
            }else{
                $where_str .= $k." = :".$k;
                if( $i != $num ){
                    $where_str .= ' and ';
                }
            }
            $i++;
        }
        return $db->select($fields)->from($table_name)->where($where_str)->bindValues($where)->orderByDESC($order)->row();
        // return $db->lastSQL();
    }

    /**
     * 获取多条数据
     *
     * @param $fields
     * @param string $where
     * @param string $order
     * @param string $key
     * @param string $limit
     * @param string $group
     * @return array
     * @throws RpcBusinessException
     * @throws \Db\Exception
     */
    public static function getAll($fields,$table_name,$where = '', $order = array(), $key = '', $page = 1,$size = 10,$group = '')
    {
        $db = Connect::$instance;

        if( $where ){
            $db->select($fields)->from($table_name)->where($where);
        }else{
            $db->select($fields)->from($table_name);
        }


        if (!empty($order)) {
            foreach ( $order as $k => $v ){
                if( $v == 'asc' ){
                    $db->orderByASC(array($k));
                }else{
                    $db->orderByDESC(array($k));
                }
            }
            //$db->order($order);
        }
        if (!empty($group)) {
            $db->groupBy($group);
        }
        $db->limit(($page-1)*$size.','.$size);

//        if (!empty($limit)) {
//            // 兼容传参为 a,b的格式
//            if (strpos($limit, ',') !== false) {
//                $limits = explode(',', $limit, 2);
//                if (
//                    isset($limits[0]) && isset($limits[1])
//                    && is_numeric($limits[0])
//                    && is_numeric($limits[1])
//                ) {
//                    $db->limit($limits[0].','.$limits[1]);
//                }
//            } else {
//                $db->limit($limit);
//            }
//        }

        $re = $db->query();

        if( $key && strpos($fields,$key) !== false ){
            $tmp = array();
            foreach ($re as $value){
                $tmp[$value[$key]] = $value;
            }
            $re = $tmp;
        }

        // 计算分页信息
        if( $where ){
            $all_datas = $db->select($fields)->from($table_name)->where($where)->query();
        }else{
            $all_datas = $db->select($fields)->from($table_name)->query();
        }
        $num = count($all_datas);
        if( $num && is_numeric($num) ){
            $returnData = array(
                "current_page" => $page,
                "last_page"=> ceil($num/$size),
                "per_page"=> $size,
                "total"=> $num
            );
        }else{
            $returnData = array(
                "current_page" => $page,
                "last_page"=> 0,
                "per_page"=> 0,
                "total"=> 0
            );
        }
        $returnData['data'] = $re;

        return $returnData;
    }

    /**
     * 新建数据
     *
     * @param $data
     * @return mixed
     */
    public static function create($table_name,$data){
        $db = Connect::$instance;
        return $db->insert($table_name)->cols($data)->query();
    }

    /**
     * 更新数据
     *
     * @param $table_name
     * @param $update
     * @param $where
     * @return mixed
     */
    public static function update($table_name,$update,$where){
        $db = Connect::$instance;
        return $db->update($table_name)->cols($update)->where($where)->query();
    }

}