import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:k_fruity/database/database.dart';
import 'package:k_fruity/shared/drawer.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
User _user = _auth.currentUser;

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
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
              "M",
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Ogowey',
                fontSize: 30,
              ),
            ),
            Text(
              'essages',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Ogowey',
                fontSize: 25,
              ),
            ),
            SizedBox(width: 8,),
            Text(
              "R",
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Ogowey',
                fontSize: 30,
              ),
            ),
            Text(
              "eceived",
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
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/messagebg.jpg"),
              fit: BoxFit.cover
            ),
          ),
          child: Database(uid: _auth.currentUser.uid).getMessages()
        ),
      ),
    );
  }
}
