import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:path_provider/path_provider.dart';
import 'package:repairservices/database_helpers.dart';
import 'package:repairservices/models/DoorHinge.dart';
import 'package:repairservices/models/DoorLock.dart';
import 'package:repairservices/models/Sliding.dart';
import 'package:repairservices/models/Windows.dart';

class ArticleWebPreview extends StatefulWidget {
  final Fitting article;
  ArticleWebPreview(this.article);
  @override
  State<StatefulWidget> createState() {
    return ArticleWebPreviewState(this.article);
  }
}

class ArticleWebPreviewState extends State<ArticleWebPreview> {
  Fitting article;
  String generatedPdfFilePath;
  ArticleWebPreviewState(this.article);
  bool loading = true;
  DatabaseHelper helper = DatabaseHelper.instance;
  @override
  initState(){
    super.initState();
    generateExampleDocument();
  }

  Widget _getTitle(){
    _loadHtmlFromAssets();
    return Text("Article Preview",style: Theme.of(context).textTheme.body1);
  }

  _loadHtmlFromAssets() async {
    String fileText = '';
    if(article is Windows){
      fileText = await rootBundle.loadString('assets/articleWindows.html');
      fileText = await (article as Windows).getHtmlString(fileText);
    }
    else if(article is DoorLock){
      fileText = await rootBundle.loadString('assets/articleDoorLock.html');
      fileText = await (article as DoorLock).getHtmlString(fileText);
    }
    else if(article is DoorHinge){
      fileText = await rootBundle.loadString('assets/articleDoorHinge.html');
      fileText = await (article as DoorHinge).getHtmlString(fileText);
    }
    else if(article is Sliding){
      fileText = await rootBundle.loadString('assets/articleSliding.html');
      fileText = await (article as Sliding).getHtmlString(fileText);
    }
    debugPrint(fileText);
    return fileText;
  }

  void _savePDFPath() async {
    if(article is Windows){
      await helper.updateWindows(article as Windows);
    }
    else if(article is DoorLock){
      await helper.updateDoorLock(article as DoorLock);
    }
    else if(article is DoorHinge){
      await helper.updateDoorHinge(article as DoorHinge);
    }
    else if(article is Sliding){
      await helper.updateSliding(article as Sliding);
    }
  }

  Future<void> generateExampleDocument() async {
    var htmlContent = await _loadHtmlFromAssets();

    Directory appDocDir = await getApplicationDocumentsDirectory();
    var targetPath = appDocDir.path;
    var targetFileName = "example-pdf";

    var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
        htmlContent, targetPath, targetFileName);
    generatedPdfFilePath = generatedPdfFile.path;
    article.pdfPath = generatedPdfFilePath;
    _savePDFPath();
    Navigator.push(context, MaterialPageRoute(builder: (context) => PDFViewerScaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          backgroundColor: Colors.white,
          actionsIconTheme: IconThemeData(color: Theme.of(context).primaryColor),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
              color: Theme.of(context).primaryColor,
            ),
          title: Text("Generated PDF Document")
        ),
        path: generatedPdfFilePath)));
    setState(() {
      loading = false;
    });
  }

  _sendPdfByEmail() async {
    debugPrint('Sending pdf by Email');
//    final Email email = Email(
//      body: 'Article Fitting',
//      subject: article.name,
//      recipients: ['ersatzteile@schueco.com'],
//      attachmentPath: article.pdfPath,
//      isHTML: false,
//    );
//
//    await FlutterEmailSender.send(email);
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: loading,
      opacity: 0.5,
      progressIndicator: CupertinoActivityIndicator(radius: 20),
      child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
            backgroundColor: Colors.white,
            actionsIconTheme: IconThemeData(color: Theme.of(context).primaryColor),
            title: _getTitle(),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.settings.name == "ArticleIdentificationV");
              },
              color: Theme.of(context).primaryColor,
            ),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 8),
                child: InkWell(
                  child: Icon(Icons.pageview),
                  onTap: ()=>generateExampleDocument(),
                ),
              )
            ],
          ),
          body: Container(
            color: Colors.white,
            child: Center(
              child: Padding(
                  padding: EdgeInsets.only(left: 16,right: 16),
                  child: GestureDetector(
                    child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Center(
                          child: Text(
                            "Send by Email",
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.white
                            ),
                          ),
                        )
                    ),
                    onTap: () => _sendPdfByEmail(),
                  )
              ),
            ),
          )
      ),
    );
  }

}