<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class NotificationController extends Controller
{
    public function notifyUser(User $user, $title, $message)
    {
        $tokens = $user->devices()->select('token')->get()->pluck('token');

        Log::debug($tokens);
        Log::debug(env('FIREBASE_KEY'));
        if (count($tokens) > 0) {
            try {
                $response = Http::withHeaders([
                    'Accept' => 'Application/json',
                    'Authorization' => 'key=' . env('FIREBASE_KEY')
                ])->post('https://fcm.googleapis.com/fcm/send', [
                    'registration_ids' => $tokens,
                    'notification' => [
                        'title' => $title,
                        'text' => $message
                    ]
                ]);
                Log::debug($response);
            } catch (\Throwable $th) {
                Log::error($th);
            }
        }
    }
}
