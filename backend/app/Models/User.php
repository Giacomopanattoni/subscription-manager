<?php

namespace App\Models;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Illuminate\Support\Facades\Hash;
use Laravel\Passport\HasApiTokens;
use Spatie\Permission\Traits\HasRoles;

class User extends Authenticatable
{
    use \Backpack\CRUD\app\Models\Traits\CrudTrait;
    use HasApiTokens, HasFactory, Notifiable, HasRoles;


    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name',
        'email',
        'password',
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
    ];

    public function userSubscriptions(){
        return $this->hasMany(UserSubscription::class);
    } 

    public function sharedSubscriptions(){
        return $this->hasManyThrough(UserSubscription::class, UserInvitation::class,'invited_user_id','id','id','user_subscription_id');
    }

    public function getSubscriptionsAttribute(){
        return $this->sharedSubscriptions->merge($this->userSubscriptions);
    }

    public function userInvitations(){
        return $this->hasMany(UserInvitation::class);
    } 

    public function devices(){
        return $this->hasMany(Device::class);
    }

}
