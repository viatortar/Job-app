import 'package:flutter/material.dart';
import 'package:jobapp/bloc/registrasi_bloc.dart';
import 'package:jobapp/widget/success_dialog.dart';
import 'package:jobapp/widget/warning_dialog.dart';
// import 'package:jobapp/helpers/api.dart';
// import 'package:jobapp/helpers/api_url.dart';

class RegistrasiPage extends StatefulWidget {
  @override
  _RegistrasiPageState createState() => _RegistrasiPageState();
}

class _RegistrasiPageState extends State<RegistrasiPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final _namaTextBoxController = TextEditingController();
  final _emailTextBoxController = TextEditingController();
  final _passwordTextBoxController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registrasi"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _namaTextField(),
                  _emailTextField(),
                  _passwordTextField(),
                  _passwordKonfirmasiTextField(),
                  _buttonRegistrasi()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _namaTextField() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: "Nama",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        keyboardType: TextInputType.text,
        controller: _namaTextBoxController,
        validator: (value) {
          if (value!.length < 3) {
            return "Nama harus diisi minimal 3 karakter";
          }
          return null;
        },
      ),
    );
  }

  Widget _emailTextField() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: "Email",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        keyboardType: TextInputType.emailAddress,
        controller: _emailTextBoxController,
        validator: (value) {
          if (value!.isEmpty) {
            return "Email harus diisi";
          }
          String pattern = r'(^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$)';
          RegExp regex = RegExp(pattern);
          if (!regex.hasMatch(value)) {
            return "Email tidak valid";
          }
          return null;
        },
      ),
    );
  }

  Widget _passwordTextField() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: "Password",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        keyboardType: TextInputType.text,
        obscureText: true,
        controller: _passwordTextBoxController,
        validator: (value) {
          if (value!.length < 6) {
            return "Password harus diisi minimal 6 karakter";
          }
          return null;
        },
      ),
    );
  }

  Widget _passwordKonfirmasiTextField() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: "Konfirmasi Password",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        keyboardType: TextInputType.text,
        obscureText: true,
        validator: (value) {
          if (value != _passwordTextBoxController.text) {
            return "Konfirmasi password tidak sama";
          }
          return null;
        },
      ),
    );
  }

  Widget _buttonRegistrasi() {
    return ElevatedButton(
      child: Text("Registrasi"),
      onPressed: () {
        // Assuming _formKey is properly defined and associated with your Form widget
        if (_formKey.currentState!.validate()) {
          if (!_isLoading) _submit();
          // If validation passes, you can proceed with your registration logic here
        }
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          padding: EdgeInsets.only(right: 50, left: 50, top: 5, bottom: 5),
          textStyle: TextStyle(
              fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
    );
  }

  void _submit() {
    _formKey.currentState?.save();
    setState(() {
      _isLoading = true;
    });
    RegistrasiBloc.registrasi(
            nama: _namaTextBoxController.text,
            email: _emailTextBoxController.text,
            password: _passwordTextBoxController.text)
        .then((value) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => SuccessDialog(
                description: "Registrasi berhasil, silahkan login",
                okClick: () {
                  Navigator.pop(context);
                },
              ));
    }, onError: (error) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => WarningDialog(
                description: "Registrasi gagal, silahkan coba lagi",
                okClick: () {},
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}
