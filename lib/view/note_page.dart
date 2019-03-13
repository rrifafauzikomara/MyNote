import 'package:flutter/material.dart';
import 'package:flutter_sqflite/database/dbhelper.dart';
import 'package:flutter_sqflite/model/note.dart';

class NotePage extends StatefulWidget {
  final Note _note;
  final bool _isNew;

  const NotePage(this._note, this._isNew);

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  String title;
  bool btnSave = false;
  bool btnEdit = true;
  bool btnDelete = true;

  Note note;
  String createDate;

  final cTitle = TextEditingController();
  final cNote = TextEditingController();

  var now = DateTime.now();

  bool _enabledTextField = true;

  Future addRecord() async {
    var db = DBHelper();
    String dateNow =
        "${now.day}/${now.month}/${now.year}, ${now.hour}:${now.minute}";

    var note =
    Note(cTitle.text, cNote.text, dateNow, dateNow, now.toString());
    await db.saveNote(note);
    print("saved");
  }

  Future updateRecord() async {
    var db = DBHelper();
    String dateNow =
        "${now.day}/${now.month}/${now.year}, ${now.hour}:${now.minute}";

    var note =
    Note(cTitle.text, cNote.text, createDate, dateNow, now.toString());

    note.setNoteId(this.note.id);
    await db.updateNote(note);
  }

  void _saveData() {
    if (widget._isNew) {
      addRecord();
    } else {
      updateRecord();
    }
    Navigator.pop(context);
  }

  void _editData() {
    setState(() {
      _enabledTextField = true;
      btnEdit = false;
      btnSave = true;
      btnDelete = true;
      title = "Edit Note";
    });
  }

  void delete(Note note) {
    var db = DBHelper();
    db.deleteNote(note);
  }

  void _deleteData() {
    AlertDialog alertDialog = AlertDialog(
      content: Text(
        "Hapus note ini ?",
        style: TextStyle(
          fontSize: 20.0,
        ),
      ),
      actions: <Widget>[
        RaisedButton(
          child: Text(
            "Delete",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.pop(context);
            delete(note);
            Navigator.pop(context);
          },
        ),
        RaisedButton(
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  @override
  void initState() {
    if (widget._note != null) {
      note = widget._note;
      cTitle.text = note.title;
      cNote.text = note.note;
      title = "My Note";
      _enabledTextField = false;
      createDate = note.createDate;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget._isNew) {
      title = "New Note";
      btnSave = true;
      btnEdit = false;
      btnDelete = false;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CreateButton(
                      icon: Icons.delete,
                      enable: btnDelete,
                      onpress: _deleteData,
                    ),
                    CreateButton(
                      icon: Icons.edit,
                      enable: btnEdit,
                      onpress: _editData,
                    ),
                    CreateButton(
                      icon: Icons.save,
                      enable: btnSave,
                      onpress: _saveData,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextFormField(
                  enabled: _enabledTextField,
                  controller: cTitle,
                  decoration: InputDecoration(hintText: "Judul"),
                  style: TextStyle(fontSize: 24.0, color: Colors.black),
                  maxLines: null,
                  keyboardType: TextInputType.text,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextFormField(
                  enabled: _enabledTextField,
                  controller: cNote,
                  decoration: InputDecoration(hintText: "Deskripsi"),
                  style: TextStyle(fontSize: 24.0, color: Colors.black),
                  maxLines: null,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.newline,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CreateButton extends StatelessWidget {
  final IconData icon;
  final bool enable;
  final onpress;

  const CreateButton({this.icon, this.enable, this.onpress});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: enable ? Colors.blue : Colors.grey),
      child: IconButton(
        icon: Icon(icon),
        color: Colors.white,
        iconSize: 18.0,
        onPressed: () {
          if (enable) {
            onpress();
          }
        },
      ),
    );
  }
}