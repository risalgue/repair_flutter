import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsArticleIdentificationV extends StatefulWidget {
  @override
  SettingsArticleIdentificationState createState() => new SettingsArticleIdentificationState();
}

class SettingsArticleIdentificationState extends State<SettingsArticleIdentificationV> {

  bool _showTips;
  bool _gpsPhotos;
  bool _savePhotos;
  bool _showTutorial;

  _readValues() async {
//    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    _showTips = prefs.getBool('showTips') ?? false;
    _gpsPhotos = prefs.getBool('gpsPhotos') ?? true;
    _savePhotos = prefs.getBool('savePhotos') ?? true;
    _showTutorial = prefs.getBool('showTutorial') ?? false;
    this.setState((){

    });
  }

  _saveValue(bool value, String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
    print('saved $value');
  }

  @override
  void initState() {
    super.initState();
    this.setState((){
      _readValues();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        backgroundColor: Colors.white,
        actionsIconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text("Settings",style: Theme.of(context).textTheme.body1),
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
              debugPrint('Help button taped taped');
            },
            child: Image.asset(
              'assets/questionMarkGreen.png',
              height: 25,
            ),

          ),
        ],
      ),
      body: new Container(
          child: new Column(
//          crossAxisAlignment: CrossAxisAlignment.,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 16,top: 4),
                      child: Text(
                        'Show tips for editing',
                        style: Theme.of(context).textTheme.body1,
                      )
                  ),

                  Container(
                    margin: EdgeInsets.only(right: 16,top: 4),
                    child: CupertinoSwitch(
                      value: _showTips == null ? false : _showTips,
                      activeColor: Theme.of(context).primaryColor,
                      onChanged: (bool value) {
                        setState(() {
                          _showTips = value;
                          this._saveValue(value, 'showTips');
                        });
                      },
                    ),
                  )
                ],
              ),
              Divider(),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(left: 16,top: 4),
                      child: Text(
                        'GPS Tag for photos',
                        style: Theme.of(context).textTheme.body1,
                      )
                  ),

                  Container(
                    margin: EdgeInsets.only(right: 16,top: 4),
                    child: CupertinoSwitch(
                      value: _gpsPhotos == null ? true : _gpsPhotos,
                      activeColor: Theme.of(context).primaryColor,
                      onChanged: (bool value) {
                        setState(() {
                          _gpsPhotos = value;
                          this._saveValue(value, 'gpsPhotos');
                        });
                      },
                    ),
                  )
                ],
              ),
              Divider(),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(left: 16,top: 4),
                      child: Text(
                        'Save photos on device gallery',
                        style: Theme.of(context).textTheme.body1,
                      )
                  ),

                  Container(
                    margin: EdgeInsets.only(right: 16,top: 4),
                    child: CupertinoSwitch(
                      value: _savePhotos == null ? true : _savePhotos,
                      activeColor: Theme.of(context).primaryColor,
                      onChanged: (bool value) {
                        setState(() {
                          _savePhotos = value;
                          this._saveValue(value, 'savePhotos');
                        });
                      },
                    ),
                  )
                ],
              ),
              Divider(),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(left: 16,top: 4),
                      child: Text(
                        'Show tutorial at every start',
                        style: Theme.of(context).textTheme.body1,
                      )
                  ),

                  Container(
                    margin: EdgeInsets.only(right: 16,top: 4),
                    child: CupertinoSwitch(
                      value: _showTutorial == null ? false : _showTutorial,
                      activeColor: Theme.of(context).primaryColor,
                      onChanged: (bool value) {
                        setState(() {
                          _showTutorial = value;
                          this._saveValue(value, 'showTutorial');
                        });
                      },
                    ),
                  )
                ],
              ),
              Divider()
            ]
          )
      ),
    );
  }

}