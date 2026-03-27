import 'package:flutter/material.dart';
import 'package:notes/db_helper.dart';
import 'package:notes/note_model.dart';

class AddEditNote extends StatefulWidget {
  Note? note;

  AddEditNote({this.note});

  @override
  State<AddEditNote> createState() => _AddEditNoteState();
}

class _AddEditNoteState extends State<AddEditNote> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  DbHelper dbRef = DbHelper();

  @override
  void initState() {
    super.initState();

    if (widget.note != null) {
      titleController.text = widget.note!.title;
      descController.text = widget.note!.desc;
    }
  }

  void saveNote() async {
    String title = titleController.text;
    String desc = descController.text;

    if (title.isEmpty || desc.isEmpty) return;

    if (widget.note == null) {
      await dbRef.addNote(Note(title: title, desc: desc));
    } else {
      await dbRef.updateNote(
        Note(id: widget.note!.id, title: title, desc: desc),
      );
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? "Add Note" : "Edit Note"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "Title"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: descController,
              decoration: InputDecoration(labelText: "Description"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveNote,
              child: Text("Save"),
            )
          ],
        ),
      ),
    );
  }
}