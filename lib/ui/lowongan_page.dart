import 'package:flutter/material.dart';
import 'package:jobapp/bloc/logout_bloc.dart';
import 'package:jobapp/bloc/lowongan_bloc.dart';
import 'package:jobapp/model/lowongan.dart';
import 'package:jobapp/ui/login_page.dart';
import 'package:jobapp/ui/lowongan_detail.dart';
import 'package:jobapp/ui/lowongan_form.dart';

class LowonganPage extends StatefulWidget {
  @override
  _LowonganPageState createState() => _LowonganPageState();
}

class _LowonganPageState extends State<LowonganPage> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'DAFTAR KERJAAN',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text("Logout"),
              trailing: Icon(Icons.logout),
              onTap: () async {
                await LogoutBloc.logout().then(
                  (value) {
                    Navigator.pushReplacement(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => LoginPage()));
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<List>(
        future: LowonganBloc.getLowongans(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 25, top: 20, bottom: 5),
                      child: Text(
                        'Job list',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            searchText = value;
                          });
                        },
                        decoration: InputDecoration(
                            labelText: 'Search',
                            hintText: 'Enter Search Text',
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)),
                            )),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(right: 10, left: 10),
                        child: ListLowongan(
                          list: snapshot.data,
                          searchText: searchText,
                        ),
                      ),
                    ),
                  ],
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LowonganForm(
                lowongan: null,
              ),
            ),
          );
        },
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
    );
  }
}

class ListLowongan extends StatelessWidget {
  final List? list;
  final String searchText;
  ListLowongan({required this.list, required this.searchText});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list!.length,
        itemBuilder: (context, i) {
          return ItemLowongan(
            lowongan: list![i],
          );
        });
  }
}

class ItemLowongan extends StatelessWidget {
  final Lowongan lowongan;

  ItemLowongan({required this.lowongan});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => LowonganDetail(
                        lowongan: lowongan,
                      )));
        },
        child: Card(
          color: Colors.white,
          elevation: 2,
          child: ListTile(
            title: Text(lowongan.posisi),
            subtitle: Text(lowongan.skill.toString()),
          ),
        ),
      ),
    );
  }
}
