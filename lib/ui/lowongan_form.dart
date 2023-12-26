import 'package:flutter/material.dart';
import 'package:jobapp/bloc/lowongan_bloc.dart';
import 'package:jobapp/model/lowongan.dart';
import 'package:jobapp/ui/lowongan_page.dart';
import 'package:jobapp/widget/warning_dialog.dart';

class LowonganForm extends StatefulWidget {
  final Lowongan? lowongan;
  LowonganForm({required this.lowongan});
  @override
  _LowonganFormState createState() => _LowonganFormState();
}

class _LowonganFormState extends State<LowonganForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH JOB";
  String tombolSubmit = "SIMPAN";

  final _posisiLowonganTextBoxController = TextEditingController();
  final _skillLowonganTextBoxController = TextEditingController();
  final _jobdescLowonganTextBoxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.lowongan != null) {
      setState(() {
        judul = "TAMBAH PEKERJAAN";
        tombolSubmit = "SUBMIT";
        _posisiLowonganTextBoxController.text = widget.lowongan?.posisi ?? '';
        _skillLowonganTextBoxController.text = widget.lowongan?.skill ?? '';
        _jobdescLowonganTextBoxController.text = widget.lowongan?.jobdesc ?? '';
      });
    } else {
      judul = "TAMBAH PEKERJAAN";
      tombolSubmit = "SUBMIT";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(
          judul,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _posisiLowonganTextField(),
                  _skillLowonganTextField(),
                  _jobdescLowonganTextField(),
                  SizedBox(
                    height: 20,
                  ),
                  _buttonSubmit()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _posisiLowonganTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Posisi"),
      keyboardType: TextInputType.text,
      controller: _posisiLowonganTextBoxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Eits blum diisi nich!";
        }
        return null;
      },
    );
  }

  Widget _skillLowonganTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Kebutuhan Skill"),
      keyboardType: TextInputType.text,
      controller: _skillLowonganTextBoxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "ga butuh skill emangnya?";
        }
        return null;
      },
    );
  }

  Widget _jobdescLowonganTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Job Desc"),
      keyboardType: TextInputType.text,
      controller: _jobdescLowonganTextBoxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Job desc nya apa nih?";
        }
        return null;
      },
    );
  }

  Widget _buttonSubmit() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black, foregroundColor: Colors.white),
        child: Text(tombolSubmit),
        onPressed: () {
          // Assuming _formKey is properly defined and associated with your Form widget
          if (_formKey.currentState!.validate()) {
            if (!_isLoading) {
              if (widget.lowongan != null) {
                //kondisi update lowongan
                ubah();
              } else {
                //kondisi tambah lowongan
                simpan();
              }
            }
          }
        });
  }

  void simpan() {
    setState(() {
      _isLoading = true;
    });
    int? id = widget.lowongan?.id;
    Lowongan createLowongan = Lowongan(
        id: id ?? 0,
        posisi: _posisiLowonganTextBoxController.text,
        skill: _skillLowonganTextBoxController.text,
        jobdesc: _jobdescLowonganTextBoxController.text);
    createLowongan.posisi = _posisiLowonganTextBoxController.text;
    createLowongan.skill = _skillLowonganTextBoxController.text;
    createLowongan.jobdesc = _jobdescLowonganTextBoxController.text;
    LowonganBloc.addLowongan(lowongan: createLowongan).then((value) {
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => LowonganPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => WarningDialog(
                description: "Simpan gagal, silahkan coba lagi",
                okClick: () {},
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });

    int? id = widget.lowongan?.id;
    Lowongan updateLowongan = new Lowongan(
        id: id ?? 0,
        posisi: _posisiLowonganTextBoxController.text,
        skill: _skillLowonganTextBoxController.text,
        jobdesc: _jobdescLowonganTextBoxController.text);
    updateLowongan.posisi = _posisiLowonganTextBoxController.text;
    updateLowongan.skill = _skillLowonganTextBoxController.text;
    updateLowongan.jobdesc = _jobdescLowonganTextBoxController.text;
    LowonganBloc.updateLowongan(lowongan: updateLowongan).then((value) {
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => LowonganPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => WarningDialog(
                description: "Permintaan ubah data gagal, silahkan coba lagi",
                okClick: () {},
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}
