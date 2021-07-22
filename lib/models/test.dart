import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  int currentPos = 0;
  List<String> listPaths = [
    "assets/apples.jpg",
    "assets/orange.png",
    "assets/signup.png",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.amber,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CarouselSlider.builder(
              itemCount: listPaths.length,
              options: CarouselOptions(
                  autoPlay: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentPos = index;
                    });
                  }
              ),
              itemBuilder: (context,index){
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Image.asset(listPaths[index]),
                  )
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
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentPos == index
                        ? Color.fromRGBO(0, 0, 0, 0.9)
                        : Color.fromRGBO(0, 0, 0, 0.4),
                  ),
                );
              }).toList(),
            ),
          ]
        ),
      ),
    );
  }
}