<?php

/** @var \Laravel\Lumen\Routing\Router $router */

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It is a breeze. Simply tell Lumen the URIs it should respond to
| and give it the Closure to call when that URI is requested.
|
*/

$router->get('/', function () use ($router) {
    return $router->app->version();
});

$router->post('/registrasi',['uses'=>'RegistrasiController@registrasi']);
$router->post('/login',['uses'=>'LoginController@login']);
$router->group(['prefix' => 'lowongan'], function ($router) {
    $router->post('/', ['uses' => 'LowonganController@create']);
    $router->get('/', ['uses' => 'LowonganController@list']);
    $router->get('/{id}', ['uses' => 'LowonganController@show']);
    $router->post('/{id}/update', ['uses' => 'LowonganController@update']);
    $router->delete('/{id}', ['uses' => 'LowonganController@delete']);
});