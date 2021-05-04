<?php

namespace App\Http\Controllers;

use App\Models\UserSubscription;
use Illuminate\Http\Request;

class SubscriptionController extends Controller
{

    private roles = [
        'sub_admin',
        'sub_user'
    ];

    public function create(Request $request){

        $request->validate([
            'name' => 'required|string|max:255',
            'price' => 'required|numeric',
            'renewal_day' => 'required|numeric',
            'every_count' => 'required|numeric',
            'every_item' => 'required|string|in:week,month,year',
            'from' => 'required|date',
            'notify' => 'required|bool',
        ]);
        $subscription = new UserSubscription();
        $subscription->name = $request->post('name');
        $subscription->user_id = $request->user()->id;
        $subscription->price = $request->post('price');
        $subscription->renewal_day = $request->post('renewal_day');
        $subscription->every_count = $request->post('every_count');
        $subscription->every_item = $request->post('every_item');
        $subscription->from = $request->post('from');
        $subscription->notify = $request->post('notify');
        $subscription->save();
        return $this->jsonResponse(true,$subscription);
    }

    public function list(Request $request){
        return $this->jsonResponse(true,$request->user()->subscriptions);
    }

    public function delete(UserSubscription $subscription,Request $request){
        //TODO only master can delete
        $userPermission = getUserPermissions($request->user(),$subscription);
        if(!$userPermission){
            return $this->jsonResponse(false,[
                'message' => 'Non puoi eliminare questa subscription'
            ])
        }
        if($userPermission == $this->roles[0] && $subscription->delete()){
            return $this->jsonResponse(true,'Abbonamento eliminato con successo');
        }
        if($userPermission == $this->roles[1]){
            $subscription->userInvitations()->where('invited_user_id',$request->user()->id)->first()->delete();
            return $this->jsonResponse(true,'Abbonamento eliminato con successo');
        }
    }

    public function edit (UserSubscription $subscription, Request $request){
        //TODO: only subscription users can edit
        $userPermission = getUserPermissions($request->user(),$subscription);
        if($userPermission != $this->roles[0]){
            return $this->jsonResponse(false,[
                'message' => 'Non puoi modificare i dati di questa subscription'
            ])
        }
        $validation = $request->validate([
            'name' => 'required|string|max:255',
            'price' => 'required|numeric',
            'renewal_day' => 'required|numeric',
            'every_count' => 'required|numeric',
            'every_item' => 'required|string|in:week,month,year',
            'from' => 'required|date',
            'notify' => 'required|bool',
        ]);

        $subscription->name = $request->post('name');
        $subscription->user_id = $request->user()->id;
        $subscription->price = $request->post('price');
        $subscription->renewal_day = $request->post('renewal_day');
        $subscription->every_count = $request->post('every_count');
        $subscription->every_item = $request->post('every_item');
        $subscription->from = $request->post('from');
        $subscription->notify = $request->post('notify');
        $subscription->save();
        return $this->jsonResponse(true,$subscription);
    }

    public function jsonResponse($success, $data){
        if(!$success){
            return response()->json([
                'status' => 'error',
                'data' => $data
            ],403);
        }else{
            return response()->json([
                'status' => 'success',
                'data' => $data
            ],200);
        }
    }

    public function getUserPermissions(User $user, UserSubscription $subscription){
        if($subscription->user_id == $user->id){
            return 'sub_admin';
        }
        if($subscription->userInvitations()->where('invited_user_id',$user->id)->first()){
            return 'sub_user';
        }
        return null;
    }
}
