import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LockDimensions extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return LockDimensionsState();
  }
}
class LockDimensionsState extends State<LockDimensions> {
  bool filled = false;
  PageController pageController;
  FocusNode aNode,bNode,cNode,dNode,eNode,fNode;
  final aCtr = TextEditingController();
  final bCtr = TextEditingController();
  final cCtr = TextEditingController();
  final dCtr = TextEditingController();
  final eCtr = TextEditingController();
  final fCtr = TextEditingController();
  final dimensionCtr = TextEditingController();

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
    aNode = FocusNode();
    bNode = FocusNode();
    cNode = FocusNode();
    dNode = FocusNode();
    eNode = FocusNode();
    fNode = FocusNode();
  }

  @override
  void dispose() {
    aNode.dispose();
    bNode.dispose();
    cNode.dispose();
    dNode.dispose();
    eNode.dispose();
    fNode.dispose();
    super.dispose();
  }

  void _changeFocus(BuildContext context, FocusNode currentNode, FocusNode nextNode) {
    currentNode.unfocus();
    FocusScope.of(context).requestFocus(nextNode);
  }

  _changeDimension(BuildContext context,String dimension) {
    showAlertDialogDimension(context,dimension);
  }

  void showAlertDialog(BuildContext context, String title, String textButton) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context ) => CupertinoAlertDialog(
          title: new Text(title, style: Theme.of(context).textTheme.body1,),
          actions: <Widget>[
            CupertinoDialogAction(
              child: new Text(textButton, style: TextStyle(color: Theme.of(context).primaryColor)),
              isDefaultAction: true,
              onPressed: ()=>Navigator.pop(context),
            ),
            CupertinoDialogAction(
              child: new Text("Cancel"),
              isDestructiveAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        )
    );
  }

  void showAlertDialogDimension(BuildContext context, String dimension) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context ) => CupertinoAlertDialog(
          title: new Text('Dimension $dimension'),
          content: new Container(
              margin: EdgeInsets.only(top: 16),
              child: new CupertinoTextField(
                textAlign: TextAlign.left,
                expands: false,
                style: Theme.of(context).textTheme.body1,
                keyboardType: TextInputType.number,
                maxLines: 1,
                controller: dimensionCtr,
                placeholder: 'mm',
              )
          ),
          actions: <Widget>[
            CupertinoDialogAction(
                child: new Text('OK', style: TextStyle(color: Theme.of(context).primaryColor)),
                isDefaultAction: true,
                onPressed: () {
                  if (dimensionCtr.text != "" && int.parse(dimensionCtr.text) != 0){
                    switch(dimension){
                      case 'A':
                        aCtr.text = int.parse(dimensionCtr.text).toString();
                        break;
                      case 'B':
                        bCtr.text = int.parse(dimensionCtr.text).toString();
                        break;
                      case 'C':
                        cCtr.text = int.parse(dimensionCtr.text).toString();
                        break;
                      case 'D':
                        dCtr.text = int.parse(dimensionCtr.text).toString();
                        break;
                      case 'E':
                        eCtr.text = int.parse(dimensionCtr.text).toString();
                        break;
                      default:
                        fCtr.text = int.parse(dimensionCtr.text).toString();
                    }
                    Navigator.pop(context);
                    setState(() {});
                  }
                  else {
                    Navigator.pop(context);
                    showAlertDialog(context, "0 is not valid value for this dimension", "OK");
                  }
                }
            ),
            CupertinoDialogAction(
              child: new Text("Cancel"),
              isDestructiveAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        )
    );
  }

  Widget _checkImage(){
    if (aCtr.text != "" && bCtr.text != "" && cCtr.text != "" && dCtr.text != "" && eCtr.text != "" && fCtr.text != "") {
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
  @override
  Widget build(BuildContext context) {

    List<Widget> pages = [
      //First Page
      Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 320,
                        height: 344,
                        margin: EdgeInsets.only(top: 16,bottom: 8),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              child: Center(
                                child: Image.asset('assets/lockDimensionPage1.png'),
                              ),
                            ),
                            Positioned(
                              right: 87,
                              top: 47,
                              child: Container(
                                width: 22,
                                height: 41,
                                child: InkWell(
                                  onTap: () => _changeDimension(context,'A'),
                                  child: FittedBox(
                                    child: Text(aCtr.text,style: Theme.of(context).textTheme.body1),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 55,
                              top: 94,
                              child: Container(
                                width: 24,
                                height: 61,
                                child: InkWell(
                                  onTap: () => _changeDimension(context,'B'),
                                  child: FittedBox(
                                    child: Text(bCtr.text,style: Theme.of(context).textTheme.body1),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 86,
                              top: 149,
                              child: Container(
                                width: 22,
                                height: 41,
                                child: InkWell(
                                  onTap: () => _changeDimension(context,'C'),
                                    child: FittedBox(
                                      child: Text(cCtr.text,style: Theme.of(context).textTheme.body1),
                                    )
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 1),
                  Padding(
                    padding: EdgeInsets.only(left: 16,top: 8),
                    child: Text('A',style: aCtr.text == "" ? Theme.of(context).textTheme.body1 : Theme.of(context).textTheme.subtitle, textAlign: TextAlign.left),
                  ),
                  new Padding(
                    padding: EdgeInsets.only(left: 16,right: 16),
                    child: new TextField(
                      focusNode: aNode,
                      textAlign: TextAlign.left,
                      expands: false,
                      style: Theme.of(context).textTheme.body1,
                      maxLines: 1,
                      controller: aCtr,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      onSubmitted: (next){
                        _changeFocus(context, aNode, bNode);
                      },
                      decoration: InputDecoration.collapsed(
                          border: InputBorder.none,
                          hintText: 'mm',
                          hintStyle: TextStyle(color: Colors.grey,fontSize: 14)
                      ),
                    ),
                  ),
                  Divider(height: 1),
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text('B',style: bCtr.text == "" ? Theme.of(context).textTheme.body1 : Theme.of(context).textTheme.subtitle, textAlign: TextAlign.left),
                  ),
                  new Padding(
                    padding: EdgeInsets.only(left: 16,right: 16,top: 0),
                    child: new TextField(
                      focusNode: bNode,
                      textAlign: TextAlign.left,
                      expands: false,
                      style: Theme.of(context).textTheme.body1,
                      maxLines: 1,
                      controller: bCtr,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      onSubmitted: (next){
                        _changeFocus(context, bNode, cNode);
                      },
                      decoration: InputDecoration.collapsed(
                          border: InputBorder.none,
                          hintText: 'mm',
                          hintStyle: TextStyle(color: Colors.grey,fontSize: 14)
                      ),
                    ),
                  ),
                  Divider(height: 1),
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text('C',style: cCtr.text == "" ? Theme.of(context).textTheme.body1 : Theme.of(context).textTheme.subtitle, textAlign: TextAlign.left),
                  ),
                  new Padding(
                    padding: EdgeInsets.only(left: 16,right: 16,top: 0),
                    child: new TextField(
                      focusNode: cNode,
                      textAlign: TextAlign.left,
                      expands: false,
                      style: Theme.of(context).textTheme.body1,
                      maxLines: 1,
                      controller: cCtr,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration.collapsed(
                          border: InputBorder.none,
                          hintText: 'mm',
                          hintStyle: TextStyle(color: Colors.grey,fontSize: 14)
                      ),
                    ),
                  ),
                  Divider(height: 1),
                ],
              ),
            )
          ],

        )
      ),

      //Second Page
      Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 320,
                          height: 344,
                          margin: EdgeInsets.only(top: 16,bottom: 8),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                child: Center(
                                  child: Image.asset('assets/lockDimensionPage2.png'),
                                ),
                              ),
                              Positioned(
                                left: 82,
                                top: 93,
                                child: Container(
                                  width: 22,
                                  height: 60,
                                  child: InkWell(
                                    onTap: () => _changeDimension(context,'D'),
                                    child: FittedBox(
                                      child: Text(dCtr.text,style: Theme.of(context).textTheme.body1),
                                    )
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 56,
                                bottom: 2,
                                child: Container(
                                  width: 54,
                                  height: 31,
                                  child: InkWell(
                                    onTap: () => _changeDimension(context,'E'),
                                    child: FittedBox(
                                      child: Text(eCtr.text,style: Theme.of(context).textTheme.body1),
                                    )
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    Divider(height: 1),
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text('D',style: dCtr.text == "" ? Theme.of(context).textTheme.body1 : Theme.of(context).textTheme.subtitle, textAlign: TextAlign.left),
                    ),
                    new Padding(
                      padding: EdgeInsets.only(left: 16,right: 16),
                      child: new TextField(
                        focusNode: dNode,
                        textAlign: TextAlign.left,
                        expands: false,
                        style: Theme.of(context).textTheme.body1,
                        maxLines: 1,
                        controller: dCtr,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        onSubmitted: (next){
                          _changeFocus(context, dNode, eNode);
                        },
                        decoration: InputDecoration.collapsed(
                            border: InputBorder.none,
                            hintText: 'mm',
                            hintStyle: TextStyle(color: Colors.grey,fontSize: 14)
                        ),
                      ),
                    ),
                    Divider(height: 1),
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text('E',style: eCtr.text == "" ? Theme.of(context).textTheme.body1 : Theme.of(context).textTheme.subtitle, textAlign: TextAlign.left),
                    ),
                    new Padding(
                      padding: EdgeInsets.only(left: 16,right: 16,top: 0),
                      child: new TextField(
                        focusNode: eNode,
                        textAlign: TextAlign.left,
                        expands: false,
                        style: Theme.of(context).textTheme.body1,
                        maxLines: 1,
                        controller: eCtr,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration.collapsed(
                            border: InputBorder.none,
                            hintText: 'mm',
                            hintStyle: TextStyle(color: Colors.grey,fontSize: 14)
                        ),
                      ),
                    ),
                    Divider(height: 1),
                  ],
                ),
              )
            ],

          )
      ),

      //Thirst Page
      Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 320,
                          height: 344,
                          margin: EdgeInsets.only(top: 16,bottom: 8),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                child: Center(
                                  child: Image.asset('assets/lockDimensionPage3.png'),
                                ),
                              ),
                              Positioned(
                                left: 36,
                                bottom: 92,
                                child: Container(
                                  width: 80,
                                  height: 41,
                                  child: InkWell(
                                    onTap: () => _changeDimension(context,'F'),
                                    child: FittedBox(
                                      child: Text(fCtr.text,style: Theme.of(context).textTheme.body1),
                                    )
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(height: 1),
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text('F',style: fCtr.text == "" ? Theme.of(context).textTheme.body1 : Theme.of(context).textTheme.subtitle, textAlign: TextAlign.left),
                    ),
                    new Padding(
                      padding: EdgeInsets.only(left: 16,right: 16,top: 0),
                      child: new TextField(
                        focusNode: fNode,
                        textAlign: TextAlign.left,
                        expands: false,
                        style: Theme.of(context).textTheme.body1,
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        controller: fCtr,
                        decoration: InputDecoration.collapsed(
                            border: InputBorder.none,
                            hintText: 'mm',
                            hintStyle: TextStyle(color: Colors.grey,fontSize: 14)
                        ),
                      ),
                    ),
                    Divider(height: 1),
                  ],
                ),
              )
            ],

          )
      )
    ];


    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        backgroundColor: Colors.white,
        actionsIconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text("Lock dimensions",style: Theme.of(context).textTheme.body1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Theme.of(context).primaryColor,
        ),
        actions: <Widget>[
          InkWell(
            child: _checkImage(),
            onTap: (){
              debugPrint('next');
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: pages.length,
              onPageChanged: (index){
                setState(() {});
              },
              itemBuilder: (context, index){
                return pages[index];
              },
            ),
          ),
          Container(
            color: Colors.white,
            height: 40,
            child: Center(
              child: Indicator(
                controller: pageController,
                itemCount: pages.length,
                dotSizeBorder: 1,
                normalColor: Colors.white,
                selectedColor: Theme.of(context).primaryColor,
              )
            ),
          )
        ],
      )
    );

  }
}
class Indicator extends StatelessWidget {
  Indicator({
    this.controller,
    this.itemCount: 0,
    this.normalColor,
    this.selectedColor,
    this.dotSizeBorder
  }) : assert(controller != null);

  /// PageView Controller
  final PageController controller;

  /// Number of indicators
  final int itemCount;

  /// Ordinary colours
  final Color normalColor;

  /// Selected color
  final Color selectedColor;

  /// Dot border Size
  final double dotSizeBorder;

  /// Size of points
  final double size = 8.0;

  /// Spacing of points
  final double spacing = 4.0;

  /// Point Widget
  Widget _buildIndicator(
      int index, int pageCount, double dotSize, double spacing) {
    // Is the current page selected?
    bool isCurrentPageSelected = index ==
        (controller.page != null ? controller.page.round() % pageCount : 0);

    return new Container(
      height: size,
      width: size + (2 * spacing),
      child: new Center(
        child: Container(
          width: dotSize,
          height: dotSize,
          decoration: BoxDecoration(
            border: Border.all(color: selectedColor,width: dotSizeBorder),
            color: isCurrentPageSelected ? selectedColor : normalColor,
            borderRadius: BorderRadius.circular(dotSize/2)
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, (int index) {
        return _buildIndicator(index, itemCount, size, spacing);
      }),
    );
  }
}