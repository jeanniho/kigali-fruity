import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:k_fruity/database/database.dart';
import '../shared/drawer.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPos = 0;
  List<String> listPaths = [
    "assets/orange.png",
    "assets/Banana.png",
    "assets/grapes.png",
    "assets/apples.png",
    "assets/greenApple.png",
    "assets/melongfgjsd.png",
    "assets/grapes.png",
  ];
  @override
  Widget build(BuildContext context) {
    print(_auth.currentUser);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
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
                color: Color(0xff927030),
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
                color: Color(0xff927030),
                fontFamily: 'Ogowey',
                fontSize: 25,
              ),
            ),
          ],
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.white,
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
      drawer: _auth.currentUser != null ? SignedInDrawer():SignedOutDrawer(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/homebg.jpg"),
            fit: BoxFit.cover
          ),
        ),
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.amber,
                  // height: 300,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CarouselSlider.builder(
                          itemCount: listPaths.length,
                          options: CarouselOptions(
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 800),
                              height: 200,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  currentPos = index;
                                });
                              }),
                          itemBuilder: (context, index) {
                            return Container(
                              // width: 300,
                              // height: 300,
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image(
                                  image: AssetImage(listPaths[index]),
                                  fit: BoxFit.fill,
                                  height: 300,
                                  width: 300,
                                ),
                              ),
                            );
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: listPaths.map((url) {
                            int index = listPaths.indexOf(url);
                            return Container(
                              width: 8.0,
                              height: 8.0,
                              margin: EdgeInsets.fromLTRB(2, 8, 2, 0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: currentPos == index
                                    ? Color.fromRGBO(0, 0, 0, 0.9)
                                    : Color.fromRGBO(0, 0, 0, 0.4),
                              ),
                            );
                          }).toList(),
                        ),
                      ]),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          "Avaialable Products",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 2,
                        indent: 90,
                        endIndent: 90,
                        color: Colors.white,
                      ),
                      Expanded(
                        child: Database().getProducts(context),
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
}
