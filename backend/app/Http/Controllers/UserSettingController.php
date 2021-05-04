<?php

namespace App\Http\Controllers;

use App\Models\Currency;
use App\Models\UserSetting;
use Illuminate\Http\Request;

class UserSettingController extends Controller
{
    public function getSettings(Request $request)
    {
        $userSettings = UserSetting::where('user_id', $request->user()->id)->with('currency')->first();
        if ($userSettings){
            return $this->jsonResponse(true, $userSettings);
        }else{
            $userSettings = new UserSetting();
            $userSettings->user_id =  $request->user()->id;
            $userSettings->language = 'en';
            $userSettings->currency_id = Currency::select('id')->where('ticker','USD')->first()->id;
            $userSettings->save();
            return $this->jsonResponse(true, $userSettings);
        }
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
}
