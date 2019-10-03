import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'database_helpers.dart';
import 'package:repairservices/models/Windows.dart';
import 'IdentificationType.dart';
import 'SettingArticleIdentification.dart';

class ArticleIdentificationV extends StatefulWidget {
  @override
  _ArticleIdentificationState createState() => new _ArticleIdentificationState();

}

class _ArticleIdentificationState extends State<ArticleIdentificationV> {

  DatabaseHelper helper = DatabaseHelper.instance;
  List<Windows> articleWindows;

  int selected = 0;
//  _readWindows(int rowId) async {
//    rowId = 1;
//    Windows windows = await helper.queryWindows(rowId);
//    if (windows == null) {
//      print('read row $rowId: empty');
//    } else {
//      print('read row $rowId: ${windows.name} ${windows.created}');
//    }
//  }
  _readAllWindows() async {
    this.articleWindows = await helper.queryAllWindows();
    this.setState((){

    });
    debugPrint(articleWindows.length.toString());
  }
  _saveWindows() async {
    Windows windows = Windows();
    windows.name = 'Fitting Windows';
    windows.created = DateTime.now();
    windows.description = 'My description of the fitting selection article windows';
    windows.number = 582935892385;
    windows.systemDepth = '50mm';
    windows.profileSystem = 'System Serie 50 DPL';
    int id = await helper.insert(windows);
    print('inserted row: $id');
    this._readAllWindows();
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

  void _onActionSheetPress(BuildContext context)  {
    showDemoActionSheet(
      context: context,
      child: CupertinoActionSheet(
//        title: const Text('Favorite Dessert'),
//        message: const Text('Please select the best dessert from the options below.'),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: new Text('Print', style: Theme.of(context).textTheme.display1),
            onPressed: () => Navigator.pop(context, 'Print'),
          ),
          CupertinoActionSheetAction(
            child: new Text('Email', style: Theme.of(context).textTheme.display1),
            onPressed: () => Navigator.pop(context, 'Email'),
          ),
          CupertinoActionSheetAction(
            child: new Text('Remove', style: TextStyle(color: Colors.red,fontSize: 22.0)),
            isDestructiveAction: true,
            onPressed: () => Navigator.pop(context, 'Remove'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: new Text('Cancel', style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 22.0,fontWeight: FontWeight.w700)),
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context, 'Cancel'),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    this.setState((){
      _readAllWindows();
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
        title: Text("Article Identification",style: Theme.of(context).textTheme.body1,),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Theme.of(context).primaryColor,
        ),
        actions: <Widget>[
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.image),
          ),
//          IconButton(
//            onPressed: () {
//              _readAllWindows();
//            },
//            icon: Icon(Icons.update),
//          ),
          IconButton(
            onPressed: () {
              _saveWindows();
            },
            icon: Icon(Icons.save),
          )
        ],
      ),

      body: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Expanded(
//            height: MediaQuery.of(context).size.height - 35 - kToolbarHeight - kBottomNavigationBarHeight,
//            padding: EdgeInsets.only(bottom: 65, top: 0, left: 0,right: 0),
//            margin: EdgeInsets.only(bottom: 65, top: 0, left: 0,right: 0),
            child: new ListView.separated(
              itemCount: articleWindows == null ? 0 : articleWindows.length,
              itemBuilder: (BuildContext context, int index){
                return new Container(
                  color: Color.fromRGBO(243, 243, 243, 1.0),
                  child: new ListTile(
                    leading: Image.asset('assets/productImage.png'),
                    title: Text(
                        articleWindows[index].name,
                        style:  Theme.of(context).textTheme.body1
                    ),
                    subtitle:  Text(
                        articleWindows[index].created.month.toString() + "-" + articleWindows[index].created.day.toString() + "-" + articleWindows[index].created.year.toString(),
                        style: Theme.of(context).textTheme.body2
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: (){
                      debugPrint("Index: " + index.toString());
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  height: 1,
                  color: Color.fromRGBO(191, 191, 191, 1.0),
                );
              },
              shrinkWrap: true,
            ),
          ),
          new Container(
            margin: EdgeInsets.only(bottom: 0),
            height: 65,
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).primaryColor,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new InkWell(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        margin: EdgeInsets.only(bottom: 8),
                        child: new Image.asset('assets/gearWhite.png'),
                      ),
                      new Text(
                        'Setting',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          letterSpacing: 0.5
                        ),
                      )
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsArticleIdentificationV()),
                    );
                  },
                ),
                new InkWell(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        margin: EdgeInsets.only(bottom: 8),
                        child: new Image.asset('assets/articleLookUpWhite.png'),
                      ),
                      new Text(
                        'Find Part',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          letterSpacing: 0.5
                        ),
                      )
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => IdentificationTypeV()),
                    );
                  },
                ),
                new InkWell(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        margin: EdgeInsets.only(bottom: 12),
                        child: new Image.asset('assets/exportWhite.png'),
                      ),
                      new Text(
                        'Export',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          letterSpacing: 0.5
                        ),
                      )
                    ],
                  ),
                  onTap: () => selected == 0 ? _onActionSheetPress(context) : (){},
                )
              ],
            ),
          )
        ],
      )

    );
  }
}