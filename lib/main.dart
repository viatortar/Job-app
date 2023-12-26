import 'package:flutter/material.dart';
import 'package:jobapp/helpers/user_info.dart';
import 'package:jobapp/ui/login_page.dart';
import 'package:jobapp/ui/lowongan_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = CircularProgressIndicator();

  @override
  void initState() {
    super.initState();
    isLogin();
  }

  void isLogin() async {
    var token = await UserInfo().getToken();
    if (token != null) {
      setState(() {
        page = LowonganPage();
      });
    } else {
      setState(() {
        page = LoginPage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lowongan Pekerjaan',
      debugShowCheckedModeBanner: false,
      home: page,
    );
  }
}
