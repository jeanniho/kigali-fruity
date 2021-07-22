import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:k_fruity/database/database.dart';
import 'package:k_fruity/shared/drawer.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class PurchaseHistory extends StatelessWidget {
  const PurchaseHistory({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "P",
              style: TextStyle(
                color: Color(0xff547e73),
                fontFamily: 'Ogowey',
                fontSize: 25,
              ),
            ),
            Text(
              'urchase',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Ogowey',
                fontSize: 25,
              ),
            ),
            SizedBox(width: 8,),
            Text(
              "H",
              style: TextStyle(
                color: Color(0xff547e73),
                fontFamily: 'Ogowey',
                fontSize: 25,
              ),
            ),
            Text(
              "istory",
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
            backgroundColor: Colors.white,
            radius: 25,
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
      drawer: SignedInDrawer(),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/detailbg.jpg"),
              fit: BoxFit.cover
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                color: Colors.white24,
                child: Row(
                  children: [
                    Container(
                      child: Image(
                        image: AssetImage("assets/payment.png"),
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "Banking details",
                            style: TextStyle(
                              fontSize: 30,
                              color: Color(0xffd96b00),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Card payment account",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            )
                          ),
                          Divider(
                            color: Color(0xffd96b00),
                            thickness: 2,
                            indent: 32,
                            endIndent: 32,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                                              child: Text(
                                  "Account Name:",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  )
                                ),
                              ),
                              SizedBox(width: 8,),
                              Expanded(
                                                              child: Text(
                                  "The Ben",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  )
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                                              child: Text(
                                  "Bank Name:",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  )
                                ),
                              ),
                              SizedBox(width: 8,),
                              Expanded(
                                                              child: Text(
                                  "Rwandan Bank",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  )
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                                              child: Text(
                                  "Account Number:",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  )
                                ),
                              ),
                              SizedBox(width: 8,),
                              Expanded(
                                                              child: Text(
                                  "11254785236",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  )
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                                              child: Text(
                                  "Branch code:",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  )
                                ),
                              ),
                              SizedBox(width: 8,),
                              Expanded(
                                                              child: Text(
                                  "12Y103Ben001",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  )
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "Purchase History",
                        style: TextStyle(
                          fontSize: 26,
                          color: Color(0xffd96b00),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 2,
                      indent: 80,
                      endIndent: 80,
                    ),
                  ],
                ),
              ),
              Expanded(
                              child: Database(uid: _auth.currentUser.uid).getPurchaseHistory(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
