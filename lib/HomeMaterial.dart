import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'Login.dart';
import 'ArticleIdentification.dart';
import 'CompanyProfile.dart';
import 'ArticleList.dart';

class HomeM extends StatelessWidget {
  const HomeM();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                debugPrint('Car button taped');
              },
              child: Image.asset(
                'assets/shopping-cart.png',
                height: 25,
              ),

            ),
            GestureDetector(
              onTap: () {
                debugPrint('Profile button taped');
              },
              child: Image.asset(
                'assets/user-icon.png',
                height: 25,
              ),
            ),
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
                        'Log In',
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
            ],
          ),
        ),

        body: new HomeBody()
    );
  }

}
class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build


//    void showAlertDialog(BuildContext context) {
//      showCupertinoDialog(
//          context: context,
//          builder: (BuildContext context ) => CupertinoAlertDialog(
//            title: const Text("New Alert for you"),
//            actions: <Widget>[
//              CupertinoDialogAction(
//                child: const Text("Nope"),
//                isDestructiveAction: true,
//                onPressed: () {
//                  Navigator.pop(context);
//                },
//              ),
//              CupertinoDialogAction(
//                child: const Text("Absolutly"),
//                isDefaultAction: true,
//                onPressed: () {
//                  Navigator.pop(context);
//                },
//              )
//            ],
//          )
//      );
//    }

//    final buttonStyle = BoxDecoration(
//      border: Border.all(
//        color: Colors.grey,
//        width: 1.0,
//      )
//    );
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final topButtonPadding = screenHeight * 0.031;
    final bottomButtonPadding = screenHeight * 0.021;
//    final buttonBorderColor = Border.all(color: Color.fromARGB(100, 191, 191, 191),width: 1);

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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ArticleListV()));
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

//    Widget gridSection = new Expanded(
//      flex: 1,
//      child: new GridView.count(
//        crossAxisCount: 2,
//        childAspectRatio: 1.0,
//        mainAxisSpacing: 0.0,
//        crossAxisSpacing: 0.0,
//        children: <Widget>[
//          _displayGridItem("Article Identification\nService",'assets/article-identification.png'),
//          _displayGridItem("Article Bookmark\nList",'assets/article-identification.png'),
//          _displayGridItem("Project\nDocumentation",'assets/article-identification.png'),
//          _displayGridItem("Docu Center",'assets/article-identification.png'),
//          _displayGridItem("Company profile",'assets/article-identification.png'),
//          _displayGridItem("Service / FAQ",'assets/article-identification.png'),
//        ]
//      )
//    );

    Widget loginBt = Padding(
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginV()),
            );
          },
        )

    );

    return Scaffold (
        body: new Container(
//        height: MediaQuery.of(context).size.height,
//        color: Colors.redAccent,
          child: Column (
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              searchBar(context),
              Row(
                children: <Widget>[
                  Expanded(
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.only(top: topButtonPadding, bottom:bottomButtonPadding),
                          child: _displayGridItem("Article Identification\nService",'assets/article-identification.png', (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ArticleIdentificationV()),
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
                        child: _displayGridItem("Article Bookmark\nList",'assets/document-list-green.png',(){}),
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
              ),
              loginBt
            ],
          ),
        )
    );
  }

}