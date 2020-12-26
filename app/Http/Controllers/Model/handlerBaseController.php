<?php

namespace App\Http\Controllers\Model;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;
use GatewayClient\Gateway;


class handlerBaseController extends Controller
{

    public function __invoke()
    {
        Gateway::$registerAddress = env('GATEWAYADDRESS');
    }

    /**
     *
     * 单条获取
     *
     * @param string $lib
     * @param $table
     * @param $where
     * @return array
     */
    public static function getOne($lib = '',$table,$where){
        if( $lib ){
            $db = DB::connection($lib)->table($table);
        }else{
            $db = DB::table($table);
        }

        foreach ( $where as $key => $value ){
            if( !is_array($value) ){
                $db->where($key,$value);
            }else if ( count($value) == 2 ) {
                $db->where($value[0],$value[1]);
            }else if (  count($value) == 3 ){
                $db->where($value[0],$value[1],$value[2]);
            }
        }
        $res = $db->first();
        if($res){
            return get_object_vars($res);
        }
        return false;
    }

    /**
     * 批量获取
     *
     * @param string $lib
     * @param $table
     * @param $where
     * @param string $fields
     * @param array $order
     * @param null $limit
     * @return array
     */
    public static function getAll_xxxxx($lib = '',$table,$where,$fields='*',$order = array(),$limit = null){
        if( $lib ){
            $db = DB::connection($lib)->table($table);
        }else{
            $db = DB::table($table);
        }

        // 条件
        foreach ( $where as $value ){
            if ( count($value) == 2 ) {
                $db->where($value[0],$value[1]);
            }
            if (  count($value) == 3 ){
                $db->where($value[0],$value[1],$value[2]);
            }
        }
        unset($value);

        // 字段
        if( $fields=='*' ){
            $db->value($fields);
        }

        // 排序
        foreach ( $order as $value ){
            $db->orderBy($value[0],$value[1]);
        }
        unset($value);

        // 限制
        if( $limit ){
            $db->limit($limit);
        }


        DB::connection()->enableQueryLog();

        return $db->get();
//
//        return DB::getQueryLog();
        // return get_object_vars($db->get());
//        return array_map('get_object_vars', $db->get());

    }


    /**
     * @param array $where
     * @param string $order
     * @param string $keyIndex
     * @param array $whereIn
     * @param int $page
     * @param int $size
     * @return mixed
     */
    public static function getAll($lib = '',$table,$where = array(),$order = '',$keyIndex = '',$whereIn = array(),$page = 1,$size = 20,$fields = '*'){
        if( $lib ){
            $db = DB::connection($lib)->table($table);
        }else{
            $db = DB::table($table);
        }

        if( $where ){
            foreach ( $where as $value ){
                if ( count($value) == 2 ) {
                    $db->where($value[0],$value[1]);
                }
                if (  count($value) == 3 ){
                    $db->where($value[0],$value[1],$value[2]);
                }
            }
        }
        if( $whereIn ){
            foreach ( $whereIn as $k => $v ){
                $db->whereIn($k,$v);
            }
        }

        if( $order ){
            foreach ( $order as $k => $v ){
                $db->orderBy($k,$v);
            }
        }

        $db->value($fields);


        $result = $db->paginate($size,['*'], 'page', $page)->toJson();
        $result = json_decode($result,true);


        $result_temp = array();
        foreach ( $result['data'] as $key => $val ){
            // $val = object_array($val);
            //return $val;
            if( $keyIndex && isset($val[$keyIndex]) ){
                $result_temp[$val[$keyIndex]] = $val;
            }else{
                $result_temp[$key] = $val;
            }
        }
        $result['data'] = $result_temp;

        unset($result['first_page_url']);
        unset($result['last_page_url']);
        unset($result['next_page_url']);
        unset($result['path']);
        unset($result['prev_page_url']);
        unset($result['from']);
        unset($result['to']);

        return $result;
    }


    /**
     * 数据创建
     *
     * @param string $lib
     * @param $table
     * @param $data
     * @return bool
     */
    public static function create($lib = '',$table,$data){
        if( $lib ){
            $db = DB::connection($lib)->table($table);
        }else{
            $db = DB::table($table);
        }
        return $db->insertGetId($data);
    }


    /**
     * 数据更新
     * @param string $lib
     * @param $table
     * @param $data
     * @param $where
     * @return int\
     */
    public static function update($lib = '',$table,$data,$where){
        if( $lib ){
            $db = DB::connection($lib)->table($table);
        }else{
            $db = DB::table($table);
        }
        return $db->where($where)->update($data);
    }


}
