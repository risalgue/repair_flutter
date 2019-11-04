import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:repairservices/ArticleBookMarkV.dart';
import 'package:repairservices/ArticleInCart.dart';
import 'package:repairservices/ProfileV.dart';
import 'package:repairservices/Utils/ISClient.dart';
import 'package:repairservices/database_helpers.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'Login.dart';
import 'ArticleIdentification.dart';
import 'CompanyProfile.dart';
import 'ArticleList.dart';


class HomeM extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState();
  }

}
class HomeState extends State<HomeM> {
  DatabaseHelper helper = DatabaseHelper.instance;
  bool loggued = false;
  int cantProductsInCart = 0;

  @override
  void initState() {
    super.initState();
    ISClientO.instance.isTokenAvailable().then((bool loggued) {
      this.loggued = loggued;
      setState(() {});
    });
    _readAllProductsInCart();
  }

  _readAllProductsInCart() async {
    final productList = await helper.queryAllProducts(true);
    debugPrint('Cant products in Cart: ${productList.length}');
    this.setState((){
      this.cantProductsInCart = productList.length;
    });
  }

  Widget _displayGridItem(String value, String imageUrl, Function action) {
    return new GestureDetector(
        onTap: action,
        child: new Container(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                imageUrl,
              ),
              new Container(
                child: new Text(
                  value,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,

                  ),
                ),
                margin: EdgeInsets.only(top: 26),
              )
            ],
          ),
        )
    );
  }

  Widget _profileButton(){
      if (loggued) {
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
          },
          child: Image.asset(
            'assets/user-icon.png',
            height: 25,
          ),
        );
      }
      else {
        return Container();
      }
  }

  Widget _loginBt() {
    if (!loggued) {
      return Padding(
          padding: EdgeInsets.all(16),
          child: GestureDetector(
            child: Container(
                height: 30,
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginV())).then((value){
                ISClientO.instance.isTokenAvailable().then((bool loggued) {
                  this.loggued = loggued;
                  setState(() {});
                });
              });
            },
          )

      );
    }
    else {
      return Container(height: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final topButtonPadding = screenHeight * 0.030;
    final bottomButtonPadding = screenHeight * 0.020;

    Widget searchBar(BuildContext context) {
      return new Container (
          height: 56.0,
          color: Colors.grey,
          child: Center(
            child: Container(
                width: screenWidth - 16.0,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14.0)
                ) ,
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ArticleListV())).then((value){
                      ISClientO.instance.isTokenAvailable().then((bool loggued){
                        this.loggued = loggued;
                        _readAllProductsInCart();
                        setState(() {});
                      });
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Icon(
                            Icons.search,
                            color: Colors.grey
                        ),
                      ),
                      new Text(
                        "SearchBar",
                        style: const TextStyle(
                          fontSize: 17,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: screenWidth - 190),
                        width: 40,
                        height: 40,
                        child: InkWell(
                          child: Image.asset(
                            'assets/qrCodeGrey.png',
                          ),
                          onTap: (){
                            debugPrint('QRCode Pressed');
                          },
                        ),
                      ),
                    ],
                  ),
                )
            ),
          )
      );
    }

    final divider = Container(
      color: Color.fromRGBO(0, 0, 0, 0.3),
      height: 1,
      margin: EdgeInsets.only(left: 0,right: 0),
    );

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(
            child: Container(
              child: Image.asset(
                'assets/schuco.png',
                fit: BoxFit.contain,
                height: 36,
              ),
            ),
          ),
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ArticleInCart())
                ).then((value){
                  ISClientO.instance.isTokenAvailable().then((bool loggued) {
                    this.loggued = loggued;
                    setState(() {});
                  });
                });
              },
                child: Container(
                  margin: EdgeInsets.only(right: this.loggued ? 0 : 8),
                  child: Center(
                    child: new Stack(
                        children: <Widget>[
                          Container(
                            height: 40,
                            child: Image.asset(
                              'assets/shopping-cart.png',
                              height: 25,
                            ),
                          ),

                          new Positioned(
                            right: 0,
                            child: new Container(
                                padding: EdgeInsets.all(1),
                                decoration: new BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(9),
                                ),
                                constraints: BoxConstraints(
                                  minWidth: 18,
                                  minHeight: 18,
                                ),
                                child: Center(
                                  child: new Text(
                                    '$cantProductsInCart',
                                    style: new TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                            ),
                          )
                        ]
                    ),
                  )
                )
            ),
            _profileButton()
          ],
        ),

        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(

            // Important: Remove any padding from the ListView.
//            padding: EdgeInsets.only(top: 30),
            children: <Widget>[
//          DrawerHeader(
//            child: Text('Drawer Header'),
//            decoration: BoxDecoration(
//              color: Colors.blue,
//            ),
//          ),
              divider,
              ListTile(
                title: Row(
                  children: <Widget>[

                    Image.asset(
                      'assets/homeGreen.png',
                      width: 25,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16),
                      child: Text(
                          'Home',
                          style: TextStyle(
                              color: Color.fromRGBO(38, 38, 38, 1.0),
                              fontSize: 17
                          )
                      ),
                    )
                  ],
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              divider,
              ListTile(
                title: Row(
                  children: <Widget>[
                    Image.asset(
                      'assets/articleIdentificationGreen1.png',
                      width: 25,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16),
                      child: Text(
                          'Article Identification Service',
                          style: TextStyle(
                              color: Color.fromRGBO(38, 38, 38, 1.0),
                              fontSize: 17
                          )
                      ),
                    )
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ArticleIdentificationV()),
                  );
                },
              ),
              divider,
              ListTile(
                title: Row(
                  children: <Widget>[

                    Image.asset(
                      'assets/documentListGreen1.png',
                      width: 25,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16),
                      child: Text(
                          'Article Bookmark List',
                          style: TextStyle(
                              color: Color.fromRGBO(38, 38, 38, 1.0),
                              fontSize: 17
                          )
                      ),
                    )
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ArticleBookMark()),
                  ).then((_){
                    _readAllProductsInCart();
                  });
                },
              ),
              divider,
              ListTile(
                title: Row(
                  children: <Widget>[

                    Image.asset(
                      'assets/documentGrey.png',
                      width: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                          'Project Documentation',
                          style: TextStyle(
                              color: Color.fromRGBO(38, 38, 38, 1.0),
                              fontSize: 17
                          )
                      ),
                    )
                  ],
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              divider,
              ListTile(
                title: Row(
                  children: <Widget>[

                    Image.asset(
                      'assets/docucenter1.png',
                      width: 25,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16),
                      child: Text(
                          'Docu-Center',
                          style: TextStyle(
                              color: Color.fromRGBO(38, 38, 38, 1.0),
                              fontSize: 17
                          )
                      ),
                    )
                  ],
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              divider,
              ListTile(
                title: Row(
                  children: <Widget>[

                    Image.asset(
                      'assets/buildingGreenHome.png',
                      width: 25,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16),
                      child: Text(
                          'Company profile',
                          style: TextStyle(
                              color: Color.fromRGBO(38, 38, 38, 1.0),
                              fontSize: 17
                          )
                      ),
                    )
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CompanyProfileV()),
                  );
                },
              ),
              divider,
              ListTile(
                title: Row(
                  children: <Widget>[

                    Image.asset(
                      'assets/informationGreen.png',
                      width: 25,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16),
                      child: Text(
                          'Service / FAQ',
                          style: TextStyle(
                              color: Color.fromRGBO(38, 38, 38, 1.0),
                              fontSize: 17
                          )
                      ),
                    )
                  ],
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              divider,
              ListTile(
                title: Row(
                  children: <Widget>[

                    Image.asset(
                      'assets/phoneGreen.png',
                      width: 25,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16),
                      child: Text(
                          'Contact',
                          style: TextStyle(
                              color: Color.fromRGBO(38, 38, 38, 1.0),
                              fontSize: 17
                          )
                      ),
                    )
                  ],
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              divider,
              ListTile(
                title: Row(
                  children: <Widget>[

                    Image.asset(
                      'assets/gearGreen1.png',
                      width: 25,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16),
                      child: Text(
                          'Setting',
                          style: TextStyle(
                              color: Color.fromRGBO(38, 38, 38, 1.0),
                              fontSize: 17
                          )
                      ),
                    )
                  ],
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              divider,
              ListTile(
                title: Row(
                  children: <Widget>[

                    Image.asset(
                      'assets/headSetGreen.png',
                      height: 25,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16),
                      child: Text(
                          'Feedback',
                          style: TextStyle(
                              color: Color.fromRGBO(38, 38, 38, 1.0),
                              fontSize: 17
                          )
                      ),
                    )
                  ],
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              divider,
              ListTile(
                title: Row(
                  children: <Widget>[

                    Image.asset(
                      'assets/logOnGreen.png',
                      width: 25,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16),
                      child: Text(
                          !loggued ? 'Log In' : "Log Off",
                          style: TextStyle(
                              color: Color.fromRGBO(38, 38, 38, 1.0),
                              fontSize: 17
                          )
                      ),
                    )
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  if (!loggued) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginV())).then((value){
                      ISClientO.instance.isTokenAvailable().then((bool loggued) {
                        this.loggued = loggued;
                        setState(() {});
                      });
                    });
                  }
                  else {
                      ISClientO.instance.clearToken().then((_){
                        setState(() {
                          this.loggued = false;
                        });
                      });
                  }
                },
              ),
              divider,
            ],
          ),
        ),

        body: Scaffold (
            body: new Container(
              child: Column (
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  searchBar(context),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                                child: Container(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: topButtonPadding, bottom:bottomButtonPadding),
                                    child: _displayGridItem("Article Identification\nService",'assets/article-identification.png', (){
                                      final widget = ArticleIdentificationV();
                                      Route route = CupertinoPageRoute(builder: (context) => widget, settings:RouteSettings(name: widget.toStringShort()));
                                      Navigator.push(context, route);
                                    }),
                                  ),
                                )
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(left: BorderSide(color: Color.fromARGB(100, 191, 191, 191),width: 1)),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(top: topButtonPadding, bottom:bottomButtonPadding),
                                  child: _displayGridItem("Article Bookmark\nList",'assets/document-list-green.png',(){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ArticleBookMark()),
                                    ).then((_) {
                                      _readAllProductsInCart();
                                    });
                                  }),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          color: Color.fromARGB(100, 191, 191, 191),
                          height: 1,
                          width: screenWidth,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                                child: Container(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: topButtonPadding, bottom:bottomButtonPadding),
                                    child: _displayGridItem("Project\nDocumentation",'assets/documentGrey.png',(){}),
                                  ),
                                )
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(left: BorderSide(color: Color.fromARGB(100, 191, 191, 191),width: 1)),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(top: topButtonPadding, bottom:bottomButtonPadding),
                                  child: _displayGridItem("Docu Center \n",'assets/docucenter.png',(){}),
                                ),
                              ),
                              flex: 1,
                            ),
                          ],
                        ),
                        Container(
                          color: Color.fromARGB(100, 191, 191, 191),
                          height: 1,
                          width: screenWidth,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                                child: Container(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: topButtonPadding, bottom:bottomButtonPadding),
                                    child: _displayGridItem("Company profile\n",'assets/buildingGreenHome.png',() {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => CompanyProfileV())
                                      );
                                    }),
                                  ),
                                )
                            ),
                            Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(left: BorderSide(color: Color.fromARGB(100, 191, 191, 191),width: 1)),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: topButtonPadding, bottom:bottomButtonPadding),
                                    child: _displayGridItem("Service / FAQ\n",'assets/informationGreen.png',(){}),
                                  ),
                                )
                            ),
                          ],
                        ),
                        Container(
                          color: Color.fromARGB(100, 191, 191, 191),
                          height: 1,
                          width: screenWidth,
                        )
                      ],
                    ),
                  ),
                  _loginBt()
                ],
              ),
            )
        )
    );
  }

}