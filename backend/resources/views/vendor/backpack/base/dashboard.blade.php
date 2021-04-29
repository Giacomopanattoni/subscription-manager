@extends(backpack_view('blank'))

@php
    $widgets['before_content'][] = [
        'type'        => 'jumbotron',
        'heading'     => trans('backpack::base.welcome'),
        'content'     => trans('backpack::base.use_sidebar'),
        'button_link' => backpack_url('logout'),
        'button_text' => trans('backpack::base.logout'),
    ];
    Widget::add([ 
    'type'       => 'chart',
    'controller' => \App\Http\Controllers\Admin\Charts\UsersChartController::class,

    // OPTIONALS

    // 'class'   => 'card mb-2',
    // 'wrapper' => ['class'=> 'col-md-6'] ,
    // 'content' => [
         // 'header' => 'New Users', 
         // 'body'   => 'This chart should make it obvious how many new users have signed up in the past 7 days.<br><br>',
    // ],
]);

Widget::add([ 
    'type'       => 'chart',
    'controller' => \App\Http\Controllers\Admin\Charts\UsersChartController::class,

    // OPTIONALS

    // 'class'   => 'card mb-2',
    // 'wrapper' => ['class'=> 'col-md-6'] ,
    // 'content' => [
         // 'header' => 'New Users', 
         // 'body'   => 'This chart should make it obvious how many new users have signed up in the past 7 days.<br><br>',
    // ],
]);
@endphp

@section('content')
  <p>Your custom HTML can live here</p>
@endsection
