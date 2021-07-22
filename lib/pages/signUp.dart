import 'package:flutter/material.dart';
import 'package:k_fruity/database/authentication.dart';
import 'package:k_fruity/pages/home.dart';
import '../shared/drawer.dart';
import '../shared/sharedVariables.dart';
import '../pages/signIn.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String errorMessage = "";
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _fullName = TextEditingController();
  final _phoneNumber = TextEditingController();
  Authentication _authentication = Authentication();

  @override
  Widget build(BuildContext context) {
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
      drawer: SignedOutDrawer(),
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
                    color: Color(0xffd96b00),
                    height: MediaQuery.of(context).size.height - 200,
                    width: MediaQuery.of(context).size.width - 40,
                    padding: EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: CircleAvatar(
                              backgroundColor: Color(0xffd96b00),
                              radius: 40,
                              child: ClipOval(
                                child: Image(
                                  image: AssetImage("assets/icon.png"),
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 14),
                            child: Text(
                              "Create Account",
                              style: TextStyle(
                                fontSize: 25.0,
                                color: Colors.greenAccent,
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: _fullName,
                              keyboardType: TextInputType.emailAddress,
                              decoration: textInputDecoration.copyWith(
                                  labelText: "Full name"),
                              validator: (val) {
                                if (val.isEmpty) {
                                  return "Please provide a valid full name";
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
                              controller: _phoneNumber,
                              keyboardType: TextInputType.phone,
                              decoration: textInputDecoration.copyWith(
                                  labelText: "Phone number"),
                              validator: (val) {
                                if (val.isEmpty) {
                                  return "Please provide a valid phone number";
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
                                if (val.length < 4) {
                                  return "Password must be at least 4 characters long";
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
                                dynamic user = await _authentication
                                    .signUpWithEmailAndPassword(
                                      _fullName.text,
                                      _phoneNumber.text,
                                      _email.text,
                                      _password.text,
                                      admin: false,
                                    );
                                if (user == null) {
                                  setState(() {
                                    errorMessage =
                                        "Registration was unsuccessful";
                                  });
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => HomePage()),
                                  );
                                }
                              }
                            },
                            child: Text(
                              "Sign up",
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
                  )),
              Positioned(
                bottom: 0,
                top: MediaQuery.of(context).size.height - 200,
                child: Container(
                  // color: Colors.greenAccent,
                  width: MediaQuery.of(context).size.width - 40,
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: <Widget>[
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignIn()),
                          );
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.greenAccent,
                            fontSize: 18.0,
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
    );
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _fullName.dispose();
    _phoneNumber.dispose();
    super.dispose();
  }
}
