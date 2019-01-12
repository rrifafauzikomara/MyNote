import 'package:flutter/material.dart';
import 'package:flutter_sqflite/database/dbhelper.dart';
import 'package:flutter_sqflite/model/mahasiswa.dart';
import 'package:flutter_sqflite/view/list_mahasiswa.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter SQFlite',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter SQFlite'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Mahasiswa mahasiswa = new Mahasiswa("", "", "", "");

  String nama;
  String npm;
  String kelas;
  String jurusan;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      appBar: new AppBar(
          title: new Text('Tambah Mahasiswa'),
          actions: <Widget>[
            new IconButton(
              icon: const Icon(Icons.view_list),
              tooltip: 'Next choice',
              onPressed: () {
                navigateToEmployeeList();
              },
            ),
          ]
      ),
      body: new Padding(
        padding: const EdgeInsets.all(16.0),
        child: new Form(
          key: formKey,
          child: new Column(
            children: [
              new TextFormField(
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(labelText: 'Nama Lengkap'),
                validator: (val) =>
                val.length == 0 ?"Masukan Nama Lengkap" : null,
                onSaved: (val) => this.nama = val,
              ),
              new TextFormField(
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(labelText: 'NPM'),
                validator: (val) =>
                val.length ==0 ? 'Masukan NPM' : null,
                onSaved: (val) => this.npm = val,
              ),
              new TextFormField(
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(labelText: 'Kelas'),
                validator: (val) =>
                val.length ==0 ? 'Masukan Kelas' : null,
                onSaved: (val) => this.kelas = val,
              ),
              new TextFormField(
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(labelText: 'Jurusan'),
                validator: (val) =>
                val.length ==0 ? 'Masukan Jurusan' : null,
                onSaved: (val) => this.jurusan = val,
              ),
              new Container(margin: const EdgeInsets.only(top: 10.0),child: new RaisedButton(onPressed: _submit,
                child: new Text('Simpan'),),)

            ],
          ),
        ),
      ),
    );
  }
  void _submit() {
    if (this.formKey.currentState.validate()) {
      formKey.currentState.save();
    }else{
      return null;
    }
    var mahasiswa = Mahasiswa(nama,npm,kelas,jurusan);
    var dbHelper = DBHelper();
    dbHelper.saveMahasiswa(mahasiswa);
    _showSnackBar("Data Mahasiswa Berhasil Tersimpan");
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  }

  void navigateToEmployeeList(){
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new MyListMahasiswa()),
    );
  }
}