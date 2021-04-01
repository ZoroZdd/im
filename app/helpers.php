<?php
/**
 * Created by PhpStorm.
 * User: zorozdd
 * Date: 2020/8/13
 * Time: 9:15 PM
 */


/**
 * 获取随机字符串
 * @param $length
 * @return bool|string
 */
function getRandStr($length){
    if($length<1){
        $length = 10;
    }
    $strs = "QWERTYUIOPASDFGHJKLZXCVBNM1234567890qwertyuiopasdfghjklzxcvbnm";
    $name = substr(str_shuffle($strs),mt_rand(0,strlen($strs)-11),$length);
    return $name;
}


function object_array($array) {
    if(is_object($array)) {
        $array = (array)$array;
    }
    if(is_array($array)) {
        foreach($array as $key=>$value) {
            $array[$key] = object_array($value);
        }
    }
    return $array;
}

/**
 * 字符串两次md5加密
 * @param $str
 * @return string
 */
function double_md5($str) {

    return md5(md5(trim($str)));
}
/**
 * 获取毫秒级别时间戳
 * @return float
 */
function getMillisecond() {
    list($t1, $t2) = explode(' ', microtime());
    return (float)sprintf('%.0f',(floatval($t1)+floatval($t2))*1000);
}
/**
 * 消息处理成功返回结果
 * @param $data
 * @return false|string
 */
function responseSuccess($data = null, $message = "ok")//: Response
{
    $responseData['code'] = 0;
    $responseData['message'] = $message;
    $responseData['data'] = $data;

    $responseData['request-id'] = \Request::header('Request-Id');
    return json_encode($responseData);
}

/**
 * 消息处理失败返回结果
 * @param $msg
 * @return false|string
 */
function responseError( $msg , $code = 1 )//: Response
{
    $responseData['code'] = $code ?: 1;
    $responseData['message'] = $msg;
    $responseData['data'] = null;
    $responseData['request-id'] = \Request::header('Request-Id');
    return json_encode($responseData);
}

/**
 * 消息处理成功返回结果
 * @param $data
 * @return false|string
 */
function responseArraySuccess( $data )//: Response
{
    $responseData['code'] = 0;
    $responseData['message'] = "ok";
    $responseData['data'] = $data;
    //return Context::mustGet()->getResponse()->withContent($responseData);
    return $responseData;
}

/**
 * 消息处理失败返回结果
 * @param $msg
 * @return false|string
 */
function responseArrayError( $msg , $code = 1 )//: Response
{
    $responseData['code'] = $code ?: 1;
    $responseData['message'] = $msg;
    $responseData['data'] = null;
    $responseData['request-id'] = \Request::header('Request-Id');

    return $responseData;
}


/**
 *
 * 请求IM专用接口
 *
 * @param $type
 * @param $url
 * @param $header
 * @param $data
 * @return bool|mixed
 */
function requestForIM( $type,$url,$header,$data ){
    // return json_encode($data);
    $ch = curl_init();

    switch( strtoupper($type) ){
        case 'POST':
            curl_setopt($ch, CURLOPT_URL, $url);

            curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");
            curl_setopt($ch, CURLOPT_POSTFIELDS,json_encode($data));
            curl_setopt($ch, CURLOPT_RETURNTRANSFER,true);

            $header[] ='Content-Type: application/json';
            $header[] ='Content-Length: ' . strlen(json_encode($data));
            // return $header;
            curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
            $result = curl_exec($ch);

        break;
        case 'DELETE':
            curl_setopt($ch, CURLOPT_URL, $url);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
            curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "DELETE");
            $header[] = ['X-HTTP-Method-Override: DELETE'];
            curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
            curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
            $result = curl_exec($ch);
        break;
        case 'GET':
            if($data){
                $url = $url.'?'.http_build_query($data);
            }
            curl_setopt($ch, CURLOPT_URL, $url);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
            curl_setopt($ch, CURLOPT_HEADER, 0);
            curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
            $result = curl_exec($ch);
            // $result = curl_error($ch);
        break;
        case 'PUT':
            curl_setopt($ch, CURLOPT_URL, $url);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
            curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "PUT");
            $header[] = ['X-HTTP-Method-Override: PUT'];
            $header[] = ['Content-Type: application/json'];
            $header[] = ['Content-Length: ' . strlen(json_encode($data))];
            curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
            curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));
            $result = curl_exec($ch);
        break;
        default:
            return false;
    }
    //$result = curl_error($ch);
    curl_close($ch);
    if( json_decode($result,true) ){
        return json_decode($result,true);
    }else{
        return false;
    }
}

/**
 * 返回状态码
 * @param $code
 * @return mixed
 */
function resCode($code){
    $code = (string)$code;
    $resCode = array(
        '0' => 'Success',
        '1' => 'Error',

        // 用户类
        '211' => '未知用户',
        '212' => 'unique_id 不符合要求',
        '213' => '当前用户被禁用',
        '214' => '密码错误',

        // im类
        '4001' => '参数缺失',
        '4002' => '头信息缺失',
        '4011' => '未知会话',
        '4405' => '错误的聊天类型',
        '4406' => '错误的参数格式',

        // 文件上传
        '4601' => '错误的文件格式',


    );

    return $resCode[$code] ?: '(^~^)!!!' ;
}