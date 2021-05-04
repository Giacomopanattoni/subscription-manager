<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\UserSubscription;
use Carbon\Carbon;
use Illuminate\Support\Facades\Date;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class NotificationController extends Controller
{
    public function notifyUser(User $user, $title, $message = "")
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

    public function checkTodayNotifications()
    {
        $subscriptions = UserSubscription::where([
            ['next_renewal', Carbon::now()->toDateString()],
            ['notify', 1]
        ])->take(100)->with('user')->get();

        foreach ($subscriptions as $subscription) {
            $this->notifyUser($subscription->user, 'rinnovo abbonamento' . $subscription->name);
            $subscription->last_renewal = $subscription->next_renewal;
            $subscription->next_renewal = NULL;
            $subscription->save();
        }
    }

    public function calculateNextRenewal()
    {
        Log::debug('calculating renewal');
        $subscriptions = UserSubscription::where('next_renewal', null)->take(100)->get();

        foreach ($subscriptions as $subscription) {
            $next = $this->getNextRenewal($subscription);
            $subscription->next_renewal = $next;
            $subscription->save();
        }
    }

    private function getNextRenewal(UserSubscription $subscription)
    {

        $startDate = null;
        if ($subscription->last_renewal != null) {
            $startDate = new Carbon($subscription->last_renewal);
        } else {
            $startDate = new Carbon($subscription->from);
        }
        $startDate->day($subscription->renewal_day);
        switch ($subscription->every_item) {
            case 'week':
                while ($startDate <= Carbon::today()) {
                    $startDate->addWeeks($subscription->every_count);
                }
                return $startDate->isoFormat('Y-M-D');
                break;

            case 'month':
                while ($startDate <= Carbon::today()) {
                    $startDate->addMonths($subscription->every_count);
                }
                return $startDate->isoFormat('Y-M-D');
                break;

            case 'year':
                while ($startDate <= Carbon::today()) {
                    $startDate->addYears($subscription->every_count);
                }
                return $startDate->isoFormat('Y-M-D');
                break;
        }
    }
}
