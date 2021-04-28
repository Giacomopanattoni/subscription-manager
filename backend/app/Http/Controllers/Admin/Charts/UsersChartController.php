<?php

namespace App\Http\Controllers\Admin\Charts;

use App\Models\User;
use Backpack\CRUD\app\Http\Controllers\ChartController;
use ConsoleTVs\Charts\Classes\Chartjs\Chart;

/**
 * Class UsersChartController
 * @package App\Http\Controllers\Admin\Charts
 * @property-read \Backpack\CRUD\app\Library\CrudPanel\CrudPanel $crud
 */
class UsersChartController extends ChartController
{
    public function setup()
    {
        $this->chart = new Chart();
        $count = User::all()->count();
        // MANDATORY. Set the labels for the dataset points
        $this->chart->labels(['Users']);
        // dd($count);
        $this->chart->dataset('Active Users', 'bar', [$count]) 
        ->color('rgba(205, 32, 31, 1)')
        ->backgroundColor('rgba(205, 32, 31, 0.4)');
        // OPTIONAL
        $this->chart->minimalist(false);
        // $this->chart->displayLegend(true);
    }
}