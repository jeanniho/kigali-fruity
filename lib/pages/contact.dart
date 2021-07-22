import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:k_fruity/database/database.dart';
import 'package:k_fruity/pages/signIn.dart';
import 'package:k_fruity/pages/signUp.dart';
import 'package:k_fruity/shared/drawer.dart';
import 'package:k_fruity/shared/sharedVariables.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();

  final _message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color(0xffd96600),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "C",
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Ogowey',
                fontSize: 30,
              ),
            ),
            Text(
              'ontact',
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
              "age",
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
            backgroundColor: Color(0xffd96600),
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
      drawer: _auth.currentUser!=null ? _auth.currentUser.displayName!=null && _auth.currentUser.displayName.toLowerCase()=="true" ? AdminDrawer(): SignedInDrawer():SignedOutDrawer(),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Positioned(
                    left: 30.0,
                    child: Container(
                      color: Colors.grey[900],
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width - 30,
                      padding: EdgeInsets.only(bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                              margin: EdgeInsets.only(right: 16),
                              width: MediaQuery.of(context).size.width - 200,
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Center(
                                child: Text(
                                  "Get in Touch",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.amber,
                                  ),
                                ),
                              ),
                            ),
                          Container(
                              padding: EdgeInsets.fromLTRB(10, 8, 10, 0),
                              margin: EdgeInsets.only(right: 30),
                              width: MediaQuery.of(context).size.width - 200,
                              child: Column(
                                children: [
                                  Text(
                                      "Get in touch with our CEO's and let them know what you think",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Divider(
                                        color: Colors.white,
                                        thickness: 2,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            margin: EdgeInsets.only(right: 30),
                            width: MediaQuery.of(context).size.width - 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    "Makuza Benison",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Tel: +27 (0) 677 2285 103",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Email: makuzabenison@gmail.com",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8),
                                  child: Divider(
                                    color: Colors.white,
                                    thickness: 2,
                                    indent: 22,
                                    endIndent: 22,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              margin: EdgeInsets.only(right: 30),
                              width: MediaQuery.of(context).size.width - 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text(
                                      "Musabyimana Donia",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Tel: +250 786 400 134",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "Email: doniamusa01@gmail.com",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 8),
                                    child: Divider(
                                      color: Colors.white,
                                      thickness: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          Container(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              margin: EdgeInsets.only(right: 30),
                              width: MediaQuery.of(context).size.width - 200,
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width -
                                              200,
                                      child: TextFormField(
                                        controller: _message,
                                        keyboardType: TextInputType.text,
                                        decoration:
                                            textInputDecoration.copyWith(
                                                labelText:
                                                    "Leave a message..."),
                                        validator: (val) {
                                          if (val.isEmpty) {
                                            return "Please type a message or complaint";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                    FlatButton(
                                      color: Colors.amber,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      onPressed: () async {
                                        if(_auth.currentUser != null){
                                          if(_formKey.currentState.validate()) {
                                            await Database(uid: _auth.currentUser.uid).addMessage(_message.text);
                                            _message.clear();
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  content: Text("Message sent :)"),
                                                );
                                              }
                                            );
                                          }
                                        } else{
                                          showDialog(
                                            context: context,
                                            builder: (_) => new AlertDialog(
                                              title: new Text(
                                                  "!PLEASE NOTE!"),
                                              content: new Text(
                                                "You must be signed in to leave a message.\nPlease login to your account.",
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
                                                          builder:
                                                              (context) =>
                                                                  SignIn()),
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
                                                          builder:
                                                              (context) =>
                                                                  SignUp()),
                                                    );
                                                  },
                                                ),
                                              ],
                                            )
                                          );
                                        }
                                      },
                                      child: Text(
                                        "Send",
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0.0,
                    top: 90.0,
                    child: Container(
                      color: Color(0xffd96600),
                      height: 300,
                      width: 170,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              "Contact us",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Expanded(
                              child: Row(children: <Widget>[
                                Icon(Icons.location_pin),
                                SizedBox(width: 8.0),
                                Expanded(
                                    child: Text(
                                  "Kigali, Remera",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )),
                              ]),
                            ),
                            Expanded(
                              child: Row(children: <Widget>[
                                Icon(Icons.email),
                                SizedBox(width: 8.0),
                                Expanded(
                                    child: Text(
                                  "kigalifruity@gmail.com",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )),
                              ]),
                            ),
                            Expanded(
                                                          child: Row(children: <Widget>[
                                Icon(Icons.phone),
                                SizedBox(width: 8.0),
                                Expanded(
                                    child: Text(
                                  "+250 786 400 134",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )),
                              ]),
                            ),
                            Expanded(
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Icon(FontAwesomeIcons.instagram),
                                    Icon(FontAwesomeIcons.facebook),
                                    Icon(FontAwesomeIcons.linkedin),
                                    Icon(FontAwesomeIcons.twitter),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _message.dispose();
    super.dispose();
  }
}
