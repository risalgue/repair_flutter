import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservices/models/Company.dart';
import 'CompanyData.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'database_helpers.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'CompanyLayoutPreview.dart';
import 'CompanyEmailStandartText.dart';

class CreateCompanyV extends StatefulWidget {

  final Company company;
  final bool newCompany;
  CreateCompanyV(this.company,this.newCompany);

  @override
  CreateCompanyState createState() => new CreateCompanyState(this.company,this.newCompany);
}

class CreateCompanyState extends State<CreateCompanyV> {
  File _image;
  Company company;
  bool newCompany;
  bool canSave = false;
  DatabaseHelper helper = DatabaseHelper.instance;
  CreateCompanyState(this.company,this.newCompany);
  final weblinkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (company.logoPath != null && company.logoPath != "") {
      _image = File(company.logoPath);
    }
  }
  String lastSelectedValue;

  void showDemoActionSheet({BuildContext context, Widget child}) {
    showCupertinoModalPopup<String>(
      context: context,
      builder: (BuildContext context) => child,
    ).then((String value) {
      if (value != null) {
        setState(() { lastSelectedValue = value; });
      }
    });
  }

  void showAlertDialogWeblink(BuildContext context) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context ) => CupertinoAlertDialog(
          title: new Text('Write de url of your logo'),
          content: new Container(
            margin: EdgeInsets.only(top: 16),
            child: new CupertinoTextField(
                textAlign: TextAlign.left,
                expands: false,
                style: Theme.of(context).textTheme.body1,
                keyboardType: TextInputType.url,
                maxLines: 1,
                controller: weblinkController,
                placeholder: 'https://www.mycompany.com/logo.png',
//                placeholderStyle: TextStyle(color: Colors.grey,fontSize: 14),
            )
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: new Text(
                  'Download',
                  style: TextStyle(color: Theme.of(context).primaryColor)),
              isDefaultAction: true,
              onPressed: () {
                _downloadImage();
                Navigator.pop(context);
              }
            ),
            CupertinoDialogAction(
              child: new Text("Cancel"),
              isDestructiveAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        )
    );
  }

  void _onActionSheetPress(BuildContext context)  {
    showDemoActionSheet(
      context: context,
      child: CupertinoActionSheet(
//        title: const Text('Favorite Dessert'),
//        message: const Text('Please select the best dessert from the options below.'),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: new Text('Choose from gallery', style: Theme.of(context).textTheme.display1),
            onPressed: (){
              Navigator.pop(context, 'weblink');
              getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: new Text('Import from weblink', style: Theme.of(context).textTheme.display1),
            onPressed: () {
              Navigator.pop(context, 'weblink');
              this.showAlertDialogWeblink(context);
            },
          )
        ],
        cancelButton: CupertinoActionSheetAction(
          child: new Text('Cancel', style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 22.0,fontWeight: FontWeight.w700)),
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context, 'Cancel'),
        ),
      ),
    );
  }

  Future getImageFromCamera() async {
    final File image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  Future getImageFromGallery() async {
    final File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    final directory = await getApplicationDocumentsDirectory();
    final File newImage = await image.copy('${directory.path}/${DateTime.now().toUtc().toIso8601String()}.png');
    debugPrint(newImage.path);
    company.logoPath = newImage.path;
    setState(() {
      _image = image;

    });
  }

  _saveCompany() async {
    company.defaultC = false;
    int id = await helper.insertCompany(company);
    print('inserted row: $id');
  }

  Future _downloadImage() async {
    var response = await http.get(weblinkController.text);
    var documentDirectory = await getApplicationDocumentsDirectory();

    File file = new File(
        join(documentDirectory.path, '${DateTime.now().toUtc().toIso8601String()}.png')
    );
    file.writeAsBytes(response.bodyBytes);
    company.logoPath = file.path;
    setState(() {

      _image = file;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        backgroundColor: Colors.white,
        actionsIconTheme: IconThemeData(color: Colors.grey),
        title: Text(this.newCompany == false ? "Company Details" : "Create Company",style: Theme.of(context).textTheme.body1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Theme.of(context).primaryColor,
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              _saveCompany();
              Navigator.pop(context);
            },
            child: Image.asset(canSave == true ? 'assets/checkGreen.png' : 'assets/checkGrey.png',
              height: 25,
            ),

          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: Text(
              'Company data',
              style: Theme.of(context).textTheme.body1,
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CompanyDataV(this.company)))
              .then((value) {
                this.setState(() {
                  debugPrint(company.name);
                  if (company.name != null && company.name != "") {
                    canSave = true;
                  }
                  else {
                    canSave = false;
                  }
                });
              });
            },
          ),
          Divider(height: 1),
          ListTile(
            title: Text(
              'Company Logo',
              style: Theme.of(context).textTheme.body1,
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              _onActionSheetPress(context);
            },
          ),
          Divider(height: 1),
          ListTile(
            title: Text(
              'Layout preview',
              style: Theme.of(context).textTheme.body1,
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => new CompanyLayoutPreview(company)));
            },
          ),
          Divider(height: 1),
          ListTile(
            title: Text(
              'E-mail standart text',
              style: Theme.of(context).textTheme.body1,
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => new CompanyEmailStandartTextV(company)))
                  .then((value) {
                this.setState(() {
                  debugPrint(company.textExportEmail);
                });
              });
            },
          ),
          Divider(height: 1),
          Container(
            width: 100,
            height: 100,
            child: Center(
              child: _image == null ? Text('not image selected') : Image.file(_image) ,
            ),
          )
        ],
      ),
    );
  }
}