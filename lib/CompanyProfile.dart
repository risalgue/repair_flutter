import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'database_helpers.dart';
import 'package:repairservices/models/Company.dart';
import 'CreateCompany.dart';
import 'dart:io';

class CompanyProfileV extends StatefulWidget {
  @override
  CompanyProfileState createState() => new CompanyProfileState();
}

class CompanyProfileState extends State<CompanyProfileV> {
  DatabaseHelper helper = DatabaseHelper.instance;
  List<Company> companyList;

  _readValues() async {
    this.companyList = await helper.queryAllCompany();
    for(Company company in this.companyList){
      if(company.defaultC){
        Company.currentCompany = company;
      }
    }
    this.setState((){});
    debugPrint("Company count: " + this.companyList.length.toString());
  }

  _updateCompany(Company company) async {
    int id = await helper.updateCompany(company);
    print('updated row: $id');
    this._readValues();
  }

  @override
  void initState() {
    super.initState();
    this.setState((){
      _readValues();
    });
  }
  Image _loadImage(Company company) {
    if (company.logoPath != null && company.logoPath != "") {
      return Image.file(File(company.logoPath)) ;
    }
    else {
      return Image.asset('assets/buildingGreen.png');
    }
  }

  Widget _getAditionalInformation(Company company) {
    if (company.additionalInf == null || company.additionalInf == "") {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 8,vertical: 0),
        height: 0,
      );
    }
    else {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 8,vertical: 0),
        child:  Text(
          company.additionalInf,
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.body2,
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        backgroundColor: Colors.white,
        actionsIconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text("Company Profile",style: Theme.of(context).textTheme.body1),
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new GestureDetector(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(left: 16.0, top: 16),
                              child: Image.asset('assets/plusGreen.png')
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20.0,top: 16.0),
                            child: Text('Create comany profile',style: Theme.of(context).textTheme.body1),
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8,left: 60, bottom: 8),
                        child: Text('Create your personal company profile to enter your contact details and company logo in the export document',
                            style: Theme.of(context).textTheme.body2),
                      ),
                      Divider()
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreateCompanyV(new Company(),true)),
                    ).then((_) {
                      this.setState(() {
                        _readValues();
                      });
                    });
                  },
                ),
                Expanded(
                  child: new ListView.builder(
                    itemCount: companyList == null ? 0 : companyList.length,
                    itemBuilder: (BuildContext context, int index){
                      return ListTile(
                        contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 16),
                        leading: new Container(
//                            margin: EdgeInsets.only(left: 16),
                            width: 40,
                            height: 40,
                            child: _loadImage(companyList[index]),
                          ),
                        title: new Container(
                            margin: EdgeInsets.only(top: 0, left: 8),
                            child: Text(
                                companyList[index].name,
                                style:  Theme.of(context).textTheme.body1
                            ),
                        ),
                        subtitle: new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            this._getAditionalInformation(companyList[index]),
                            new Row(
                              children: <Widget>[
                                new Container(
                                    margin: EdgeInsets.only(left: 8,top: 4),
                                    child: Text(
                                        'Default company',
                                        style:  TextStyle(
                                          fontSize: 14,
                                          color: Color.fromRGBO(38, 38, 38, 1.0)
                                        )
                                    ),
                                  ),
                                new Transform.scale(
                                  scale: 0.75,
                                  child: CupertinoSwitch(
                                    value: companyList[index].defaultC == null ? false : companyList[index].defaultC,
                                    activeColor: Theme.of(context).primaryColor,
                                    onChanged: (bool value) {
                                      setState(() {
                                        companyList[index].defaultC = value;
                                        this._updateCompany(companyList[index]);
                                        if (value == true) {
                                          for (Company company in companyList) {
                                            if (company.id != companyList[index].id) {
                                              company.defaultC = false;
                                              this._updateCompany(company);
                                            }
                                          }
                                        }
                                      });
                                    },
                                  ),
                                ),

                              ],
                            )
                          ],
                        ),
                        trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CreateCompanyV(companyList[index],false)),
                          ).then((_) {
                            this.setState(() {
                              _readValues();
                            });
                          });
                        },
                      );
//                      return CupertinoButton(
//                        padding: EdgeInsets.all(0),
//                        onPressed: () {
//                          Navigator.push(
//                            context,
//                            MaterialPageRoute(builder: (context) => CreateCompanyV(companyList[index],false)),
//                          ).then((_) {
//                            this.setState(() {
//                              _readValues();
//                            });
//                          });
//                        },
//                        child: new Column(
//                            mainAxisAlignment: MainAxisAlignment.start,
//                            crossAxisAlignment: CrossAxisAlignment.start,
//                            children: <Widget>[
//                              new Row(
//                                mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                children: <Widget>[
//                                  new Container(
//                                    margin: EdgeInsets.only(left: 16),
//                                    width: 24,
//                                    height: 24,
//                                    child: _loadImage(companyList[index]),
//                                  ),
//                                  new Expanded(
//                                      child: new Column(
//                                        mainAxisAlignment: MainAxisAlignment.start,
//                                        crossAxisAlignment: CrossAxisAlignment.start,
//                                        children: <Widget>[
//                                          new Container(
//                                            margin: EdgeInsets.only(top: 8, left: 16),
//                                            child: Text(
//                                                companyList[index].name,
//                                                style:  Theme.of(context).textTheme.body1
//                                            ),
//                                          ),
//                                          new Container(
//                                            margin: EdgeInsets.only(top: 8, left: 16),
//                                            child: Text(
//                                                companyList[index].additionalInf,
//                                                style:  Theme.of(context).textTheme.body2
//                                            ),
//                                          )
//                                        ],
//                                      )
//                                  ),
//
//                                ],
//                              ),
//                              new Row(
//                                children: <Widget>[
//                                  new Container(
//                                    margin: EdgeInsets.only(left: 56),
//                                    child: Text(
//                                        'Default company',
//                                        style:  Theme.of(context).textTheme.body1
//                                    ),
//                                  ),
//                                  new Container(
//                                    margin: EdgeInsets.only(left: 16),
//                                    child: CupertinoSwitch(
//                                      value: companyList[index].defaultC == null ? false : companyList[index].defaultC,
//                                      activeColor: Theme.of(context).primaryColor,
//                                      onChanged: (bool value) {
//                                        setState(() {
//                                          companyList[index].defaultC = value;
//                                          this._updateCompany(companyList[index]);
//                                          if (value == true) {
//                                            for (Company company in companyList) {
//                                              if (company.id != companyList[index].id) {
//                                                company.defaultC = false;
//                                                this._updateCompany(company);
//                                              }
//                                            }
//                                          }
//                                        });
//                                      },
//                                    ),
//                                  )
//                                ],
//                              )
//                            ]
//                        ),
//                      );
                    },
//                    shrinkWrap: true,
                  ),
                )
              ]
          )
      ),
    );
  }

}