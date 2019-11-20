
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservices/DoorLockData.dart';
import 'package:repairservices/GenericSelection.dart';
import 'package:repairservices/SlidingComponents.dart';
import 'package:repairservices/SlidingDimension.dart';
import 'package:repairservices/SlidingDirectionOpening.dart';
import 'package:repairservices/database_helpers.dart';
import 'package:repairservices/models/Sliding.dart';

class SlidingGeneralData extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SlidingGeneralDataState();
  }

}

class SlidingGeneralDataState extends State<SlidingGeneralData> {
  final yearCtr = TextEditingController();
  final manufacturerCtr = TextEditingController();

  final materialCtr = TextEditingController();
  final systemCtr = TextEditingController();
  final ventOverlapCtr = TextEditingController();
  final tiltSlideCtr = TextEditingController();
  String components = '';

  FocusNode yearNode,systemNode;
  bool filled = false;
  String directionOpeningImPath = '';

  @override
  initState(){
    super.initState();
    yearNode = FocusNode();
    systemNode = FocusNode();
  }

  @override
  void dispose() {
    yearNode.dispose();
    systemNode.dispose();
    super.dispose();
  }

  Widget _getMandatory(bool mandatory){
    if(mandatory) {
      return Padding(
          padding: EdgeInsets.only(left: 4),
          child: Text('*',style: TextStyle(color: Colors.red,fontSize: 17))
      );
    }
    else return Container();
  }

  _yearChange(){
    if (yearCtr.text.length == 1) {
      final s = yearCtr.text;
      if (s == "0" || s == "3" || s == "4" || s == "5" || s == "6" || s == "7" || s == "8" || s == "9") {
        setState(() {
          yearCtr.text = '';
        });
      }
    }
    else if(yearCtr.text.length > 4) {
      setState(() {
        yearCtr.text = yearCtr.text.substring(0, yearCtr.text.length -1);
      });
    }
    else {
      setState(() {});
    }
  }

  _goNextData() async {
    if (filled){
      final sliding = Sliding.withData('Sliding system fittings', DateTime.now(), yearCtr.text, materialCtr.text, directionOpeningImPath, materialCtr.text, systemCtr.text, ventOverlapCtr.text,
          tiltSlideCtr.text, components);
      Navigator.push(context, MaterialPageRoute(builder: (context) => SlidingDimension(sliding)));
    }
  }

