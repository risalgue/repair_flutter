import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class IdentificationTypeV extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
//        height: MediaQuery.of(context).size.width / 2 - 40,
//        color: Colors.grey,
        child: new Column(
//          crossAxisAlignment: CrossAxisAlignment.,
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
                          debugPrint('camera taped');
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
                          debugPrint('record product data taped');
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
            )
          ],
        )
      ),
    );
  }

}