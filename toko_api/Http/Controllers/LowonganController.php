<?php

namespace App\Http\Controllers;

use App\Models\Lowongan;
use Illuminate\Http\Request;

class LowonganController extends Controller
{
    public function create(Request $request)
    {
        $posisi = $request->input('posisi');
        $skill = $request->input('skill');
        $jobdesc = $request->input('jobdesc');

        $lowongan =lowongan :: create([
            'posisi' => $posisi,
            'skill' => $skill,
            'jobdesc' => $jobdesc,
    
        ]);
        return $this->responseHasil(200, true, $lowongan);
    }

    public function list()
    {
        $lowongan = lowongan :: all();
        return $this->responseHasil(200, true, $lowongan);
    }

    public function show($id)
    {
        $lowongan = lowongan::findOrFail($id);
        return $this->responseHasil(200, true, $lowongan);
    }

    public function update(Request $request, $id)
    {
        $posisi = $request->input('posisi');
        $skill = $request->input('skill');
        $jobdesc = $request->input('jobdesc');

        $lowongan = lowongan::findOrFail($id);
        $result = $lowongan->update([
            'posisi' => $posisi,
            'skill' => $skill,
            'jobdesc' => $jobdesc,
        ]);
        return $this->responseHasil(200, true, $result);
    }

    public function delete($id)
    {
        $lowongan = lowongan::findOrFail($id);
        $delete = $lowongan->delete();
        return $this->responseHasil(200, true, $delete);
    }
}