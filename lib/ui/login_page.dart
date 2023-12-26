import 'package:flutter/material.dart';
import 'package:jobapp/bloc/login_bloc.dart';
import 'package:jobapp/helpers/user_info.dart';
import 'package:jobapp/ui/lowongan_page.dart';
import 'package:jobapp/ui/registrasi_page.dart';
import 'package:jobapp/widget/warning_dialog.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final _emailTextBoxController = TextEditingController();
  final _passwordTextBoxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(4),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _emailTextField(),
                  _passwordTextField(),
                  _buttonLogin(),
                  SizedBox(
                    height: 30,
                  ),
                  _menuRegistrasi()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailTextField() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 5),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: "Email",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        maxLines: 5,
        minLines: 1,
        keyboardType: TextInputType.emailAddress,
        controller: _emailTextBoxController,
        validator: (value) {
          if (value!.isEmpty) {
            return "Email harus diisi";
          }
          return null;
        },
      ),
    );
  }

  Widget _passwordTextField() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 20),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        keyboardType: TextInputType.text,
        obscureText: true,
        controller: _passwordTextBoxController,
        validator: (value) {
          if (value!.isEmpty) {
            return "Password harus diisi";
          }
          return null;
        },
      ),
    );
  }

  Widget _buttonLogin() {
    return ElevatedButton(
      child: Text("Login"),
      onPressed: () {
        // Assuming _formKey is properly defined and associated with your Form widget
        if (_formKey.currentState!.validate()) {
          if (!_isLoading) _submit();
        }
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          padding: EdgeInsets.only(left: 50, right: 50, top: 5, bottom: 5),
          textStyle: TextStyle(
              fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
    );
  }

  void _submit() {
    _formKey.currentState?.save();
    setState(() {
      _isLoading = true;
    });
    LoginBloc.login(
            email: _emailTextBoxController.text,
            password: _passwordTextBoxController.text)
        .then((value) async {
      await UserInfo().setToken(value.token);
      await UserInfo().setUserID(value.userID);
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => LowonganPage()));
    }, onError: (error) {
      print(error);
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => WarningDialog(
                description: "Login gagal, silahkan coba lagi",
                okClick: () {},
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }

  Widget _menuRegistrasi() {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 50, right: 50),
      child: Center(
        child: InkWell(
          child: Text(
            "Registrasi",
            style: TextStyle(color: Colors.black),
          ),
          onTap: () {
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => RegistrasiPage()));
          },
        ),
      ),
    );
  }
}
