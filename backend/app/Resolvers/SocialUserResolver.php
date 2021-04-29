<?php

namespace App\Resolvers;

use App\Http\Controllers\AuthController;
use App\Models\User;
use Coderello\SocialGrant\Resolvers\SocialUserResolverInterface;
use Exception;
use Illuminate\Contracts\Auth\Authenticatable;
use Illuminate\Support\Facades\Log;
use Laravel\Socialite\Facades\Socialite;

class SocialUserResolver implements SocialUserResolverInterface
{
    /**
     * Resolve user by provider credentials.
     *
     * @param string $provider
     * @param string $accessToken
     *
     * @return Authenticatable|null
     */
    public function resolveUserByProviderCredentials(string $provider, string $accessToken): ?Authenticatable
    {
        $providerUser = null;
        
        try {
            $providerUser = Socialite::driver($provider)->userFromToken($accessToken);
        } catch (Exception $exception) {
            Log::debug($exception);
        }
        
        if ($providerUser) {
            Log::debug($provider);
            $user = User::firstOrCreate(
                ['email' => $providerUser->email],
                [
                    'email_verified_at' => now(),
                    'name' => $providerUser->name,
                    'provider' => $provider
                ]
            );
            return $user;
        }

        return null;
    }
}