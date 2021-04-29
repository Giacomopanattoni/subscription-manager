<?php

namespace App\Http\Controllers;

use App\Models\User;
use Carbon\Carbon;
use DateTimeImmutable;
use Google_Client;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Route;
use Laravel\Socialite\Facades\Socialite;

use DateTime;
use Illuminate\Events\Dispatcher;
use Laravel\Passport\Bridge\AccessToken;
use Laravel\Passport\Bridge\AccessTokenRepository;
use Laravel\Passport\Bridge\Client;
use Laravel\Passport\Bridge\RefreshToken;
use Laravel\Passport\Bridge\RefreshTokenRepository;
use Laravel\Passport\Passport;
use Laravel\Passport\Token;
use Laravel\Passport\TokenRepository;
use League\OAuth2\Server\CryptKey;
use League\OAuth2\Server\Entities\AccessTokenEntityInterface;
use League\OAuth2\Server\Exception\OAuthServerException;
use League\OAuth2\Server\Exception\UniqueTokenIdentifierConstraintViolationException;
use League\OAuth2\Server\ResponseTypes\BearerTokenResponse;

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
            $jsonError = response()->json($valid->errors()->all(), 400);
            return response()->json($jsonError, 403);
        }

        $data = request()->only('email', 'name', 'password');

        $user = User::create([
            'name' => $data['name'],
            'email' => $data['email'],
            'password' => Hash::make($data['password']),
        ]);

        $user->assignRole('user');

        return response()->json([
            'status' => "success",
            'data' => $user
        ], 200);
    }

    public function googleLogin()
    {
        $googleUser = Socialite::driver('google')->stateless()->userFromToken(request()->token);
        
        $user = User::firstOrCreate(
            ['email' => $googleUser->email],
            [
                'email_verified_at' => now(),
                'name' => $googleUser->name,
            ]
        );
        return $user;
        /* $token = $user->createToken('password');
        
        return [
            'access_token' => $token,
        ]; */
        
    }

    private function getUserAndToken(User $user, $device_name)
    {
        return [
            'User' => $user,
            'Access-Token' => $user->createToken($device_name)->plainTextToken,
        ];
    }
}
