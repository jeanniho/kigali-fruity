import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:k_fruity/database/database.dart';
import 'package:k_fruity/pages/purchaseHistory.dart';
import 'package:k_fruity/pages/signIn.dart';
import 'package:k_fruity/pages/signUp.dart';
import '../shared/sharedVariables.dart';
import '../shared/drawer.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class DetailPage extends StatefulWidget {
  final product;

  DetailPage({this.product});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final List<String> items = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10"
  ];
  String buttonText = "Sign Out";
  String _itemNumber = "1";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff004f00),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "P",
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Ogowey',
                fontSize: 25,
              ),
            ),
            Text(
              'roduct',
              style: TextStyle(
                color: Color(0xffeea607),
                fontFamily: 'Ogowey',
                fontSize: 25,
              ),
            ),
            SizedBox(width: 8,),
            Text(
              "P",
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Ogowey',
                fontSize: 25,
              ),
            ),
            Text(
              "review",
              style: TextStyle(
                color: Color(0xffeea607),
                fontFamily: 'Ogowey',
                fontSize: 25,
              ),
            ),
          ],
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Color(0xff004f00),
            radius: 30,
            child: ClipOval(
              child: Image(
                image: AssetImage("assets/icon.png"),
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
      drawer: _auth.currentUser != null ? SignedInDrawer() : SignedOutDrawer(),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/detailbg.jpg"),
              fit: BoxFit.cover
            ),
          ),
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 16),
                color: Colors.black54,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: 8,),
                      Text(
                        "Terms and Conditions",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Divider(
                        thickness: 2,
                        indent: 42,
                        endIndent: 42,
                        color: Color(0xff004f00),
                      ),
                      Text(
                        "60% of a product's original price is payble before you can recieve the product. The remaining 40% is payble after you've received the product.",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xffd96b00),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: ClipRRect(
                      // margin: EdgeInsets.only(bottom: 16.0),
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        widget.product.data()["url"],
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Center(
                    child: Text(
                      widget.product.data()["title"],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Center(
                    child: Text(
                      widget.product.data()["description"],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Center(
                    child: Text(
                      "${widget.product.data()["price"]} RWF",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Center(
                    child: Container(
                      //margin: EdgeInsets.all(8),
                      width: 90,
                      constraints:
                          BoxConstraints(minWidth: 90.0, minHeight: 15.0),
                      child: DropdownButtonFormField(
                        value: _itemNumber,
                        decoration: textInputDecoration,
                        items: items.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(
                              "$item",
                            ),
                            // onTap: () {
                            //   print(_category);
                            //   //add function here to collect posts from a selected category
                            // },
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            _itemNumber = val;
                            //add function here to collect posts from a selected category
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              FlatButton(
                color: Color(0xff004f00),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                onPressed: () async {
                  if(_auth.currentUser != null){
                    await Database(uid: _auth.currentUser.uid).purchaseHistory(widget.product.data()["url"], _itemNumber);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PurchaseHistory(),
                      ),
                    );
                  } else{
                      showDialog(
                        context: context,
                        builder: (_) => new AlertDialog(
                          title: new Text(
                              "!PLEASE NOTE!"),
                          content: new Text(
                            "You must be signed in to purchase any product.\nPlease login to your account.",
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Login'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:(context) =>SignIn()
                                  ),
                                );
                              },
                            ),
                            FlatButton(
                              child:
                                  Text('Sign up'),
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUp()
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                  }
                },
                child: Text(
                  "Buy $_itemNumber box/es of ${widget.product.data()["title"]}",
                  style: TextStyle(
                    color: Color(0xffeea607),
                    fontSize: 18.0,
                  ),
                ),
              ),
              Text(
                "An upfront of ${double.parse(widget.product.data()["price"]) * int.parse(_itemNumber) * (60 / 100.0)} RWF is payable",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
