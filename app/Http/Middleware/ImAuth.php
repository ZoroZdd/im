<?php

namespace App\Http\Middleware;

use Closure;
// use Illuminate\Http\Request;

use Illuminate\Auth\Middleware\Authenticate as Middleware;

class ImAuth  extends Middleware
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
        //return 'aaa';
        if( !$request->header('app-id') ){
            return response()->json( responseArrayError(resCode(4002),4002) );
        }else{
            if( $request->header('app-id') != '666666' ){
                return response()->json( responseArrayError(resCode(4002),4002) );
            }
            // verify app-id  todo
            //return 'aa';
        }

        return $next($request);
    }
}
