<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Lowongan extends Model
{

    protected $table = 'lowongan';

    protected $fillable = ['posisi', 'skill', 'jobdesc'];

    public $timestamps = false;

}