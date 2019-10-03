import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LoginV extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget loginBt = Padding(
        padding: EdgeInsets.only(top: 32,left: 16,right: 16,bottom: 32),
        child: GestureDetector(
          child: Container(
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Color.fromRGBO(68, 68, 68, 1.0),
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
            //Login Function
          },
        )

    );

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        backgroundColor: Colors.white,
        actionsIconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text("Log In",style: Theme.of(context).textTheme.body1),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          color: Theme.of(context).primaryColor,
        ),
      ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromRGBO(138, 139, 141, 1.0),width: 1.0)
              ),
              margin: EdgeInsets.only(top: 32,left: 16,right: 16),
              child: Padding(
                padding: EdgeInsets.only(left: 16,right: 16),
                child: TextField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      hintText: "E-mail / username",
                      border: InputBorder.none
                  ),
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.normal
                  ),
                ),)
            ),
            Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Color.fromRGBO(138, 139, 141, 1.0),width: 1.0)
                ),
                margin: EdgeInsets.only(top: 32,left: 16,right: 16),
                child: Padding(
                  padding: EdgeInsets.only(left: 16,right: 16),
                  child: TextField(
                    textInputAction: TextInputAction.go,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Password",
                        border: InputBorder.none
                    ),
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.normal
                    ),
                  ),
                )
            ),
            loginBt,
            Row(
              children: <Widget>[
                CupertinoButton(
                  child: Text(
                    "Forgotten your password?",
                    style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: (){
                    //Redirect to recover password
                  },
                ),
                Container(
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border(right: BorderSide(color: Color.fromRGBO(191, 191, 191, 1.0),width: 1))
                  ),
                ),
                CupertinoButton(
                  child: Text(
                    "First time registration",
                    style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: (){
                    //Redirect to register
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ),
      );
  }
}
//
//onPressed: () {
//Navigator.pop(context);
//},