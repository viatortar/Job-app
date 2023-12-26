import 'package:flutter/material.dart';
import 'package:jobapp/bloc/lowongan_bloc.dart';
import 'package:jobapp/model/lowongan.dart';
import 'package:jobapp/ui/lowongan_form.dart';
import 'package:jobapp/ui/lowongan_page.dart';
import 'package:jobapp/widget/warning_dialog.dart';

class LowonganDetail extends StatefulWidget {
  final Lowongan lowongan;

  LowonganDetail({required this.lowongan});

  @override
  _LowonganDetailState createState() => _LowonganDetailState();
}

class _LowonganDetailState extends State<LowonganDetail> {
  @override
  Widget build(BuildContext) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(
          "DETAIL PEKERJAAN",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 25),
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
                child: Column(
              children: [
                Text(
                  "Posisi",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  "${widget.lowongan.posisi}",
                  style: TextStyle(fontSize: 16),
                )
              ],
            )),
            SizedBox(height: 30),
            Container(
                child: Column(
              children: [
                Text(
                  "Skill",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  "${widget.lowongan.skill}",
                  style: TextStyle(fontSize: 16),
                )
              ],
            )),
            SizedBox(height: 30),
            Container(
                child: Column(
              children: [
                Text(
                  "Jobdesc",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Text(
                    "${widget.lowongan.jobdesc}",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            )),
            SizedBox(height: 50),
            _tombolHapusEdit()
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white, foregroundColor: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LowonganForm(lowongan: widget.lowongan),
              ),
            );
          },
          child: Text("EDIT"),
        ),
        SizedBox(width: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black, foregroundColor: Colors.white),
          onPressed: () => confirmHapus(),
          child: Text("DELETE"),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = new AlertDialog(
      content: Text("Yakin ingin menghapus data ini?"),
      actions: [
        //tombol hapus
        ElevatedButton(
          child: Text("Ya"),
          onPressed: () {
            LowonganBloc.deleteLowongan(id: widget.lowongan.id).then((value) {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => LowonganPage()));
            }, onError: (error) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => WarningDialog(
                        description: "Hapus data gagal, silahkan coba lagi",
                        okClick: () {},
                      ));
            });
          },
        ),
        //tombol batal
        ElevatedButton(
          child: Text("Batal"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );

    showDialog(context: context, builder: (_) => alertDialog);
  }
}
