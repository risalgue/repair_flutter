import 'dart:io';

import 'package:flutter/material.dart';
import 'package:repairservices/models/Company.dart';

class CompanyLayoutPreview extends StatelessWidget {
  final Company comp;

  CompanyLayoutPreview(this.comp);

  String _componeAddress() {
//    String loc = "";
//    if (comp.address.lat != null && comp.address.lat != 0) {
//      loc = "${comp.address.lat}, ${comp.address.lng}";
//    }
    var address = List<String>();

    if (comp.address.street != null && comp.address.street != ""){
      address.add(comp.address.street);
    }
    if (comp.address.houseNumber != null) {
      if (address.length > 0) {
      address.add(" ${comp.address.houseNumber}");
      }
      else {
        address.add("${comp.address.houseNumber}");
      }
    }
    if (comp.address.extraAddressLine != null && comp.address.extraAddressLine != "") {
      if (address.length > 0) {
        address.add(", ${comp.address.extraAddressLine}");
      }
      else {
        address.add("${comp.address.extraAddressLine}");
      }
    }
    if (comp.address.postCode != null) {
      if (address.length > 0) {
        address.add(", ${comp.address.postCode}");
      }
      else {
        address.add("${comp.address.postCode}");
      }
    }
    if (comp.address.location != null && comp.address.location != "") {
      if (address.length > 0) {
        address.add(", ${comp.address.location}");
      }
    }
    String completeAddressStr = "";
    for(String text in address) {
      completeAddressStr += text;
    }
//    debugPrint(completeAddressStr);
    return completeAddressStr;
  }
  Image _dislplayImage() {
    if (comp.logoPath != null && comp.logoPath != "") {
      return Image.file(File(comp.logoPath));
    }
    else {
      return Image.asset('assets/buildingGreenHome.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          backgroundColor: Colors.white,
          actionsIconTheme: IconThemeData(color: Colors.grey),
          title: Text("Layout Preview",style: Theme.of(context).textTheme.body1),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Theme.of(context).primaryColor,
          ),
        ),
        body: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            new Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8,horizontal: 8),
                      child: new Center(
                        child: new Text(
                          comp.name != null ? comp.name : "",
                          style: TextStyle(
                            color: Theme.of(context).textTheme.subhead.color,
                            fontSize: 18,
                            fontWeight: Theme.of(context).textTheme.subhead.fontWeight
                          ),
                        ),
                      )
                  ),
                ),
                new Container(
                  padding: EdgeInsets.all(8),
                  height: 100,
                  width: 100,
                  child: _dislplayImage(),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 16,bottom: 8),
              child: Text('Company data',style: Theme.of(context).textTheme.subhead,textAlign: TextAlign.left),
            ),
            Divider(height: 1),
            Container(
              margin: EdgeInsets.symmetric(vertical: 4,horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Address: ',style: Theme.of(context).textTheme.body1),
                  Expanded(
                    child: Text(_componeAddress() !=null ? _componeAddress() : "",style: Theme.of(context).textTheme.body1,maxLines: 2),
                  ),
                ],
              ),

            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 4,horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Aditional information: ',style: Theme.of(context).textTheme.body1),
                  Expanded(
                    child: Text(comp.additionalInf != null ? comp.additionalInf : "",style: Theme.of(context).textTheme.body1),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 4,horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Telephone number: ',style: Theme.of(context).textTheme.body1),
                  Expanded(
                    child: Text(comp.phone != null ? comp.phone: "",style: Theme.of(context).textTheme.body1),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 4,horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('E-mail address: ',style: Theme.of(context).textTheme.body1),
                  Expanded(
                    child: Text(comp.email!= null ? comp.email: "",style: Theme.of(context).textTheme.body1),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 4,horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Fax: ',style: Theme.of(context).textTheme.body1),
                  Expanded(
                    child: Text(comp.fax != null ? comp.fax: "",style: Theme.of(context).textTheme.body1),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 4,horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Website: ', style: Theme.of(context).textTheme.body1),
                  Expanded(
                    child: Text(comp.website != null ? comp.website: "",style: Theme.of(context).textTheme.body1),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 16,bottom: 8,top: 8),
              child: Text('E-mail standart text',style: Theme.of(context).textTheme.subhead,textAlign: TextAlign.left),
            ),
            Divider(height: 1),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
                scrollDirection: Axis.vertical,
                child: Text(comp.textExportEmail != null ? comp.textExportEmail : "",style: Theme.of(context).textTheme.body1),
              )
            ),
          ],
        )
    );
  }
}