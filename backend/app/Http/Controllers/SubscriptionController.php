<?php

namespace App\Http\Controllers;

use App\Models\UserSubscription;
use Illuminate\Http\Request;

class SubscriptionController extends Controller
{
    public function create(Request $request){

        $request->validate([
            'name' => 'required|string|max:255',
            'price' => 'required|numeric',
            'renewal_day' => 'required|numeric',
            'every_count' => 'required|numeric',
            'every_item' => 'required|string|in:day,month,year',
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
        return $this->jsonResponse(true,$request->user()->userSubscriptions()->get());
    }

    public function delete(UserSubscription $subscription){

        if($subscription->delete()){
            return $this->jsonResponse(true,'Abbonamento eliminato con successo');
        }
    }

    public function edit (UserSubscription $subscription, Request $request){
        $validation = $request->validate([
            'name' => 'required|string|max:255',
            'price' => 'required|numeric',
            'renewal_day' => 'required|numeric',
            'every_count' => 'required|numeric',
            'every_item' => 'required|string|in:day,month,year',
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
}
