import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditPicture extends StatefulWidget {
  final String imagePath;
  final bool sendByEmail;

  EditPicture(this.imagePath,this.sendByEmail);

  @override
  State<StatefulWidget> createState() {
    return EditPictureState(this.imagePath,this.sendByEmail);
  }
}

class EditPictureState extends State<EditPicture>{
  final String imagePath;
  final bool sendByEmail;

  EditPictureState(this.imagePath,this.sendByEmail);


  TextEditingController titleCtr = TextEditingController();

  @override
  void initState() {
    titleCtr.text = 'Picture 1';
    super.initState();
  }

  Widget _dimensionBar(){
    return Container(
      color: Color.fromRGBO(139, 138, 141, 1),
      height: 50,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new InkWell(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.only(bottom: 8),
                  child: new Image.asset('assets/arrowWhite.png'),
                ),
                new Text(
                  '1 Head Arrow',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                      letterSpacing: 0.5
                  ),
                )
              ],
            ),
            onTap: () {

            },
          ),
          new InkWell(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.only(bottom: 8),
                  child: new Image.asset('assets/doubleArrowWhite.png'),
                ),
                new Text(
                  '2 Head Arrow',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                      letterSpacing: 0.5
                  ),
                )
              ],
            ),
            onTap: () {

            },
          ),
          new InkWell(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.only(bottom: 12),
                  child: new Image.asset('assets/protractorGreyBlock.png'),
                ),
                new Text(
                  'Angle',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                      letterSpacing: 0.5
                  ),
                )
              ],
            ),
            onTap: () {

            },
          ),

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        backgroundColor: Colors.white,
        actionsIconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text("Edit Picture",style: Theme.of(context).textTheme.body1),
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
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text(titleCtr.text,style: TextStyle(fontSize: 17,color: Theme.of(context).primaryColor))
              )
            ],
          ),
          Expanded(
            child: Container(
              color: Colors.black,
              child: Image.file(File(imagePath)),
            )
          ),
          Container(
            height: 60,
            color: Colors.black,
            child: Container(
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
                          child: new Image.asset('assets/lettersWhite.png'),
                        ),
                        new Text(
                          'Photo Title',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              letterSpacing: 0.5
                          ),
                        )
                      ],
                    ),
                    onTap: () {
                      showCupertinoDialog(
                          context: context,
                          builder: (BuildContext context ) => CupertinoAlertDialog(
                            title: new Text('Change the article name', style: Theme.of(context).textTheme.subhead),
                            content: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8,horizontal: 8),
                              child: new CupertinoTextField(
                                textAlign: TextAlign.left,
                                expands: false,
                                style: Theme.of(context).textTheme.body1,
                                keyboardType: TextInputType.number,
                                maxLines: 1,
                                controller: titleCtr,
                                placeholder: 'Article Image',
                              )
                            ),
                            actions: <Widget>[
                              CupertinoDialogAction(
                                child: new Text('Cancel', style: TextStyle(color: Theme.of(context).primaryColor)),
                                isDefaultAction: true,
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                              ),
                              CupertinoDialogAction(
                                child: new Text('OK', style: TextStyle(color: Theme.of(context).primaryColor)),
                                isDefaultAction: true,
                                onPressed: (){
                                  Navigator.pop(context);
                                  setState(() {});
                                },
                              ),
                            ],
                          )
                      );
                    },
                  ),
                  new InkWell(
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Container(
                          margin: EdgeInsets.only(bottom: 8),
                          child: new Image.asset('assets/drawingWhite.png'),
                        ),
                        new Text(
                          'Dimensions',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              letterSpacing: 0.5
                          ),
                        )
                      ],
                    ),
                    onTap: () {

                    },
                  ),
                  new InkWell(
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Container(
                          margin: EdgeInsets.only(bottom: 12),
                          child: new Image.asset('assets/notebookWhite.png'),
                        ),
                        new Text(
                          'Memo',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              letterSpacing: 0.5
                          ),
                        )
                      ],
                    ),
                    onTap: () {

                    },
                  ),
                  new InkWell(
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Container(
                          margin: EdgeInsets.only(bottom: 12),
                          child: new Image.asset('assets/folderWhite.png'),
                        ),
                        new Text(
                          'Folders',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              letterSpacing: 0.5
                          ),
                        )
                      ],
                    ),
                    onTap: () {

                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
