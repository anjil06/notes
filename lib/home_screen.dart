import 'package:flutter/material.dart';
import 'package:notes/db_helper.dart';
import 'package:notes/note_model.dart';
import 'add_edit_note.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DbHelper dbRef = DbHelper();
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  void loadNotes() async {
    notes = await dbRef.getNotes();
    setState(() {});
  }

  void deleteNote(int id) async {
    await dbRef.deleteNote(id);
    loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notes",style: TextStyle(fontWeight: FontWeight.w400,color:  Colors.white),),backgroundColor: Colors.deepPurple,),

      body: notes.isEmpty
          ? Center(child: Text("No Notes Yet"))
          : ListView.builder(
        itemCount: notes.length,
        itemBuilder: (_, index) {
          var note = notes[index];

          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text(note.title),
              subtitle: Text(note.desc),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddEditNote(note: note),
                        ),
                      );
                      loadNotes();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => deleteNote(note.id!),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddEditNote()),
          );
          loadNotes();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}