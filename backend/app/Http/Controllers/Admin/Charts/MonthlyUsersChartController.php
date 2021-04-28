<?php

namespace App\Http\Controllers\Admin\Charts;

use App\Models\User;
use App\Models\UserSubscription;
use Backpack\CRUD\app\Http\Controllers\ChartController;
use ConsoleTVs\Charts\Classes\Chartjs\Chart;

/**
 * Class MonthlyUsersChartController
 * @package App\Http\Controllers\Admin\Charts
 * @property-read \Backpack\CRUD\app\Library\CrudPanel\CrudPanel $crud
 */
class MonthlyUsersChartController extends ChartController
{
    public function setup()
    {
        $this->chart = new Chart();

        // MANDATORY. Set the labels for the dataset points
        $labels = [];
        for ($days_backwards = 30; $days_backwards >= 0; $days_backwards--) {
            if ($days_backwards == 1) {
            }
            $labels[] = $days_backwards.' days ago';
        }
        $this->chart->labels($labels);

        // RECOMMENDED. 
        // Set URL that the ChartJS library should call, to get its data using AJAX.
        $this->chart->load(backpack_url('charts/new-entries'));

        // OPTIONAL.
        $this->chart->minimalist(false);
        $this->chart->displayLegend(true);

    }

    /**
     * Respond to AJAX calls with all the chart data points.
     *
     * @return json
     */
    public function data()
    {
        for ($days_backwards = 30; $days_backwards >= 0; $days_backwards--) {
            // Could also be an array_push if using an array rather than a collection.
            $users[] = User::whereDate('created_at', today()
                ->subDays($days_backwards))
                ->count();
            $subscriptions[] = UserSubscription::whereDate('created_at', today()
                ->subDays($days_backwards))
                ->count();
           
        }

        $this->chart->dataset('Users', 'line', $users)
            ->color('rgb(77, 189, 116)')
            ->backgroundColor('rgba(77, 189, 116, 0.4)');

        $this->chart->dataset('Subscriptions', 'line', $subscriptions)
            ->color('rgb(96, 92, 168)')
            ->backgroundColor('rgba(96, 92, 168, 0.4)');

    }
}