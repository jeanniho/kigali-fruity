import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:k_fruity/admin%20pages/adminHome.dart';
import 'package:k_fruity/database/authentication.dart';
import '../shared/drawer.dart';
import '../shared/sharedVariables.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class AdminSignIn extends StatefulWidget {
  final admin;

  const AdminSignIn({Key key, this.admin}) : super(key: key);

  @override
  _AdminSignInState createState() => _AdminSignInState();
}

class _AdminSignInState extends State<AdminSignIn> {
  String errorMessage = "";
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(_auth.currentUser);
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color(0xff004f00),
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "K",
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Ogowey',
                fontSize: 30,
              ),
            ),
            Text(
              'igali',
              style: TextStyle(
                color: Color(0xffd96b00),
                fontFamily: 'Ogowey',
                fontSize: 25,
              ),
            ),
            SizedBox(width: 8,),
            Text(
              "F",
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Ogowey',
                fontSize: 30,
              ),
            ),
            Text(
              "ruity",
              style: TextStyle(
                color: Color(0xffd96b00),
                fontFamily: 'Ogowey',
                fontSize: 25,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: <Widget>[
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
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                child: Container(
                  color: Color(0xff18cfc4),
                  height: MediaQuery.of(context).size.height - 200,
                  width: MediaQuery.of(context).size.width - 40,
                  padding: EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: ClipOval(
                            child: Image(
                              image: AssetImage("assets/icon.png"),
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 14),
                          child: Text(
                            "Admin Account",
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _email,
                            keyboardType: TextInputType.emailAddress,
                            decoration: textInputDecoration.copyWith(
                                labelText: "Email address"),
                            validator: (val) {
                              if (val.isEmpty || !val.contains("@")) {
                                return "Please provide a valid email address";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _password,
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            decoration: textInputDecoration.copyWith(
                                labelText: "Password"),
                            validator: (val) {
                              if (val.isEmpty) {
                                return "Please provide a valid email address";
                              }
                              if (val.length < 6) {
                                return "Password must be at least 6 characters long";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        FlatButton(
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.black)),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              dynamic user = await Authentication()
                                  .signInWithEmailAndPassword(
                                _email.text,
                                _password.text,
                                admin: true,
                              );
                              if (user == null) {
                                setState(() {
                                  errorMessage = "Unable to sign in";
                                });
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AdminHomePage()),
                                );
                              }
                            }
                          },
                          child: Text(
                            "Sign in",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        //SizedBox(height: 5.0,),
                        Center(
                          child: Text(
                            errorMessage,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
}
