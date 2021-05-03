<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AlterUserSubscriptionsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('user_subscriptions', function (Blueprint $table) {
            $table->date('next_renewal')->nullable();
            $table->date('last_renewal')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('user_subscriptions', function (Blueprint $table) {
            $table->dropColumn(['next_renewal','last_renewal']);
        });
    }
}
