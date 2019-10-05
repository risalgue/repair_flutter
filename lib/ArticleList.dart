import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'Login.dart';
import 'package:repairservices/Utils/ISClient.dart';

class ArticleListV extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return ArticleListState();
  }
}

class ArticleListState extends State<ArticleListV> {

  final loggued = false;

  FocusNode numberNode;
  var numberController = TextEditingController();
  var isSearching = true;
  List<String> articlesList;

  @override
  void initState(){
    super.initState();
    numberNode = FocusNode();
  }
  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
   numberNode.dispose();
    super.dispose();
  }

  Future _searchArticle(String number) async {
    setState(() {
      isSearching = true;
    });
    debugPrint('Searching: $number');
    if(number != "") {
      articlesList =  await ISClientO.instance.getProductNumberAutocompletion(number);
      debugPrint('Artices count: ${articlesList.length}');
      setState(() {});
    }
  }

  _endSearch() {
    numberNode.unfocus();
    setState(() {
      isSearching = false;
    });
  }

  Widget _qrButton() {
    if (!isSearching) {
      return IconButton(
        icon: Image.asset('assets/qrCodeGrey.png'),
        onPressed: () {
          debugPrint('GoQRcode Scaner');
        },
      );
    }else {
      return Container(width: 0);
    }
  }
  Widget _cancelButton() {
    if (isSearching) {
      return CupertinoButton(
        child: Text(
          'Cancel',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 17,
            fontWeight: FontWeight.w500
          ),
        ),
        onPressed: () {
          _endSearch();
        },
        padding: EdgeInsets.only(top:4,bottom: 4,left: 8),
      );
    }else {
      return Container(width: 0);
    }
  }

  Widget searchBar(BuildContext context) {
    return new Container (
        height: 56.0,
        color: Colors.grey,
        child: new Padding(
          padding: EdgeInsets.symmetric(vertical: 8,horizontal: 8),
          child: new Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                        color: Colors.grey,
                        icon: Icon(Icons.search),
                        onPressed: () => _searchArticle(numberController.text),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                          child: new TextField(
                            focusNode: numberNode,
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.body1,
                            maxLines: 1,
                            controller: numberController,
                            textInputAction: TextInputAction.search,
                            keyboardType: TextInputType.number,
                            onSubmitted: (search){
                              _searchArticle(numberController.text);
                              _endSearch();
                            },
                            autofocus: true,
                            onChanged: (string) {
                              _searchArticle(string);
                            },
                            decoration: InputDecoration.collapsed(
                              border: InputBorder.none,
                              hintText: 'Search',
                              hintStyle: TextStyle(color: Colors.grey,fontSize: 17)
                            ),
                          ),
                        ),
                      ),
                      _qrButton()
                    ],
                  ),
                ),
              ),
              _cancelButton()
            ],
          )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        backgroundColor: Colors.white,
//        actionsIconTheme: IconThemeData(color: Colors.red),
        title: Text("Article List",style: Theme.of(context).textTheme.body1),
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
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          searchBar(context),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.all(16),
              itemCount: articlesList == null ? 0 : articlesList.length,
              itemBuilder: (BuildContext context, int index){
                return ListTile(
                  title: Text(articlesList[index],style: Theme.of(context).textTheme.body1),
                  trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey),
                  onTap: () {
                    debugPrint('Show article details');
                  },
                );
              },
              separatorBuilder: (context, index) => Divider(height: 1),
              shrinkWrap: true,
            ),
          ),
          Padding(
              padding: EdgeInsets.all(16),
              child: GestureDetector(
                child: Container(
                    height: loggued?0:30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Center(
                      child: Text(
                        "Log In",
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.white
                        ),
                      ),
                    )
                ),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginV()),
                  );
                },
              )

          )
        ],
      ),
    );
  }
}