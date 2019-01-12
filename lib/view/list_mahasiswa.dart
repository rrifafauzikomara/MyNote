import 'package:flutter/material.dart';
import 'package:flutter_sqflite/model/mahasiswa.dart';
import 'dart:async';
import 'package:flutter_sqflite/database/dbhelper.dart';

Future<List<Mahasiswa>> fetchMahasiswaFromDatabase() async {
  var dbHelper = DBHelper();
  Future<List<Mahasiswa>> mahasiswa = dbHelper.getMahasiswa();
  return mahasiswa;
}

class MyListMahasiswa extends StatefulWidget {
  @override
  MyListPageMahasiswa createState() => new MyListPageMahasiswa();
}

class MyListPageMahasiswa extends State<MyListMahasiswa> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('List Pegawai'),
      ),
      body: new Container(
        padding: new EdgeInsets.all(16.0),
        child: new FutureBuilder<List<Mahasiswa>>(
          future: fetchMahasiswaFromDatabase(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return new ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(snapshot.data[index].nama,
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                          new Text(snapshot.data[index].npm,
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14.0)),
                          new Divider()
                        ]);
                  });
            } else if (snapshot.hasError) {
              return new Text("${snapshot.error}");
            }
            return new Container(alignment: AlignmentDirectional.center,child: new CircularProgressIndicator(),);
          },
        ),
      ),
    );
  }
}