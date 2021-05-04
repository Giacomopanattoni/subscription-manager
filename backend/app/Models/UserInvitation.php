<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserInvitation extends Model
{
    use HasFactory;

    public function master(){
        return $this->belongsTo(User::class);
    }

    public function user(){
        return $this->belongsTo(User::class, 'invited_user_id');
    }

    public function subscription(){
        return $this->belongsTo(UserSubscription::class);
    }
}
