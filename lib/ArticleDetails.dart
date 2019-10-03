import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ArticleDetailsV extends StatefulWidget {
  final String number;

  ArticleDetailsV(this.number);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ArticleDetailsState(this.number);
  }
}

class ArticleDetailsState extends State<ArticleDetailsV> {
  final String number;

  ArticleDetailsState(this.number);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          backgroundColor: Colors.white,
//        actionsIconTheme: IconThemeData(color: Colors.red),
          title: Text("Article Details",style: Theme.of(context).textTheme.body1),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Theme.of(context).primaryColor,
          ),
          actions: <Widget>[
            IconButton(
              icon:  Image.asset('assets/bookmarkWhite.png',color: Theme.of(context).primaryColor),
              onPressed: () {
                debugPrint('goBookMark');
              },
            ),
          ]
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,

      ),
    );
  }

}