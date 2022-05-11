import 'package:sqflite/sqflite.dart';
class Core {
  Core(){
    database();
  }
  static Database _database;
  static Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initializeDb();
    return _database;
  }
   Future<Database> initializeDb() async {
    String path = await getDatabasesPath();
    path = join(path, 'flutter_database.db');
    return await openDatabase(path, version: 1, onCreate: (Database db, int version) async {

      await db.execute('CREATE TABLE user (id INTEGER PRIMARY KEY, name TEXT, email TEXT, password TEXT)');
      await db.execute('CREATE TABLE todo (id INTEGER PRIMARY KEY, title TEXT, description TEXT, date TEXT, status INTEGER)');
    });
  }
  Future<bool> insert(String table,String columns,String values) async {
    var dbClient = await database;
    var result = await dbClient.rawInsert('INSERT INTO $table ($columns) VALUES ($values)');
    return result > 0;
    
}