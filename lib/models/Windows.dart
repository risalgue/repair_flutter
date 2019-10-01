// database table and column names
final String tableWindows = 'windows';
final String columnId = '_id';
final String columnName = 'name';
final String columnCreated = 'created';
final String columnNumber = 'number';
final String columnSystemDepth = 'systemDepth';
final String columnProfileSystem = 'profileSystem';
final String columnDescription = 'description';
final String columnFile = 'file';

// data model class
class Windows {

  int id;
  String name;
  DateTime created;
  int number;
  String systemDepth;
  String profileSystem;
  String description;

  Windows();

  // convenience constructor to create a Word object
  Windows.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    name = map[columnName];
    String createdStr = map[columnCreated];
    created = DateTime.parse(createdStr);
    number = map[columnNumber];
    systemDepth = map[columnSystemDepth];
    profileSystem = map[columnProfileSystem];
    description = map[columnDescription];
  }

  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnName: name,
      columnCreated: created.toIso8601String(),
      columnNumber: number,
      columnSystemDepth: systemDepth,
      columnProfileSystem: profileSystem,
      columnDescription: description
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
}