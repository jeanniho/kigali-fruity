import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:k_fruity/database/database.dart';
import 'package:k_fruity/shared/drawer.dart';
import '../admin pages/adminHome.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
User _user = _auth.currentUser;

class RemovePage extends StatefulWidget {
  final product;

  RemovePage({this.product});

  @override
  _RemovePageState createState() => _RemovePageState();
}

class _RemovePageState extends State<RemovePage> {
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
              "R",
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Ogowey',
                fontSize: 25,
              ),
            ),
            Text(
              'emove',
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
              "roduct",
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
      drawer: _user!=null ? AdminDrawer():SignedOutDrawer(),
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
                color:  Colors.black54,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Center(
                  child: Column(
                    children: [
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
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: Column(
                  children: [
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
                          width: 8.0,
                        ),
                      ],
                    ),
                    FlatButton(
                      color: Color(0xff004f00),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      onPressed: () async {
                        await Database(uid: _auth.currentUser.uid).deleteProduct(widget.product.data()["url"]);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdminHomePage(),
                          ),
                        );
                      },
                      child: Text(
                        "Remove ${widget.product.data()["title"]}",
                        style: TextStyle(
                          color: Color(0xffeea607),
                          fontSize: 18.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
