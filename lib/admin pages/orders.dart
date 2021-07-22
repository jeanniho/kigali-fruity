import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:k_fruity/database/database.dart';
import 'package:k_fruity/shared/drawer.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
User _user = _auth.currentUser;

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffd96b00),
        iconTheme: IconThemeData(color: Colors.black),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "O",
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Ogowey',
                fontSize: 30,
              ),
            ),
            Text(
              'rders',
              style: TextStyle(
                color: Colors.white,
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
                fontSize: 30,
              ),
            ),
            Text(
              "laced",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Ogowey',
                fontSize: 25,
              ),
            ),
          ],
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Color(0xffd96b00),
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
      drawer: _user!=null ? AdminDrawer():SignedOutDrawer(),
      body: SingleChildScrollView(
        child: Container(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/ordersbg.jpg"),
                fit: BoxFit.cover
              ),
            ),
            child: Database(uid: _auth.currentUser.uid).getOrders()
          ),
        ),
      ),
    );
  }
}