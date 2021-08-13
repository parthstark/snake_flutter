import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/high_score.dart';
//import 'package:flutter_app/models/note.dart';

class DatabaseHelper {

	static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
	static Database _database;                // Singleton Database
  
  String colId='id';
  String coldPos='position';
  String coldScore='score';
  String coldDate='date';
  
  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

	factory DatabaseHelper() {

		if (_databaseHelper == null) {
			_databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
		}
		return _databaseHelper;
	}
}