//import 'package:crashlytics/crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crashlytics/flutter_crashlytics.dart';
import 'HomeMaterial.dart';
import 'package:flutter/services.dart';
import 'dart:async';

void main() async {
  bool isInDebugMode = true;
  FlutterError.onError = (FlutterErrorDetails details) {
    if (isInDebugMode) {
      // In development mode simply print to console.
      FlutterError.dumpErrorToConsole(details);
    } else {
      // In production mode report to the application zone to report to
      // Crashlytics.
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };

  await FlutterCrashlytics().initialize();
  debugPrint('Crashlitics inicialized');
  runZoned<Future<Null>>(() async {
    runApp(MyApp());
  }, onError: (error, stackTrace) async {
    // Whenever an error occurs, call the `reportCrash` function. This will send
    // Dart errors to our dev console or Crashlytics depending on the environment.
    await FlutterCrashlytics().reportCrash(error, stackTrace, forceCrash: false);
  });
  runApp(MyApp());

}

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
          subhead: TextStyle(fontSize: 17.0, color: Color.fromRGBO(38, 38, 38, 1.0), fontWeight: FontWeight.w600),
          display1: TextStyle(fontSize: 22.0, color: Colors.lightGreen[500]),
        ),
      ),
      home: HomeM()
    );
  }
}
