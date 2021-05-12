<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\UserSubscription;
use App\Models\UserInvitation;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class SubscriptionController extends Controller
{

    private $roles = [
        'sub_admin',
        'sub_user'
    ];

    public function create(Request $request)
    {

        $request->validate([
            'name' => 'required|string|max:255',
            'price' => 'required|numeric',
            'renewal_day' => 'required|numeric',
            'every_count' => 'required|numeric',
            'every_item' => 'required|string|in:week,month,year',
            'from' => 'required|date',
            'notify' => 'required|bool',
            'color' => 'required|string',
            'category_id' => 'exist:categories,id',
            'image' => 'string',
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
        $subscription->color = $request->post('color');
        $subscription->category_id = $request->post('category_id');
        if ($request->post('image')) {
            $subscription->image = $request->post('image');
        }
        $subscription->save();
        return $this->jsonResponse(true, $subscription);
    }

    public function list(Request $request)
    {
        return $this->jsonResponse(true, $request->user()->subscriptions);
    }

    public function delete(UserSubscription $subscription, Request $request)
    {

        $userPermission = $this->getUserPermissions($request->user(), $subscription);
        if (!$userPermission) {
            return $this->jsonResponse(false, [
                'message' => 'Non puoi eliminare questa subscription'
            ]);
        }
        if ($userPermission == $this->roles[0] && $subscription->delete()) {
            return $this->jsonResponse(true, 'Abbonamento eliminato con successo');
        }
        if ($userPermission == $this->roles[1]) {
            $subscription->userInvitations()->where('invited_user_id', $request->user()->id)->first()->delete();
            return $this->jsonResponse(true, 'Abbonamento eliminato con successo');
        }
    }

    public function edit(UserSubscription $subscription, Request $request)
    {

        $userPermission = $this->getUserPermissions($request->user(), $subscription);
        if ($userPermission != $this->roles[0]) {
            return $this->jsonResponse(false, [
                'message' => 'Non puoi modificare i dati di questa subscription'
            ]);
        }
        $validation = $request->validate([
            'name' => 'required|string|max:255',
            'price' => 'required|numeric',
            'renewal_day' => 'required|numeric',
            'every_count' => 'required|numeric',
            'every_item' => 'required|string|in:week,month,year',
            'from' => 'required|date',
            'notify' => 'required|bool',
            'color' => 'required|string',
            'category_id' => 'exist:categories,id',
            'image' => 'string',
        ]);

        $subscription->name = $request->post('name');
        $subscription->user_id = $request->user()->id;
        $subscription->price = $request->post('price');
        $subscription->renewal_day = $request->post('renewal_day');
        $subscription->every_count = $request->post('every_count');
        $subscription->every_item = $request->post('every_item');
        $subscription->from = $request->post('from');
        $subscription->notify = $request->post('notify');
        $subscription->color = $request->post('color');
        $subscription->category_id = $request->post('category_id');
        if ($request->post('image')) {
            $subscription->image = $request->post('image');
        }

        $subscription->save();
        return $this->jsonResponse(true, $subscription);
    }

    public function listInvitations(Request $request)
    {
        $invitations = UserInvitation::where([
            ['invited_user_id', Auth::user()->id],
            ['accepted', 0]
        ])->get();
        return $this->jsonResponse(true, $invitations);
    }

    public function inviteUser(UserSubscription $subscription, Request $request)
    {
        $request->validate([
            'email' => 'required|email|max:255',
        ]);
        $permissions = $this->getUserPermissions($request->user(), $subscription);
        if ($permissions != $this->roles[0]) {
            return $this->jsonResponse(false, [
                'message' => 'Non puoi invitare persone in questa subscription'
            ]);
        }
        $email = request()->post('email');
        $invitedUser = User::where('email', $email)->first();
        if (!$invitedUser) {
            return $this->jsonResponse(false, [
                'message' => 'Non esiste nessun utente con questa mail'
            ]);
        }
        if (UserInvitation::where([
            ['invited_user_id', $invitedUser->id],
            ['user_subscription_id', $subscription->id]
        ])->first()) {
            return $this->jsonResponse(true, [
                'message' => 'Invito inviato con successo'
            ]);
        }
        $invitation = new UserInvitation();
        $invitation->user_id = Auth::user()->id;
        $invitation->invited_user_id = $invitedUser->id;
        $invitation->user_subscription_id = $subscription->id;
        $invitation->accepted = 0;
        if ($invitation->save()) {
            return $this->jsonResponse(true, [
                'message' => 'Invito inviato con successo'
            ]);
        }
        return $this->jsonResponse(false, [
            'message' => 'Si é verificato un errore, riprova'
        ]);
    }

    public function acceptInvitation(UserInvitation $invitation, Request $request)
    {
        $request->validate([
            'accept' => 'required|bool',
        ]);
        if ($invitation->invited_user_id == Auth::user()->id) {
            if ($request->post('accept')) {
                $invitation->accepted = 1;
                $invitation->save();
                return $this->jsonResponse(true, [
                    'message' => 'Richiesta accettata con successo'
                ]);
            } else {
                $invitation->delete();
                return $this->jsonResponse(true, [
                    'message' => 'Richiesta rifiutata con successo'
                ]);
            }
        }
        return $this->jsonResponse(false, [
            'message' => 'Non puoi unirti a questa subscription'
        ]);
    }

    public function jsonResponse($success, $data)
    {
        if (!$success) {
            return response()->json([
                'status' => 'error',
                'data' => $data
            ], 403);
        } else {
            return response()->json([
                'status' => 'success',
                'data' => $data
            ], 200);
        }
    }

    public function getUserPermissions(User $user, UserSubscription $subscription)
    {
        if ($subscription->user_id == $user->id) {
            return 'sub_admin';
        }
        if ($subscription->userInvitations()->where('invited_user_id', $user->id)->first()) {
            return 'sub_user';
        }
        return null;
    }
}
