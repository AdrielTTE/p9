

import 'dart:developer';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/Product.dart';

class DatabaseService {
  static final DatabaseService _databaseService = DatabaseService._internal();
  static Database? _database;

  factory DatabaseService() => _databaseService;

  DatabaseService._internal();


  //Get an instance of database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

//Initialize a database
  Future<Database> initDatabase() async {
    final getDirectory = await getApplicationDocumentsDirectory();
    String path = '${getDirectory.path}/myDB.db';
    log(path);

    final dbase = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) {
          db.execute('''
          CREATE TABLE Product(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            description TEXT,
            price REAL NOT NULL,
            img TEXT
          );
        ''');
        }
    );

    log("TABLE CREATED");
    return dbase;
  }

  Future<void> insertProduct(ProductModel product) async {
    final db = await _databaseService.database;
    var data = await db.insert(
      'Product',
      {
        'description': product.description,
        'price': product.price,
        'img': product.img,
      }

    );

    log('inserted $data');
  }

  //TODO
  Future List<ProductModel> readAll(ProductModel product) async {
    final db = await _databaseService.database;
    var data = await db.insert(
        'Product',
        {
          'description': product.description,
          'price': product.price,
          'img': product.img,
        }

    );

    log('inserted $data');
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE Moods('
            'id INTEGER PRIMARY KEY AUTOINCREMENT, '
            'scale INTEGER, '
            'description TEXT, '
            'createdOn DATETIME DEFAULT CURRENT_TIMESTAMP)');
    log('TABLE CREATED');
  }
}