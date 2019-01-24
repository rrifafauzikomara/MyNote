import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_sqflite/model/mahasiswa.dart';

class DBHelper {

  static Database _db;

  Future<Database> get db async {
    if(_db != null)
      return _db;
    _db = await initDb();
    return _db;
  }

  //membuat database dengan nama latihan.db di direktori anda
  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "latihan.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  // membuat tabel mahasiswa dengan beberapa atribut
  void _onCreate(Database dbMhs, int version) async {
    // When creating the db, create the table
    await dbMhs.execute(
        "CREATE TABLE mahasiswa(id INTEGER PRIMARY KEY, nama TEXT, npm TEXT, kelas TEXT, jurusan TEXT )");
    print("Created tables");
  }

  // mengambil data mahasiswa dari tabel mahasiswa
  Future<List<Mahasiswa>> getMahasiswa() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM mahasiswa');
    List<Mahasiswa> mahasiswa = new List();
    for (int i = 0; i < list.length; i++) {
      mahasiswa.add(new Mahasiswa(list[i]["nama"], list[i]["npm"], list[i]["kelas"], list[i]["jurusan"]));
    }
    print(mahasiswa.length);
    return mahasiswa;
  }

  // menambahkan data mahasiswa pada tabel mahasiswa
  void saveMahasiswa(Mahasiswa mahasiswa) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      return await txn.rawInsert(
          'INSERT INTO mahasiswa(nama, npm, kelas, jurusan) VALUES(' +
              '\'' +
              mahasiswa.nama +
              '\'' +
              ',' +
              '\'' +
              mahasiswa.npm +
              '\'' +
              ',' +
              '\'' +
              mahasiswa.kelas +
              '\'' +
              ',' +
              '\'' +
              mahasiswa.jurusan +
              '\'' +
              ')');
    });
  }

}