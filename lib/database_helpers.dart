import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:repairservices/models/Product.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:repairservices/models/Windows.dart';
import 'package:repairservices/models/Company.dart';

// singleton class to manage the database
class DatabaseHelper {
  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "MyDatabase.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $tableWindows (
                $columnId INTEGER PRIMARY KEY,
                $columnName TEXT NOT NULL,
                $columnCreated TEXT,
                $columnNumber INTEGER,
                $columnSystemDepth TEXT,
                $columnProfileSystem TEXT,
                $columnDescription TEXT,
                $columnFilePath TEXT
              )
              ''');
    await db.execute('''
              CREATE TABLE $tableCompany (
                $columnCompanyId INTEGER PRIMARY KEY,
                $columnCompanyName TEXT NOT NULL,
                $columnAdditionalInf TEXT,
                $columnPhone TEXT,
                $columnEmail TEXT,
                $columnFax TEXT,
                $columnWebsite TEXT,
                $columnLogoPath TEXT,
                $columnStreet TEXT,
                $columnHouseNumber INTEGER,
                $columnExtraAddressLine TEXT,
                $columnPostCode INTEGER,
                $columnLat DOUBLE,
                $columnLng DOUBLE,
                $columnTextExportEmail TEXT,
                $columnDefaultC INTEGER not null,
                $columnLocation TEXT
              )
              ''');
    await db.execute('''
              CREATE TABLE $tableProduct (
                $columnProductId INTEGER PRIMARY KEY,
                $columnShortText TEXT NOT NULL,
                $columnProductNumber TEXT NOT NULL,
                $columnProductUrl TEXT NOT NULL,
                $columnProductQuantity TEXT
              )
              ''');
    await db.execute('''
              CREATE TABLE $tableProductInCart (
                $columnProductId INTEGER PRIMARY KEY,
                $columnShortText TEXT NOT NULL,
                $columnProductNumber TEXT NOT NULL,
                $columnProductUrl TEXT NOT NULL,
                $columnProductQuantity TEXT
              )
              ''');
  }

  // Database helper methods:

  // Insert Article Windows
  Future<int> insert(Windows windows) async {
    Database db = await database;
    int id = await db.insert(tableWindows, windows.toMap());
    return id;
  }
  // Get Article Windows by Id
  Future<Windows> queryWindows(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(tableWindows,
        columns: [columnId, columnName, columnCreated, columnNumber, columnSystemDepth, columnProfileSystem, columnDescription],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Windows.fromMap(maps.first);
    }
    return null;
  }
  //Get All Article Windows
  Future<List<Windows>> queryAllWindows() async {
    Database db = await database;
    List<Map> result = await db.query(tableWindows);
    // print the results
    List<Windows> list = new List();

    for(final row in result){
      list.add(Windows.fromMap(row));
    }
    return list;
  }
  Future<int> updateWindows(Windows windows) async {
    Database db = await database;
    return await db.update(tableWindows, windows.toMap(),
        where: '$columnId = ?', whereArgs: [windows.id]);
  }

  //Delete Windows
  Future<int> deleteWindows(int id) async {
    Database db = await database;
    return await db.delete(tableWindows, where: '$columnId = ?', whereArgs: [id]);
  }


  // Insert Company Profile
  Future<int> insertCompany(Company company) async {
    Database db = await database;
    int id = await db.insert(tableCompany, company.toMap());
    return id;
  }
  // Get Article Windows by Id
  Future<Company> queryCompany(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(tableCompany,
        columns: [columnCompanyName, columnAdditionalInf, columnPhone, columnEmail, columnFax, columnWebsite, columnLogoPath, columnStreet, columnHouseNumber, columnExtraAddressLine, columnPostCode, columnLat, columnLng, columnTextExportEmail, columnDefaultC],
        where: '$columnCompanyId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Company.fromMap(maps.first);
    }
    return null;
  }
  //Get All Article Windows
  Future<List<Company>> queryAllCompany() async {
    Database db = await database;
    List<Map> result = await db.query(tableCompany);
    // print the results
    List<Company> list = new List();

    for(final row in result){
      list.add(Company.fromMap(row));
    }
    return list;
  }
  //Update Company
  Future<int> updateCompany(Company company) async {
    Database db = await database;
    return await db.update(tableCompany, company.toMap(),
        where: '$columnCompanyId = ?', whereArgs: [company.id]);
  }
  //Delete Company
  Future<int> deleteCompany(int id) async {
    Database db = await database;
    return await db.delete(tableCompany, where: '$columnCompanyId = ?', whereArgs: [id]);
  }

  // Insert Product
  Future<int> insertProduct(Product product, bool existInCart) async {
    debugPrint('inserting Product with name: ${product.shortText.value}');
    Database db = await database;
    int id = await db.insert(!existInCart ? tableProduct : tableProductInCart, product.toMap());
    return id;
  }

  //Get All Article Products
  Future<List<Product>> queryAllProducts(bool existInCart) async {
    Database db = await database;
    List<Map> result = await db.query(!existInCart ? tableProduct : tableProductInCart);
    // print the results
    List<Product> list = new List();

    for(final row in result){
      list.add(Product.fromMap(row));
    }
    return list;
  }

  //Delete Product
  Future<int> deleteProduct(int id, bool existInCart) async {
    Database db = await database;
    return await db.delete(!existInCart ? tableProduct : tableProductInCart, where: '$columnProductId = ?', whereArgs: [id]);
  }
  //Update products
  Future<int> updateProduct(Product product, bool existInCart) async {
    debugPrint('updating product in Cart');
    Database db = await database;
    return await db.update(!existInCart ? tableProduct : tableProductInCart, product.toMap(),
        where: '$columnProductId = ?', whereArgs: [product.id]);
  }
}