<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\DeviceController;
use App\Http\Controllers\NotificationController;
use App\Http\Controllers\SubscriptionController;
use App\Models\Currency;
use App\Models\User;
use App\Models\UserSubscription;
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

Route::get('test', function(Request $request){
    return UserSubscription::where('id',5)->first()->allUsers;
    return User::where('id',2)->with(['userSubscriptions','sharedSubscriptions','allSubscriptions'])->first();
});

Route::post('auth/register', [AuthController::class,'create']);
Route::post('auth/google', [AuthController::class,'googleLogin']);

Route::get('currencies', function(Request $request){
    return Currency::all();
});
Route::middleware('auth:api')->group(function () {

    Route::get('user', function (Request $request) {
        return $request->user();
    });

    Route::get('user-subscriptions', [SubscriptionController::class,'list']);
    Route::post('user-subscriptions/create', [SubscriptionController::class,'create']);
    Route::post('user-subscriptions/{subscription}', [SubscriptionController::class,'edit']);
    Route::post('user-subscriptions/{subscription}/invite', [SubscriptionController::class,'inviteUser']);
    Route::get('invitations', [SubscriptionController::class,'listInvitations']);
    Route::post('invitations/{invitation}', [SubscriptionController::class,'acceptInvitation']);
    Route::post('device/add', [DeviceController::class,'addDevice']);


});
