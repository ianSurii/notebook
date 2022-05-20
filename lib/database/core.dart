import 'package:notebook/models/cart.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import '../models/note.dart';

class Core {
  factory Core() {
    if (_core == null) {
      _core = Core._createInstance();
    }
    return _core!;
  }

  Core._createInstance();

  static Core? _core;
  static Database? _database;

  Future<Database?> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    var dir = await getDatabasesPath();
    var path = dir + "notebook.db";

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE notes(id INTEGER PRIMARY KEY autoincrement , title TEXT, content TEXT, date TEXT,type INTEGER)');
        // create table for trash notes
        db.execute(
            'CREATE TABLE cartitem(id INTEGER PRIMARY KEY autoincrement , noteid INTEGER,item TEXT,status INTEGER)');
      },
    );
    return database;
  }

  void insertNote(String table, Note model) async {
    var db = await this.database;
    print(db.toString() + "this is the db value");
    var result = await db!.insert(table, model.toMap());

    print('result : $result');
  }

  void insertCart(String table, Cart model) async {
    var db = await this.database;
    var result = await db!.insert(table, model.toMap());

    print('result : $result');
  }

  Future<List<Cart>> getCart(int noteid) async {
    List<Cart> _cart = [];

    var db = await this.database;
    var result = await db!.query("notes");
    result.forEach((element) {
      var cart = Cart.fromMap(element);
      _cart.add(cart);
    });

    return _cart;
  }

  Future<List<Note>> getNotes() async {
    List<Note> _note = [];

    var db = await this.database;
    var result = await db!.query("notes");
    result.forEach((element) {
      var note = Note.fromMap(element);
      _note.add(note);
    });

    return _note;
  }

  Future<int> delete(String table, int id) async {
    var db = await this.database;
    return await db!.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}
