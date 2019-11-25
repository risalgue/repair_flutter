import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:repairservices/ArticleWebPreview.dart';
import 'package:repairservices/database_helpers.dart';
import 'package:repairservices/models/Sliding.dart';

class SlidingDimension extends StatefulWidget {
  final Sliding sliding;
  SlidingDimension(this.sliding);
  @override
  State<StatefulWidget> createState() {
    return SlidingDimensionState(this.sliding);
  }

}

class SlidingDimensionState extends State<SlidingDimension>{
  Sliding sliding;
  SlidingDimensionState(this.sliding);
  FocusNode aNode,bNode,cNode,dNode;
  final aCtr = TextEditingController();
  final bCtr = TextEditingController();
  final cCtr = TextEditingController();
  final dCtr = TextEditingController();
  final dimensionCtr = TextEditingController();
  var imageKey1 = new GlobalKey();
  String imagePath1;
  File dimensionImage1;
  DatabaseHelper helper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    aNode = FocusNode();
    bNode = FocusNode();
    cNode = FocusNode();
    dNode = FocusNode();
  }

  @override
  void dispose() {
    aNode.dispose();
    bNode.dispose();
    cNode.dispose();
    dNode.dispose();
    super.dispose();
  }

  void showAlertDialogDimension(BuildContext context, String dimension) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context ) => CupertinoAlertDialog(
          title: new Text('Dimension $dimension'),
          content: new Container(
              margin: EdgeInsets.only(top: 16),
              child: new CupertinoTextField(
                textAlign: TextAlign.left,
                expands: false,
                style: Theme.of(context).textTheme.body1,
                keyboardType: TextInputType.number,
                maxLines: 1,
                controller: dimensionCtr,
                placeholder: 'mm',
              )
          ),
          actions: <Widget>[
            CupertinoDialogAction(
                child: new Text('OK', style: TextStyle(color: Theme.of(context).primaryColor)),
                isDefaultAction: true,
                onPressed: () {
                  Navigator.pop(context);
                  if (dimensionCtr.text != "" && int.parse(dimensionCtr.text) != 0){
                    switch(dimension){
                      case 'A':
                        aCtr.text = int.parse(dimensionCtr.text).toString();
                        takeScreenShoot();
                        break;
                      case 'B':
                        bCtr.text = int.parse(dimensionCtr.text).toString();
                        takeScreenShoot();
                        break;
                      case 'C':
                        cCtr.text = int.parse(dimensionCtr.text).toString();
                        takeScreenShoot();
                        break;
                      default:
                        dCtr.text = int.parse(dimensionCtr.text).toString();
                        takeScreenShoot();
                    }
                  }
                  else {
                    Navigator.pop(context);
                    showAlertDialog(context, "0 is not valid value for this dimension", "OK");
                  }
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

  takeScreenShoot() async {
    setState(() {});
    await Future.delayed(Duration(seconds: 1),() async {
      debugPrint('taking screenshot');
      RenderRepaintBoundary boundary = imageKey1.currentContext.findRenderObject();
      var image = await boundary.toImage();
      var byteData = await image.toByteData(format: ImageByteFormat.png);
      final buffer = byteData.buffer;
      final directory = await getApplicationDocumentsDirectory();
      final path = '${directory.path}/${DateTime.now().toUtc().toIso8601String()}.png';

      File(path).writeAsBytesSync(buffer.asUint8List(byteData.offsetInBytes,byteData.lengthInBytes));
      imagePath1 = path;
    });
  }

  void _changeFocus(BuildContext context, FocusNode currentNode, FocusNode nextNode) {
    currentNode.unfocus();
    FocusScope.of(context).requestFocus(nextNode);
  }

  _changeDimension(BuildContext context,String dimension) {
    showAlertDialogDimension(context,dimension);
  }

  void showAlertDialog(BuildContext context, String title, String textButton) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context ) => CupertinoAlertDialog(
          title: new Text(title, style: Theme.of(context).textTheme.body1),
          actions: <Widget>[
            CupertinoDialogAction(
              child: new Text(textButton, style: TextStyle(color: Theme.of(context).primaryColor)),
              isDefaultAction: true,
              onPressed: (){
                Navigator.pop(context);
                setState(() {});
              },
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

  _saveArticle() async {
    sliding.dimensionImage1Path = imagePath1;
    int id = await helper.insertSliding(sliding);
    print('inserted row: $id');
    if(id!=null) {
      Navigator.push(context, CupertinoPageRoute(builder: (context)=>ArticleWebPreview(sliding)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        backgroundColor: Colors.white,
        actionsIconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text("Sliding dimensions",style: Theme.of(context).textTheme.body1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Theme.of(context).primaryColor,
        ),
        actions: <Widget>[
          InkWell(
            child: Image.asset(
              'assets/checkGreen.png',
              height: 25,
            ),
            onTap: (){
              _saveArticle();
            },
          )
        ],
      ),
      body: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[
                    RepaintBoundary(
                      key: imageKey1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 320,
                            height: 344,
                            margin: EdgeInsets.only(top: 16,bottom: 8),
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  child: Center(
                                    child: Image.asset('assets/slidingDimension.png'),
                                  ),
                                ),
                                Positioned(
                                  bottom: 104,
                                  right: 45,
                                  child: Container(
                                    width: 23,
                                    height: 35,
                                    child: InkWell(
                                      onTap: () => _changeDimension(context,'A'),
                                      child: FittedBox(
                                        child: Text(aCtr.text != "" ? aCtr.text : "A",style: Theme.of(context).textTheme.body1),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 80,
                                  bottom: 104,
                                  child: Container(
                                    width: 23,
                                    height: 35,
                                    child: InkWell(
                                      onTap: () => _changeDimension(context,'B'),
                                      child: FittedBox(
                                        child: Text(bCtr.text != "" ? bCtr.text : "B",style: Theme.of(context).textTheme.body1),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 129,
                                  bottom: 118,
                                  child: Container(
                                    width: 26,
                                    height: 25,
                                    child: InkWell(
                                        onTap: () => _changeDimension(context,'C'),
                                        child: FittedBox(
                                          child: Text(cCtr.text != "" ? cCtr.text : "C",style: Theme.of(context).textTheme.body1),
                                        )
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 150,
                                  right: 98,
                                  child: Container(
                                    width: 26,
                                    height: 25,
                                    child: InkWell(
                                        onTap: () => _changeDimension(context,'D'),
                                        child: FittedBox(
                                          child: Text(dCtr.text != "" ? dCtr.text : "D",style: Theme.of(context).textTheme.body1),
                                        )
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 1),
                    Padding(
                      padding: EdgeInsets.only(left: 16,top: 8),
                      child: Text('A',style: aCtr.text == "" ? Theme.of(context).textTheme.body1 : Theme.of(context).textTheme.subtitle, textAlign: TextAlign.left),
                    ),
                    new Padding(
                      padding: EdgeInsets.only(left: 16,right: 16),
                      child: new TextField(
                        focusNode: aNode,
                        textAlign: TextAlign.left,
                        expands: false,
                        style: Theme.of(context).textTheme.body1,
                        maxLines: 1,
                        controller: aCtr,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        onSubmitted: (next){
                          _changeFocus(context, aNode, bNode);
                          takeScreenShoot();
                        },
                        decoration: InputDecoration.collapsed(
                            border: InputBorder.none,
                            hintText: 'mm',
                            hintStyle: TextStyle(color: Colors.grey,fontSize: 14)
                        ),
                      ),
                    ),
                    Divider(height: 1),
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text('B',style: bCtr.text == "" ? Theme.of(context).textTheme.body1 : Theme.of(context).textTheme.subtitle, textAlign: TextAlign.left),
                    ),
                    new Padding(
                      padding: EdgeInsets.only(left: 16,right: 16,top: 0),
                      child: new TextField(
                        focusNode: bNode,
                        textAlign: TextAlign.left,
                        expands: false,
                        style: Theme.of(context).textTheme.body1,
                        maxLines: 1,
                        controller: bCtr,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        onSubmitted: (next){
                          _changeFocus(context, bNode, cNode);
                          takeScreenShoot();
                        },
                        decoration: InputDecoration.collapsed(
                            border: InputBorder.none,
                            hintText: 'mm',
                            hintStyle: TextStyle(color: Colors.grey,fontSize: 14)
                        ),
                      ),
                    ),
                    Divider(height: 1),
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text('C',style: cCtr.text == "" ? Theme.of(context).textTheme.body1 : Theme.of(context).textTheme.subtitle, textAlign: TextAlign.left),
                    ),
                    new Padding(
                      padding: EdgeInsets.only(left: 16,right: 16,top: 0),
                      child: new TextField(
                        focusNode: cNode,
                        textAlign: TextAlign.left,
                        expands: false,
                        style: Theme.of(context).textTheme.body1,
                        maxLines: 1,
                        controller: cCtr,
                        keyboardType: TextInputType.number,
                        onSubmitted: (_){
                          _changeFocus(context, cNode, dNode);
                          takeScreenShoot();
                        },
                        decoration: InputDecoration.collapsed(
                            border: InputBorder.none,
                            hintText: 'mm',
                            hintStyle: TextStyle(color: Colors.grey,fontSize: 14)
                        ),
                      ),
                    ),
                    Divider(height: 1),
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text('D',style: dCtr.text == "" ? Theme.of(context).textTheme.body1 : Theme.of(context).textTheme.subtitle, textAlign: TextAlign.left),
                    ),
                    new Padding(
                      padding: EdgeInsets.only(left: 16,right: 16,top: 0),
                      child: new TextField(
                        focusNode: dNode,
                        textAlign: TextAlign.left,
                        expands: false,
                        style: Theme.of(context).textTheme.body1,
                        maxLines: 1,
                        controller: dCtr,
                        keyboardType: TextInputType.number,
                        onSubmitted: (_){
                          setState(() {});
                          takeScreenShoot();
                        },
                        decoration: InputDecoration.collapsed(
                            border: InputBorder.none,
                            hintText: 'mm',
                            hintStyle: TextStyle(color: Colors.grey,fontSize: 14)
                        ),
                      ),
                    ),
                    Divider(height: 1),
                  ],
                ),
              )
            ],

          )
      ),
    );
  }
}