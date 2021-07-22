import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:k_fruity/database/database.dart';
import 'package:k_fruity/shared/drawer.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
User _user = _auth.currentUser;

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  ImagePicker _imagePicker = ImagePicker();
  PickedFile _selectedFile;
  
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
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color(0xffd96600),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "A",
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Ogowey',
                fontSize: 30,
              ),
            ),
            Text(
              'ccount',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Ogowey',
                fontSize: 25,
              ),
            ),
            SizedBox(width: 8,),
            Text(
              "D",
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Ogowey',
                fontSize: 30,
              ),
            ),
            Text(
              "etails",
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
      drawer: _user!=null? SignedInDrawer():SignedOutDrawer(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/ordersbg.jpg"),
            fit: BoxFit.cover
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Database(uid: _user.uid).getAccountDetails(admin: _user.displayName),
        ),
      ),
    );
  }
}