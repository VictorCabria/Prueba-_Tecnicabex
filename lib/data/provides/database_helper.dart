import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;


import '../models/note_model.dart'; // Asegúrate de tener un modelo UserModel

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  static const String databaseName = 'test4.db';
  static const int versionNumber = 1;

  static const String tableNotes = 'Notes';
  static const String tableUsers = 'Users';

  static const String colId = 'id';
  static const String colTitle = 'title';
  static const String colDescription = 'description';

  static const String colEmail = 'email';
  static const String colPassword = 'password';
  static const String colToken = 'token';

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, databaseName);
    var db =
        await openDatabase(path, version: versionNumber, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableNotes (
        $colId INTEGER PRIMARY KEY AUTOINCREMENT,
        $colTitle TEXT NOT NULL,
        $colDescription TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableUsers (
        $colId INTEGER PRIMARY KEY AUTOINCREMENT,
        $colEmail TEXT NOT NULL UNIQUE,
        $colPassword TEXT NOT NULL,
        $colToken TEXT
      )
    ''');
  }

  Future<List<NoteModel>> getAll() async {
    final db = await database;
    final result = await db.query(tableNotes, orderBy: '$colId ASC');
    return result.map((json) => NoteModel.fromJson(json)).toList();
  }

  Future<NoteModel> read(int id) async {
    final db = await database;
    final maps = await db.query(
      tableNotes,
      where: '$colId = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return NoteModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<void> insert(NoteModel note) async {
    final db = await database;
    await db.insert(tableNotes, note.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> update(NoteModel note) async {
    final db = await database;
    return await db.update(tableNotes, note.toJson(),
        where: '$colId = ?', whereArgs: [note.id]);
  }

  Future<void> delete(int id) async {
    final db = await database;
    await db.delete(tableNotes, where: "$colId = ?", whereArgs: [id]);
  }

  Future<void> createUser(String email, String password) async {
    final db = await database;
    await db.insert(tableUsers, {
      colEmail: email,
      colPassword: password,
      colToken: null,
    });
  }

  Future<String> signIn(String email, String password) async {
    final db = await database;
    final result = await db.query(
      tableUsers,
      where: '$colEmail = ? AND $colPassword = ?',
      whereArgs: [email, password],
    );

    if (result.isNotEmpty) {
      final token = generateToken();
      await db.update(
        tableUsers,
        {colToken: token},
        where: '$colId = ?',
        whereArgs: [result.first[colId]],
      );
      return token;
    } else {
      throw Exception('Invalid credentials');
    }
  }

  Future<void> signOut() async {
    final db = await database;
    await db.update(tableUsers, {colToken: null});
  }

  String generateToken() {
    return List.generate(
        24,
        (index) => 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'.split(
            '')[(index + DateTime.now().millisecondsSinceEpoch) % 36]).join();
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}