  Widget _checkImage() {
    if (directionOpeningImPath != '' && materialCtr.text != "" && ventOverlapCtr.text != "" && tiltSlideCtr.text != '') {
      filled = true;
      return Image.asset(
        'assets/checkGreen.png',
        height: 25,
      );
    }
    else {
      filled = false;
      return Image.asset(
        'assets/checkGrey.png',
        height: 25,
      );
    }
  }
  Widget _constructGenericOption(String title, bool mandatory, List<String> options, TextEditingController controller, String hintText) {
    return InkWell(
      child: Row(
        children: <Widget>[
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(left: 16,top: 8,right: 4),
                      child: Row(
//                      mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(title,style: Theme.of(context).textTheme.body1, textAlign: TextAlign.left),
                          _getMandatory(mandatory)
                        ],
                      )
                  ),
                  new Padding(
                    padding: EdgeInsets.only(left: 16,right: 16,top: 0,bottom: 4),
                    child: new TextField(
                      focusNode: AlwaysDisabledFocusNode(),
                      enableInteractiveSelection: false,
                      enabled: false,
                      textAlign: TextAlign.left,
                      expands: false,
                      style: Theme.of(context).textTheme.body1,
                      maxLines: 1,
                      controller: controller,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration.collapsed(
                          border: InputBorder.none,
                          hintText: hintText,
                          hintStyle: TextStyle(color: Colors.grey,fontSize: 14)
                      ),
                    ),
                  ),
                ],
              )
          ),
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 20),
          )
        ],
      ),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => GenericSelection(title, options))).then((selectedOption){
          setState(() {
            controller.text = selectedOption;
          });
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        backgroundColor: Colors.white,
        actionsIconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text("General data",style: Theme.of(context).textTheme.body1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Theme.of(context).primaryColor,
        ),
        actions: <Widget>[
          GestureDetector(
              onTap: () {
                yearNode.unfocus();
                systemNode.unfocus();
                _goNextData();
              },
              child: _checkImage()
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(left: 16,top: 8),
              child: Row(
                children: <Widget>[
                  Text('Year of construction',style: Theme.of(context).textTheme.body1, textAlign: TextAlign.left),
                  _getMandatory(false)
                ],
              )
          ),
          Padding(
            padding: EdgeInsets.only(left: 16,right: 16,top: 0,bottom: 4),
            child: new TextField(
              focusNode: yearNode,
              textAlign: TextAlign.left,
              expands: false,
              style: Theme.of(context).textTheme.body1,
              maxLines: 1,
              controller: yearCtr,
              keyboardType: TextInputType.number,
              decoration: InputDecoration.collapsed(
                  border: InputBorder.none,
                  hintText: 'YYYY',
                  hintStyle: TextStyle(color: Colors.grey,fontSize: 14)
              ),
              onChanged: (value)=>_yearChange(),
            ),
          ),
          Divider(height: 1),
          _constructGenericOption('Fitting manufacturer', false, ['GU','HAUTAU'], manufacturerCtr, ''),
          Divider(height: 1),
          InkWell(
            child: Container(
                height: 50,
                margin: EdgeInsets.only(left: 16),
                child: Row(
                  children: <Widget>[
                    Text('Direction opening',style: Theme.of(context).textTheme.body1, textAlign: TextAlign.left),
                    Expanded(
                      child: _getMandatory(true),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 20),
                    )
                  ],
                )
            ),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => SlidingDirectionOpening(directionOpeningImPath))).then((imageStr){
                setState(() {
                  directionOpeningImPath = imageStr;
                });
              });
            },
          ),
          Divider(height: 1),
          _constructGenericOption('Material', true, ['Aluminum','PVC-U'], materialCtr, ''),
          Divider(height: 1),
          Padding(
              padding: EdgeInsets.only(left: 16,top: 8),
              child: Row(
                children: <Widget>[
                  Text('System',style: Theme.of(context).textTheme.body1, textAlign: TextAlign.left),
                  _getMandatory(false)
                ],
              )
          ),
          Padding(
            padding: EdgeInsets.only(left: 16,right: 16,top: 0,bottom: 4),
            child: new TextField(
              focusNode: systemNode,
              textAlign: TextAlign.left,
              expands: false,
              style: Theme.of(context).textTheme.body1,
              maxLines: 1,
              controller: systemCtr,
              decoration: InputDecoration.collapsed(
                  border: InputBorder.none,
                  hintText: 'system',
                  hintStyle: TextStyle(color: Colors.grey,fontSize: 14)
              ),
            ),
          ),
          Divider(height: 1),
          _constructGenericOption('Vent overlap (mm)', true, ['System royal 8.5mm','System royal 17mm','System royal S 10mm','System royal S 17mm'],
              ventOverlapCtr, ''),
          Divider(height: 1),
          _constructGenericOption('Tilt / slide fittings', true, ['With engagement mechanism','Without engagement mechanism'],
              tiltSlideCtr, ''),
          Divider(height: 1),
          InkWell(
            child: Container(
                height: 50,
                margin: EdgeInsets.only(left: 16),
                child: Row(
                  children: <Widget>[
                    Text('Fittings components to be replaced',style: Theme.of(context).textTheme.body1, textAlign: TextAlign.left),
                    Expanded(
                      child: _getMandatory(false),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 20),
                    )
                  ],
                )
            ),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => SlidingComponents(this.components))).then((components){
                setState(() {
                  this.components = components;
                });
              });
            },
          ),
          Divider(height: 1)
        ],
      ),
    );
  }
}