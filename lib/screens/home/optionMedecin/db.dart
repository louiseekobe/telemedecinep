import 'dart:async';
import 'package:firebase_helpers/firebase_helpers.dart';
import 'package:medecineapp/screens/home/optionMedecin/calendar_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

abstract class DB {
  static Database _db;

  static int get _version => 1;

  static Future<void> init() async {
    try {
      String _path = await getDatabasesPath();
      String _dbpath = p.join(_path, 'cal1.db');

      _db = await openDatabase(_dbpath, version: _version, onCreate: onCreate);
      print(_version);
    } catch (ex) {
      print(ex);
    }
  }

  static FutureOr<void> onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE events (id INTEGER PRIMARY KEY NOT NULL, name STRING, date STRING, setCounter INTEGER)');
  }

  static Future<List<Map<String, dynamic>>> query(String table) async =>
      await _db.query(table);

  static Future<int> insert(String table, CalendarItem item) async =>
      await _db.insert(table, item.toMap());

  static Future<int> delete(String table, CalendarItem item) async =>
      await _db.delete(table, where: 'id = ?', whereArgs: [item.id]);
}

class EventModel extends DatabaseItem {
  final String id;
  final String description;
  final DateTime eventDate;

  EventModel({this.id, this.description, this.eventDate}) : super(id);

  factory EventModel.fromMap(Map data) {
    return EventModel(
      description: data['description'],
      eventDate: data['event_date'],
    );
  }

  factory EventModel.fromDS(String id, Map<String, dynamic> data) {
    return EventModel(
      id: id,
      description: data['description'],
      eventDate: data['event_date'].toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "description": description,
      "event_date": eventDate,
      "id": id,
    };
  }
}

DatabaseService<EventModel> eventDBS = DatabaseService<EventModel>("events",
    fromDS: (id, data) => EventModel.fromDS(id, data),
    toMap: (event) => event.toMap());
