// database table and column names
final String tableCompany = 'company';
final String columnCompanyId = '_id';
final String columnCompanyName = 'name';
final String columnAdditionalInf = 'additionalInf';
final String columnPhone = 'phone';
final String columnEmail = 'email';
final String columnFax = 'fax';
final String columnWebsite = 'website';
final String columnLogoPath = 'logoPath';
final String columnStreet = 'street';
final String columnHouseNumber = 'houseNumber';
final String columnExtraAddressLine = 'extraAddressLine';
final String columnPostCode = 'postCode';
final String columnLocation = 'location';
final String columnLat = 'lat';
final String columnLng = 'lng';
final String columnTextExportEmail = 'textExportEmail';
final String columnDefaultC = 'defaultC';

// data model class
class Company {
  int id;
  String name;
  String additionalInf;
  String phone;
  String email;
  String fax;
  String website;
  String logoPath;
  String textExportEmail;
  bool defaultC;
  Address address = Address();

  Company();

  // convenience constructor to create a Word object
  Company.fromMap(Map<String, dynamic> map) {
    id = map[columnCompanyId];
    name = map[columnCompanyName];
    additionalInf = map[columnAdditionalInf];
    phone = map[columnPhone];
    email = map[columnEmail];
    fax = map[columnFax];
    website = map[columnWebsite];
    logoPath = map[columnLogoPath];

    address = Address.withData(
        map[columnStreet],
        map[columnHouseNumber],
        map[columnExtraAddressLine],
        map[columnPostCode],
        map[columnLat],
        map[columnLng],
        map[columnLocation]);
    textExportEmail = map[columnTextExportEmail];
    defaultC = map[columnDefaultC] == 0 ? false : true;
  }

  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnCompanyName: name,
      columnAdditionalInf: additionalInf,
      columnPhone: phone,
      columnEmail: email,
      columnFax: fax,
      columnWebsite: website,
      columnLogoPath: logoPath,
      columnStreet: address.street,
      columnHouseNumber: address.houseNumber,
      columnExtraAddressLine: address.extraAddressLine,
      columnPostCode: address.postCode,
      columnLat: address.lat,
      columnLng: address.lng,
      columnTextExportEmail: textExportEmail,
      columnLocation: address.location,
      columnDefaultC: defaultC == true ? 1 : 0
    };
    if (id != null) {
      map[columnCompanyId] = id;
    }
    return map;
  }
}

class Address {
  String street;
  int houseNumber;
  String extraAddressLine;
  int postCode;
  double lat;
  double lng;
  String location;
  String companyName,city,country;

  Address();
  Address.withData(street,houseNumber,extraAddressLine,postCode,lat,lng,location) {
    this.street = street;
    this.houseNumber = houseNumber;
    this.extraAddressLine = extraAddressLine;
    this.postCode = postCode;
    this.lat = lat;
    this.lng = lng;
    this.location = location;
  }
  Address.forOrder(companyName,street,houseNumber,city,postCode,country){
    this.companyName = companyName;
    this.street = street;
    this.houseNumber = houseNumber;
    this.city = city;
    this.postCode = postCode;
    this.country = country;
  }
}