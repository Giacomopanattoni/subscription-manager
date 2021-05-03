<?php

namespace App\Console\Commands;

use App\Models\Currency;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class UpdateCurrency extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'update:currency';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Update currency table';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        $response = Http::get('http://api.exchangeratesapi.io/v1/latest?access_key=2c03ed0d9127e76f88cd9b5e7e399619&format=1');
        //dd($response);
        Log::debug($response->json()['rates']);
        foreach($response->json()['rates'] as $ticker => $currency){
            Log::debug($ticker);
            Currency::updateOrCreate([
                'ticker' => $ticker
            ],[
                'value' => $currency,
            ]);
        }
        return true;
    }
}
