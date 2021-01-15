<?php

namespace App\Http\Controllers\IM;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Http\Controllers\Model\handlerBaseController;

class UploadController extends handlerBaseController
{
    public function toUpload(){
        // return view("admin.upload.uploadImage");
    }

    /**
     * 文件上传
     *
     * @param Request $request
     * @return false|string
     */
    public function uploadImage(Request $request){
        if($request->hasFile('file')&&$request->file('file')->isValid()){
            $file=$request->file('file');
            $allowed_extensions = ["png", "jpg", "gif"];
            if (!in_array($file->getClientOriginalExtension(), $allowed_extensions)) {
                // dd('只能上传png,jpg和gif格式的图片.');
                return responseError(resCode(4601),4601);

            }else{
                $destinationPath = 'storage/uploads/'; //public 文件夹下面建 storage/uploads 文件夹
                $extension = $file->getClientOriginalExtension();
                $fileName=md5(time().rand(1,1000)).'.'.$extension;
                $file->move($destinationPath,$fileName);
                $filePath = asset($destinationPath.$fileName);
                // dd("文件路径：".asset($destinationPath.$fileName));
                //var_dump($destinationPath.$fileName);return;
                return responseSuccess(array("img_host"=>"http:127.0.0.1","file_url"=>$destinationPath.$fileName));
                return responseSuccess(asset($destinationPath.$fileName));
            }
        }else{
            return responseError(resCode(4601),4601);
        }
    }
}
