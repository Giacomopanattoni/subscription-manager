<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\SubscriptionController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/
Route::post('auth/register', [AuthController::class,'create']);
Route::middleware('auth:api')->group(function () {

    Route::get('user', function (Request $request) {
        return $request->user();
    });
   
    Route::get('user-subscriptions', [SubscriptionController::class,'list']);
    Route::post('user-subscriptions/create', [SubscriptionController::class,'create']);
   




});