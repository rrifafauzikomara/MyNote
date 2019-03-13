import 'package:flutter/material.dart';
import 'package:flutter_sqflite/model/note.dart';
import 'package:flutter_sqflite/view/note_page.dart';

class NoteList extends StatefulWidget {
  final List<Note> notedata;

  NoteList(this.notedata, {Key key});

  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
          MediaQuery.of(context).orientation == Orientation.portrait
              ? 2
              : 3),
      itemCount: widget.notedata.length == null ? 0 : widget.notedata.length,
      itemBuilder: (_, int i) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => NotePage(widget.notedata[i], false),
              ),
            );
          },
          child: Card(
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(14.0),
                  width: double.infinity,
                  child: Text(
                    widget.notedata[i].title,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.notedata[i].note,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "Created : ${widget.notedata[i].createDate}",
                    style: TextStyle(fontSize: 12.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "Updated : ${widget.notedata[i].updateDate}",
                    style: TextStyle(fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}