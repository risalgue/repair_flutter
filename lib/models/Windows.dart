// database table and column names
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:repairservices/models/Company.dart';

final String tableWindows = 'windows';
final String columnId = '_id';
final String columnName = 'name';
final String columnYear = 'year';
final String columnCreated = 'created';
final String columnNumber = 'number';
final String columnSystemDepth = 'systemDepth';
final String columnProfileSystem = 'profileSystem';
final String columnDescription = 'description';
final String columnFilePath = 'file';
final String columnIsImage = 'isImage';
final String columnWindowsPDFPath = 'pdfPath';

// data model class
class Fitting{
  int id;
  String name;
  DateTime created;
  String year;
  String pdfPath;
}
class Windows extends Fitting {
  int number;
  String systemDepth;
  String profileSystem;
  String description;
  String filePath;
  bool isImage;
  Windows();

  // convenience constructor to create a Word object
  Windows.withData(String name, DateTime created,String year, int number,String systemDepth,String profileSystem,String description,
      String filePath,bool isImage) {
    this.name = name;
    this.created = created;
    this.year = year;
    this.number = number;
    this.systemDepth = systemDepth;
    this.profileSystem = profileSystem;
    this.description = description;
    this.filePath = filePath;
    this.isImage = isImage;
  }

  Windows.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    name = map[columnName];
    year = map[columnYear];
    String createdStr = map[columnCreated];
    created = DateTime.parse(createdStr);
    number = map[columnNumber];
    systemDepth = map[columnSystemDepth];
    profileSystem = map[columnProfileSystem];
    description = map[columnDescription];
    filePath = map[columnFilePath];
    isImage = map[columnIsImage] == '0' ? false : true;
    pdfPath = map[columnWindowsPDFPath];
  }

  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnName: name,
      columnYear: year,
      columnCreated: created.toIso8601String(),
      columnNumber: number,
      columnSystemDepth: systemDepth,
      columnProfileSystem: profileSystem,
      columnDescription: description,
      columnFilePath: filePath,
      columnIsImage: isImage ? '1' : '0',
      columnWindowsPDFPath: pdfPath
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Future<String> getHtmlString(String htmlFile) async {
    String htmlStr = htmlFile;
    if(filePath != null && filePath != ''){
      if(isImage) {
        htmlStr = htmlStr.replaceAll('#articleImage#', 'file://'+filePath);
      }
      else {
        htmlStr = htmlStr.replaceAll('<tr class="details"><td> <img src="#articleImage#" style="width:300%; max-width:300px;"></td></tr>', '');
      }
    }
    else {
      htmlStr = htmlStr.replaceAll('<tr class="details"><td> <img src="#articleImage#" style="width:300%; max-width:300px;"></td></tr>', '');
    }
    Directory directory = await getApplicationDocumentsDirectory();
    var dbPath = join(directory.path, "logoImage.png");
    ByteData data = await rootBundle.load("assets/repairService.png");
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(dbPath).writeAsBytes(bytes);
    htmlStr = htmlStr.replaceAll('#LOGOIMAGE#', 'file://'+dbPath);
    htmlStr = htmlStr.replaceAll("#CREATED#", created.month.toString() + '/' + created.day.toString() + '/' + created.year.toString());
    if (Company.currentCompany != null){
      htmlStr = htmlStr.replaceAll('#COMPANYPROFILE#', Company.currentCompany.htmlLayoutPreview());
    }
    else {
      htmlStr = htmlStr.replaceAll('#COMPANYPROFILE#', '');
    }
    htmlStr = htmlStr.replaceAll('#ISWINDOWS#', name);
    if(number != null && number != 0){
      htmlStr = htmlStr.replaceAll('#articleNumber#', '$number');
    }
    else {
      htmlStr = htmlStr.replaceAll('<tr class="heading"><td> Part number of defective component </td><td> <br></td></tr><tr class="details"><td> #articleNumber# </td></tr>', '');
    }
    if(year != null && year !=''){
      htmlStr = htmlStr.replaceAll('#year#', year);
    }
    else {
      htmlStr = htmlStr.replaceAll('<tr class="heading"><td> Year of contruction </td><td> <br></td></tr><tr class="details"><td> #year# </td></tr>', '');
    }
    if(systemDepth != null && systemDepth !=''){
      htmlStr = htmlStr.replaceAll('#systemDepth#', systemDepth);
    }
    else {
      htmlStr = htmlStr.replaceAll('<tr class="heading"><td> Systen depth (mm) </td><td> <br></td></tr><tr class="details"><td> #systemDepth# </td></tr>', '');
    }
    if(profileSystem != null && profileSystem !=''){
      htmlStr = htmlStr.replaceAll('#profileSystem#', profileSystem);
    }
    else {
      htmlStr = htmlStr.replaceAll('<tr class="heading"><td> Profile system / -serie </td><td> <br></td></tr><tr class="details"><td> #profileSystem# </td></tr>', '');
    }
    if(description != null && description != ''){
      htmlStr = htmlStr.replaceAll('#description#', description);
    }
    else {
      htmlStr = htmlStr.replaceAll('<tr class="heading"><td> Description </td><td> <br></td></tr><tr class="details"><td> #description# </td></tr>', '');
    }
    debugPrint(htmlStr);
    return htmlStr;
  }
}