import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:repairservices/EditPicture.dart';
import 'package:repairservices/FittingSelection.dart';
import 'package:repairservices/Utils/DeviceInfo.dart';

class IdentificationTypeV extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return IdentificationTypeState();
  }

}

class IdentificationTypeState extends State<IdentificationTypeV> {
  String imagePath;
  bool isPhysicalDevice = true;

  @override
  initState(){
    super.initState();
    _isPhysicalDevice();
  }

  Future _getImageFromSource(ImageSource source) async {
    final File image = await ImagePicker.pickImage(source: source);
    final directory = await getApplicationDocumentsDirectory();
    final File newImage = await image.copy('${directory.path}/${DateTime.now().toUtc().toIso8601String()}.png');
    imagePath = newImage.path;
    _showAlertDialog(context);
  }
  _isPhysicalDevice()async{
    final deviceData = DeviceInfo();
    await deviceData.initPlatformState();
    final isPhysicalDevice = deviceData.getData()['isPhysicalDevice'];
    debugPrint('physical ${deviceData.getData()}');
    setState(() {
      this.isPhysicalDevice = isPhysicalDevice;
    });
  }

  Widget _fromGallery() {
    if(isPhysicalDevice){
      return Container(
      );
    }
    else {
      return InkWell(
        child: Icon(Icons.image),
        onTap: ()=>_getImageFromSource(ImageSource.gallery),
      );
    }
  }

  void _showAlertDialog(BuildContext context) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context ) => CupertinoAlertDialog(
          title: new Text('Send by Email', style: Theme.of(context).textTheme.subhead),
          content: Padding(
            padding: EdgeInsets.symmetric(vertical: 8,horizontal: 8),
            child: Text('Do you want to send this article after adding the measurements and saving it?',
              style: TextStyle(fontSize: 16),textAlign: TextAlign.justify,),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: new Text('Just save it', style: TextStyle(color: Theme.of(context).primaryColor)),
              isDefaultAction: true,
              onPressed: (){
                Navigator.pop(context);
                Navigator.push(context, CupertinoPageRoute(builder: (context)=>EditPicture(imagePath, false)));
              },
            ),
            CupertinoDialogAction(
              child: new Text('Save it and send by email', style: TextStyle(color: Theme.of(context).primaryColor)),
              isDefaultAction: true,
              onPressed: (){
                Navigator.pop(context);
                Navigator.push(context, CupertinoPageRoute(builder: (context)=>EditPicture(imagePath, true)));
              },
            ),
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        backgroundColor: Colors.white,
        actionsIconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text("Identification Type",style: Theme.of(context).textTheme.body1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Theme.of(context).primaryColor,
        ),
      ),
      body: new Container(
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                      child: Container(
                        padding: EdgeInsets.all(8),
//                      color: Theme.of(context).primaryColor,
                        child: InkWell(
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'assets/cameraGreen.png',
                              ),
                              new Container(
                                child: new Text(
                                    'Camera',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.body1
                                ),
                                margin: EdgeInsets.only(top: 26),
                              )
                            ],
                          ),
                          onTap: (){
                            _getImageFromSource(ImageSource.camera);
                          },
                        ),
                      )
                  ),
                  Container(
                    color: Colors.grey,
                    width: 1,
                    height: MediaQuery.of(context).size.width / 2 - 40,
                  ),
                  Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 24,left: 8,right: 8,bottom: 8),
//                      color: Theme.of(context).primaryColor,
                        child: InkWell(
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'assets/notesGreen.png',
                              ),
                              new Container(
                                child: new Text(
                                    'Record Product \n Data',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.body1
                                ),
                                margin: EdgeInsets.only(top: 26),
                              )
                            ],
                          ),
                          onTap: (){
                            Navigator.push(
                              context,
                              CupertinoPageRoute(builder: (context) => FittingSelection()),
                            );
                          },
                        ),
                      )
                  ),
                ],
              ),
              Container(
                color: Colors.grey,
                height: 1,
                width: MediaQuery.of(context).size.width,
              ),
              _fromGallery()
            ],
          )
      ),
    );
  }
}