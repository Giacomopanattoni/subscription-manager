<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Collection;

class UserSubscription extends Model
{
    use \Backpack\CRUD\app\Models\Traits\CrudTrait;
    use HasFactory;

    protected $table='user_subscriptions';

    protected $fillable = [
        'user_id',
        'name',
        'price',
        'renewal_day',
        'every_count',
        'every_item',
        'from',
        'notify'
    ];

    public function user(){
        return $this->belongsTo(User::class);
    }

    public function getAllUsersAttribute(){
        $user = collect([$this->user]);
        return $this->invitedUsers->merge($user);
    }

    public function userInvitations(){
        return $this->hasMany(UserInvitation::class);
    }

    public function invitedUsers(){
        return $this->hasManyThrough(User::class, UserInvitation::class,'user_subscription_id','id','id','invited_user_id');
    }

    public function category(){
        return $this->belongsTo(Category::class);
    }
}
