import 'package:flutter/material.dart';
//import 'Home.dart';
import 'HomeMaterial.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // Define the default brightness and colors.
//        brightness: Brightness.dark,
        primaryColor: Colors.lightGreen[500],
        accentColor: Colors.cyan[600],
        dividerColor: Color.fromRGBO(191, 191, 191, 1.0),
        // Define the default font family.
        fontFamily: 'Montserrat',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          body1: TextStyle(fontSize: 17.0, color: Color.fromRGBO(38, 38, 38, 1.0)),
          body2: TextStyle(fontSize: 12.0, color: Color.fromRGBO(153, 153, 153, 1.0)),
          display1: TextStyle(fontSize: 22.0, color: Colors.lightGreen[500]),
        ),
      ),
      home: HomeM()
    );
  }
}
