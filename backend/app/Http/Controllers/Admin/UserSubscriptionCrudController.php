<?php

namespace App\Http\Controllers\Admin;

use App\Http\Requests\UserSubscriptionRequest;
use Backpack\CRUD\app\Http\Controllers\CrudController;
use Backpack\CRUD\app\Library\CrudPanel\CrudPanelFacade as CRUD;

/**
 * Class UserSubscriptionCrudController
 * @package App\Http\Controllers\Admin
 * @property-read \Backpack\CRUD\app\Library\CrudPanel\CrudPanel $crud
 */
class UserSubscriptionCrudController extends CrudController
{
    use \Backpack\CRUD\app\Http\Controllers\Operations\ListOperation;
    use \Backpack\CRUD\app\Http\Controllers\Operations\CreateOperation;
    use \Backpack\CRUD\app\Http\Controllers\Operations\UpdateOperation;
    use \Backpack\CRUD\app\Http\Controllers\Operations\DeleteOperation;
    use \Backpack\CRUD\app\Http\Controllers\Operations\ShowOperation;

    /**
     * Configure the CrudPanel object. Apply settings to all operations.
     * 
     * @return void
     */
    public function setup()
    {
        CRUD::setModel(\App\Models\UserSubscription::class);
        CRUD::setRoute(config('backpack.base.route_prefix') . '/usersubscription');
        CRUD::setEntityNameStrings('usersubscription', 'user_subscriptions');
    }

    /**
     * Define what happens when the List operation is loaded.
     * 
     * @see  https://backpackforlaravel.com/docs/crud-operation-list-entries
     * @return void
     */
    protected function setupListOperation()
    {
        CRUD::column('user_id');
        CRUD::column('name');
        CRUD::column('price');
        CRUD::column('every_count');
        CRUD::column('every_item');
        CRUD::column('notify');
        CRUD::column('next_renewal');

        /**
         * Columns can be defined using the fluent syntax or array syntax:
         * - CRUD::column('price')->type('number');
         * - CRUD::addColumn(['name' => 'price', 'type' => 'number']); 
         */
    }

    /**
     * Define what happens when the Create operation is loaded.
     * 
     * @see https://backpackforlaravel.com/docs/crud-operation-create
     * @return void
     */
    protected function setupCreateOperation()
    {
        CRUD::setValidation(UserSubscriptionRequest::class);

        CRUD::field('user_id');
        CRUD::field('name');
        CRUD::field('price');
        CRUD::field('renewal_day');
        CRUD::field('every_count');
        CRUD::addField([
            'name'        => 'every_item', 
            'label'       => 'recurring', 
            'type'        => 'radio',
            'options'     => [ 
                'week' => "Week",
                'month' => "Month",
                'year' => "Year"
            ],
        ]);
        CRUD::addField([
            'name'  => 'from',
            'label' => 'Subscription init',
            'type'  => 'date'
        ]);
        CRUD::field('notify');

        /**
         * Fields can be defined using the fluent syntax or array syntax:
         * - CRUD::field('price')->type('number');
         * - CRUD::addField(['name' => 'price', 'type' => 'number'])); 
         */
    }

    /**
     * Define what happens when the Update operation is loaded.
     * 
     * @see https://backpackforlaravel.com/docs/crud-operation-update
     * @return void
     */
    protected function setupUpdateOperation()
    {
        $this->setupCreateOperation();
    }
}
