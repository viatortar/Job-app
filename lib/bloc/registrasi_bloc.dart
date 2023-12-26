import 'dart:convert';
import 'package:jobapp/helpers/api.dart';
import 'package:jobapp/helpers/api_url.dart';
import 'package:jobapp/model/registrasi.dart';

class RegistrasiBloc {
  static Future<Registrasi> registrasi(
      {required String nama,
      required String email,
      required String password}) async {
    String apiUrl = ApiUrl.registrasi;

    var body = {"nama": nama, "email": email, "password": password};

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body.toString());
    return Registrasi.fromJson(jsonObj);
  }
}
