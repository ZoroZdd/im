<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});


Route::any('/user', 'UserController@index')->name('profile');



Route::middleware(['test'])->group(function () {
    Route::any('/test', 'testController@index')->name('test1');
});

/**
 *  IM API接口
 */
Route::prefix('im')->middleware(['ImAuth'])->group(function () {
    // 用户测试
    Route::get('/user/test', 'IM\\UserController@test');

    // 创建会话
    Route::post('/conversations', 'IM\\IMController@createConv')->name('createConv');
    // 查询会话
    Route::get('/conversations', 'IM\\IMController@getConv')->name('getConv');
    // 修改会话
    Route::put('/conversations', 'IM\\IMController@updateConv')->name('updateConv');
    // 删除会话
    Route::delete('/conversations/{conv_id}', 'IM\\IMController@delConv')->name('delConv');

    // 添加用户
    Route::post('/conversations/{conv_id}/members', 'IM\\IMController@addMember')->name('addMember');
    // 移除用户
    Route::delete('/conversations/{conv_id}/members', 'IM\\IMController@removeMember')->name('removeMember');
    // 查询用户
    Route::get('/conversations/{conv_id}/members', 'IM\\IMController@getMembers')->name('getMembers');

    // 发送信息
    Route::post('/conversations/{conv_id}/message', 'IM\\IMController@sendMsg')->name('sendMsg');
    // 获取消息列表
    Route::get('/conversations/{conv_id}/message', 'IM\\IMController@getChatMsgs')->name('getChatMsgs');


    // 文件上传
    Route::post('/file/upload', 'IM\\UploadController@uploadImage')->name('uploadImage');
});

/**
 *  商户测试用接口
 */
Route::prefix('api')->group(function () {
    // 用户信息获取
    Route::get('/user/userInfo', 'API\\User\\UserController@userInfo');
    // 用户注册
    Route::post('/user/register', 'API\\User\\UserController@register');
    // 用户登录
    Route::post('/user/login', 'API\\User\\UserController@login');
    // 获取会话列表
    Route::get('/im/getconvlist', 'API\\IM\\IMController@getConvList');
    // 获取聊天记录
    Route::get('/im/getChatMsgs', 'API\\IM\\IMController@getChatMsgs');
    // 创建会话
    Route::post('/im/createconv', 'API\\IM\\IMController@createConv');

    // 获取成员
    Route::get('/im/members', 'API\\User\\UserController@getUserListByConvid');
});

/**
 * 后台路由
 */
Route::prefix('admin')->middleware(['ImAdminAuth'])->group(function () {
    Route::get('/login', 'Admin\\LoginController@login');
    Route::post('/login_do', 'Admin\\LoginController@login_do');
    // 后台主页
    Route::get('/index', 'Admin\\LoginController@index');
    Route::get('/test', 'Admin\\LoginController@test');
    // 后台主页
    Route::get('/start', 'Admin\\LoginController@start');
    // 用户列表
    Route::get('/User/userlist', 'Admin\\UserController@userlist');
});




