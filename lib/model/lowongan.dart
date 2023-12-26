// ignore: unused_import
import 'dart:convert';

class Lowongan {
  int id;
  String posisi;
  String skill;
  String jobdesc;

  Lowongan(
      {required this.id,
      required this.posisi,
      required this.skill,
      required this.jobdesc});

  factory Lowongan.fromobj(Map<String, dynamic> obj) {
    return Lowongan(
        id: obj['id'],
        posisi: obj['posisi'],
        skill: obj['skill'],
        jobdesc: obj['jobdesc']);
  }
}
