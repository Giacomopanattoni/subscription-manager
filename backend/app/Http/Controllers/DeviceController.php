<?php

namespace App\Http\Controllers;

use App\Models\Device;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class DeviceController extends Controller
{
    public function addDevice(Request $request)
    {
        $request->validate([
            'token' => 'required|string|max:300',
        ]);
        $user = Auth::user()->id;
        $token = $request->post('token');
        if ($device = Device::firstOrCreate([
            'user_id' => $user,
            'token' => $token
        ])) {
            return $this->jsonResponse(true, $device);
        } else {
            return $this->jsonResponse(false, [
                'message' => 'si é verificato un errore durante il salvataggio del token, riprova'
            ]);
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
