import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:notes/note_model.dart';

class DbHelper {
  static Database? _db;

  Future<Database> getDb() async {
    if (_db != null) return _db!;

    _db = await openDb();
    return _db!;
  }

  Future<Database> openDb() async {
    String path = join(await getDatabasesPath(), 'notes.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE notes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            desc TEXT
          )
        ''');
      },
    );
  }

  // INSERT
  Future<bool> addNote(Note note) async {
    var db = await getDb();
    int rows = await db.insert('notes', note.toMap());
    return rows > 0;
  }

  // READ
  Future<List<Note>> getNotes() async {
    var db = await getDb();
    List<Map<String, dynamic>> data = await db.query('notes');

    return data.map((e) => Note.fromMap(e)).toList();
  }

  // UPDATE
  Future<bool> updateNote(Note note) async {
    var db = await getDb();
    int rows = await db.update(
      'notes',
      note.toMap(),
      where: 'id=?',
      whereArgs: [note.id],
    );
    return rows > 0;
  }

  // DELETE
  Future<bool> deleteNote(int id) async {
    var db = await getDb();
    int rows = await db.delete('notes', where: 'id=?', whereArgs: [id]);
    return rows > 0;
  }
}