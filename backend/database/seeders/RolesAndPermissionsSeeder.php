<?php

namespace Database\Seeders;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;
use Illuminate\Database\Seeder;

class RolesAndPermissionsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        app()[\Spatie\Permission\PermissionRegistrar::class]->forgetCachedPermissions();

        Permission::create(['name' => 'backoffice']);
        Permission::create(['name' => 'app']);
        $role = Role::create(['name' => 'admin']);
        $role->givePermissionTo('backoffice');
        $role->givePermissionTo('app');
        $role = Role::create(['name' => 'user']);
        $role->givePermissionTo('app');
    }
}
