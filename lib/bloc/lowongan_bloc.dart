import 'dart:convert';

import 'package:jobapp/helpers/api.dart';
import 'package:jobapp/helpers/api_url.dart';
import 'package:jobapp/model/lowongan.dart';

class LowonganBloc {
  static Future<List<Lowongan>> getLowongans() async {
    String apiUrl = ApiUrl.listLowongan;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listLowongan = (jsonObj as Map<String, dynamic>)['data'];
    List<Lowongan> lowongans = [];
    for (int i = 0; i < listLowongan.length; i++) {
      lowongans.add(Lowongan.fromobj(listLowongan[i]));
    }
    return lowongans;
  }

  static Future addLowongan({required Lowongan lowongan}) async {
    String apiUrl = ApiUrl.createLowongan;

    var body = {
      "posisi": lowongan.posisi,
      "skill": lowongan.skill,
      "jobdesc": lowongan.jobdesc,
    };

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> updateLowongan({required Lowongan lowongan}) async {
    String apiUrl = ApiUrl.updateLowongan(lowongan.id);

    var body = {
      "posisi": lowongan.posisi,
      "skill": lowongan.skill,
      "jobdesc": lowongan.jobdesc,
    };
    print("Body : $body");
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body.toString());
    return jsonObj['data'];
  }

  static Future<bool> deleteLowongan({required int id}) async {
    String apiUrl = ApiUrl.deleteLowongan(id);

    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
