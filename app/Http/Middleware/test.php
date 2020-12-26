<?php

namespace App\Http\Middleware;

use Closure;

use Illuminate\Auth\Middleware\Authenticate as Middleware;

class test  extends Middleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {

        if ( isset($request->name) && empty($request->name) ){
            echo 'xx1';
            return;
        }else{
            echo 'xx2';
        }
        return $next($request);
    }
}
