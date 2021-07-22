import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:k_fruity/database/database.dart';
import 'package:k_fruity/shared/drawer.dart';
import 'package:k_fruity/shared/sharedVariables.dart';

import 'adminHome.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
User _user = _auth.currentUser;

class UploadProduct extends StatefulWidget {
  @override
  _UploadProductState createState() => _UploadProductState();
}

class _UploadProductState extends State<UploadProduct> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _price = TextEditingController();
  ImagePicker _imagePicker = ImagePicker();
  PickedFile _selectedFile;

  Widget selectedPost() {
    if (_selectedFile != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Image.file(
          File(_selectedFile.path),
          height: 200,
          width: 300,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.lightGreen[400], Colors.deepPurpleAccent[400]]),
        ),
        height: MediaQuery.of(context).size.height / 3,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Upload product image",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              FlatButton.icon(
                color: Colors.blue,
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: ((builder) => bottomSheet()),
                  );
                },
                icon: Icon(
                  Icons.add_to_photos,
                  color: Colors.white,
                ),
                label: Text(
                  "Select file",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          Text(
            "Select file",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(
                onPressed: () {
                  getImage("camera");
                },
                icon: Icon(
                  Icons.camera,
                ),
                label: Text(
                  "Camera",
                ),
              ),
              FlatButton.icon(
                onPressed: () {
                  getImage("gallery");
                },
                icon: Icon(
                  Icons.folder,
                  color: Colors.grey,
                ),
                label: Text(
                  "Files",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void getImage(String option) async {
    var pickedFile;
    try {
      if (option.toLowerCase() == "camera") {
        pickedFile = await _imagePicker.getImage(source: ImageSource.camera);
      } else {
        pickedFile = await _imagePicker.getImage(source: ImageSource.gallery);
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      _selectedFile = pickedFile;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        backgroundColor: Color(0xffd96b00),
        iconTheme: IconThemeData(color: Colors.black),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "U",
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Ogowey',
                fontSize: 30,
              ),
            ),
            Text(
              'pload',
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
              "roduct",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Ogowey',
                fontSize: 25,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: <Widget>[
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
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/messagebg.jpg"),
                fit: BoxFit.cover
              ),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: _title,
                      keyboardType: TextInputType.text,
                      decoration:
                          textInputDecoration.copyWith(labelText: "Product name"),
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Product need to have a name";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                selectedPost(),
                SizedBox(height: 8,),
                 Expanded(
                  child: TextFormField(
                    controller: _description,
                    keyboardType: TextInputType.text,
                    decoration: textInputDecoration.copyWith(
                        labelText: "Product description"),
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Please describe the product";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: _price,
                    keyboardType: TextInputType.number,
                    decoration:
                        textInputDecoration.copyWith(labelText: "Product price"),
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Please add product price";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      FlatButton(
                        color: Colors.red[900],
                        onPressed: () {
                          setState(() {
                            _selectedFile = null;
                          });
                          // Navigator.pop(context);
                        },
                        child: Text("Delete"),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      FlatButton(
                        color: Colors.deepPurpleAccent,
                        onPressed: () async {
                          if (_selectedFile != null) {
                            // print("selected file not empty");
                            await Database(uid: _user.uid).uploadProductToFirebase(
                              _title.text,
                              File(_selectedFile.path),
                              _description.text,
                              _price.text
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdminHomePage()
                              ),
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text("Please select a post"),
                                );
                              }
                            );
                          }
                        },
                        child: Text("Post"),
                      ),
                    ],
                  ),
                ),
                ],
              ),
            ),
          ),
      ),
    );
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    _price.dispose();
    super.dispose();
  }
}
