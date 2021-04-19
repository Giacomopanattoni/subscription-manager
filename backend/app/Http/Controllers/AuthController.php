<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Route;
use Laravel\Passport\Client;

class AuthController extends Controller
{
    function create(Request $request)
{
    /**
     * Get a validator for an incoming registration request.
     *
     * @param  array  $request
     * @return \Illuminate\Contracts\Validation\Validator
     */
    $valid = validator($request->only('email', 'name', 'password'), [
        'name' => 'required|string|max:255',
        'email' => 'required|string|email|max:255|unique:users',
        'password' => 'required|string|min:6',
    ]);

    if ($valid->fails()) {
        $jsonError=response()->json($valid->errors()->all(), 400);
        return response()->json($jsonError, 403);
    }

    $data = request()->only('email','name','password');

    $user = User::create([
        'name' => $data['name'],
        'email' => $data['email'],
        'password' => Hash::make($data['password']),
    ]);
    return $user;
    $client = Client::where('password_client', 1)->first();

    $request->request->add([
        'grant_type'    => 'password',
        'client_id'     => $client->id,
        'client_secret' => $client->secret,
        'username'      => $data['email'],
        'password'      => $data['password'],
        'scope'         => null,
    ]);

    $token = Request::create(
        'oauth/token',
        'POST'
    );

    return Route::dispatch($token);
}
}
