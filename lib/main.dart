import 'package:flutter/material.dart';
import 'package:flutter_sqflite/database/dbhelper.dart';
import 'package:flutter_sqflite/view/note_page.dart';
import 'package:flutter_sqflite/view/list_note.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter SQFlite',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var db = DBHelper();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => NotePage(
              null,
              true,
            ),
          ));
        },
      ),
      appBar: new AppBar(
          title: Center(
            child: Text('Tambah Catatan'),
          ),
      ),
      body: FutureBuilder(
        future: db.getNote(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          var data = snapshot.data;
          return snapshot.hasData
              ? NoteList(data)
              : Center(
            child: Text("No Data"),
          );
        },
      ),
    );
  }
}