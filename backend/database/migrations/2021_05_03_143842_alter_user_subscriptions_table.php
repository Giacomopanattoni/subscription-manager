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
            $table->dropColumn('every_item');
        });
        Schema::table('user_subscriptions', function (Blueprint $table) {
            $table->date('next_renewal')->nullable()->after('notify');
            $table->date('last_renewal')->nullable()->after('notify');
            $table->enum('every_item', array('week', 'month', 'year'))->after('every_count');
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
            $table->dropColumn('every_item');
        });
        Schema::table('user_subscriptions', function (Blueprint $table) {
            $table->dropColumn(['next_renewal', 'last_renewal']);
            $table->enum('every_item', array('day', 'month', 'year'));
        });
    }
}
