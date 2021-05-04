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

    public function listInvitations(Request $request){
        $invitations = UserInvitation::where([
            ['invited_user_id',Auth::user()],
            ['accepted',0]
        ])->with('subscription')->get();
        return jsonResponse(true,$invitations);
    }

    public function inviteUser(UserSubscription $subscription, Request $request){
        $request->validate([
            'email' => 'required|email|max:255',
        ]);
        $permissions = getUserPermissions(Auth::user(),$subscription);
        if($userPermission != $this->roles[0]){
            return $this->jsonResponse(false,[
                'message' => 'Non puoi invitare persone in questa subscription'
            ])
        }
        $email = request()->post('email');
        $invitedUser = User::where('email',$email)->first();
        if(!$invitedUser){
            return $this->jsonResponse(false,[
                'message' => 'Non esiste nessun utente con questa mail'
            ])
        }
        $invitation = new UserInvitation();
        $invitation->user_id = Auth::user()->id;
        $invitation->invited_user_id = $invitedUser->id;
        $invitation->user_subscription_id = $subscription->id;
        $invitation->accepted = 0;
        if($invitation->save()){
            return $this->jsonResponse(true,[
                'message' => 'Invito inviato con successo'
            ])
        }
        return $this->jsonResponse(false,[
            'message' => 'Si é verificato un errore, riprova'
        ])
    }

    public function acceptInvitation(UserInvitation $invitation, Request $request){
        $request->validate([
            'accept' => 'required|bool',
        ]);
        if($invitation->invited_user_id == Auth::user()->id){
            if($request->post('accept')){
                $invitation->accepted = 1;
                $invitation->save();
                return $this->jsonResponse(true,[
                    'message' => 'Richiesta accettata con successo'
                ])
            }else{
                $invitation->delete();
                return $this->jsonResponse(true,[
                    'message' => 'Richiesta rifiutata con successo'
                ])
            }
        }
        return $this->jsonResponse(false,[
            'message' => 'Non puoi unirti a questa subscription'
        ])
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
