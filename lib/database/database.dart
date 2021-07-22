import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:k_fruity/screen/myCard.dart';

class Database {
  final String uid;
  Database({this.uid});
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //firebase storage reference
  final storageReference = FirebaseStorage.instance.ref();
  // firestore references
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference admins =
      FirebaseFirestore.instance.collection('admins');
  final CollectionReference products =
      FirebaseFirestore.instance.collection('products');
  final CollectionReference orders =
      FirebaseFirestore.instance.collection('orders');
  final CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  final CollectionReference profile =
      FirebaseFirestore.instance.collection('profile');
  //save user details
  Future userProfile(String fullname, String phone, String email,
      {bool admin = false}) async {
    _auth.currentUser.updateProfile(displayName: admin.toString());
    await _auth.currentUser.reload();
    admin
        ? await admins.doc(uid).set({
            'uid': uid,
            'fullName': fullname,
            'phone': phone,
            'email': email,
          })
        : await users.doc(uid).set({
            'uid': uid,
            'fullName': fullname,
            'phone': phone,
            'email': email,
          });
  }

  //get user email
  Widget getEmail({bool admin = false}) {
    return StreamBuilder<DocumentSnapshot>(
      stream: admin ? admins.doc(uid).snapshots() : users.doc(uid).snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('An Error has occured');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading...");
        }

        return Text(
          snapshot.data.get('email') + "\n" + snapshot.data.get('phone'),
        );
      },
    );
  }

  //get user name
  Widget getName({bool admin = false}) {
    return StreamBuilder<DocumentSnapshot>(
      stream: admin ? admins.doc(uid).snapshots() : users.doc(uid).snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('An Error has occured');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading...");
        }

        return Text(
          snapshot.data.get('fullName'),
        );
      },
    );
  }

  // get user account details
  Widget getAccountDetails({String admin = "false"}) {
    print(uid);
    return StreamBuilder<DocumentSnapshot>(
      stream: admin == "true"
          ? admins.doc(uid).snapshots()
          : users.doc(uid).snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Text('An Error has occured'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading...");
        }

        return Column(
          children: [
            CircleAvatar(
              radius: 50,
              child: ClipOval(
                child: Image(
                  image: AssetImage("assets/profile.jpg"),
                  fit: BoxFit.cover,
                  width: 100.0,
                  height: 100.0,
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Name:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  snapshot.data.get('fullName'),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Email:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  snapshot.data.get('email'),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Phone:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  snapshot.data.get('phone'),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            // FlatButton(
            //   onPressed: () async {
            //     if(admin == "false"){
            //       await FirebaseFirestore.instance
            //         .collection(uid)
            //         .doc("history")
            //         .collection("history")
            //         .snapshots()
            //         .forEach((element) {
            //         for (QueryDocumentSnapshot snapshot in element.docs) {
            //           snapshot.reference.delete();
            //         }
            //       });
            //       await orders.doc(snapshot.data.id).delete();
            //     }
            //     admin == "true"
            //         ? await admins.doc(snapshot.data.id).delete()
            //         : await users.doc(snapshot.data.id).delete();
            //     await _user.delete();
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => HomePage()),
            //     );
            //   },
            //   child: Text(
            //     "Delete account",
            //     style: TextStyle(
            //       color: Colors.white,
            //     ),
            //   ),
            // ),
          ],
        );
      },
    );
  }

  // check profile picture
  // Future uploadProfilePicture(File file, {String admin="false"}) async {
  //   dynamic data;
  //   try {
  //     final DocumentReference document = admin=="false"?users.doc(uid):admins.doc(uid);
  //     await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
  //       data = snapshot.data();
  //     });
  //     int randomNumber = Random().nextInt(100000);
  //     String fileLocation = 'profile/image$randomNumber.jpg';
  //     // Upload image to firebase.
  //     var snapshot = await storageReference.child(fileLocation).putFile(file);
  //     await snapshot.ref.getDownloadURL();
  //     var fileString = await snapshot.ref.getDownloadURL();
  //     // Upload image to firestore.
  //     await profile.doc().set({
  //       'url': fileString,
  //       'fullName': data["fullName"],
  //       'email': data["email"],
  //       'phone': data["phone"],
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  // upload product to database
  Future uploadProductToFirebase(
      String title, File file, String description, String price) async {
    try {
      int randomNumber = Random().nextInt(100000);
      String fileLocation = 'images/image$randomNumber.jpg';
      // Upload image to firebase.
      var snapshot = await storageReference.child(fileLocation).putFile(file);
      await snapshot.ref.getDownloadURL();
      var fileString = await snapshot.ref.getDownloadURL();
      // Upload image to firestore.
      await products.doc().set({
        'url': fileString,
        "title": title,
        "description": description,
        "price": price,
      });
    } catch (e) {
      print(e);
    }
  }

  // get products from database
  Widget getProducts(BuildContext context, {bool admin = false}) {
    return StreamBuilder<QuerySnapshot>(
      stream: products.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return Container(
          margin: EdgeInsets.only(top: 8),
          child: GridView.builder(
            physics: BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, crossAxisSpacing: 1 //space between posts
                ),
            itemCount: snapshot.data.docs.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot product = snapshot.data.docs[index];
              return MyCard(
                product: product,
                admin: admin,
              );
            },
          ),
        );
      },
    );
  }

  // delete product
  Future deleteProduct(String url) async {
    try {
      await products.where("url", isEqualTo: url).get().then((snapshot) {
        snapshot.docs.first.reference.delete();
      });
    } catch (e) {
      print(e);
    }
  }

  // add message for admin
  Future addMessage(String message) async {
    dynamic data;
    try {
      final DocumentReference document = users.doc(uid);
      await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
        data = snapshot.data();
      });
      await messages.doc().set({
        'fullName': data["fullName"],
        'email': data["email"],
        'phone': data["phone"],
        "message": message,
      });
    } catch (e) {
      print(e);
    }
  }

  // get messages for admin
  Widget getMessages() {
    return StreamBuilder<QuerySnapshot>(
      stream: messages.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Text('An Error has occured'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading...");
        }

        return ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (context, index) => Divider(
            color: Color(0xffd96b00),
            endIndent: 20,
            thickness: 1,
            indent: 30,
          ),
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot message = snapshot.data.docs[index];
            return Material(
              type: MaterialType.transparency,
              child: Column(
                children: [
                  Text(
                    message.data()["fullName"],
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    message.data()["email"],
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    message.data()["phone"],
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Message:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        message.data()["message"],
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // add order to history
  Future purchaseHistory(String url, String number) async {
    dynamic product;
    try {
      await products
          .where("url", isEqualTo: url)
          .get()
          .then<dynamic>((QuerySnapshot snapshot) async {
        product = snapshot.docs[0].data();
      });
      // print(product);
      await FirebaseFirestore.instance
          .collection(uid)
          .doc("history")
          .collection("history")
          .doc()
          .set({
        'url': product["url"],
        "title": product["title"],
        "description": product["description"],
        "price": product["price"],
        "number": number,
      });
      await addOrder(product, uid, number);
    } catch (e) {
      print(e);
    }
  }

  // get purchase history ***********
  Widget getPurchaseHistory() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(uid)
          .doc("history")
          .collection("history")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('An Error has occured');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading...");
        }

        return ListView.separated(
          // scrollDirection: Axis.vertical,
          // shrinkWrap: true,
          separatorBuilder: (context, index) => Divider(
            color: Colors.grey[500],
            endIndent: 32,
            thickness: 1,
            indent: 32,
          ),
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot product = snapshot.data.docs[index];
            return Material(
              type: MaterialType.transparency,
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 5, 5),
                    child: Image.network(
                      product.data()["url"],
                      height: 150,
                      width: 150,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          product.data()["title"],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          "${product.data()["number"]} box/es",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          "${double.parse(product.data()["price"]) * int.parse(product.data()["number"])} RWF",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  FlatButton(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (_) => new AlertDialog(
                                            title:
                                                new Text("!PLEASE NOTE!"),
                                            content: new Text(
                                              "No refund of already paid fees for this product",
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text('Cancel'),
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop();
                                                },
                                              ),
                                              FlatButton(
                                                child: Text('Delete'),
                                                onPressed: () async {
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection(uid)
                                                      .doc("history")
                                                      .collection("history")
                                                      .doc(product.id)
                                                      .delete();
                                                  try {
                                                    await orders
                                                        .where("url",
                                                            isEqualTo:
                                                                product[
                                                                    "url"])
                                                        .get()
                                                        .then((snapshot) {
                                                      snapshot.docs.first
                                                          .reference
                                                          .delete();
                                                    });
                                                  } catch (e) {
                                                    print(e);
                                                  }
                                                  Navigator.of(context)
                                                      .pop();
                                                },
                                              ),
                                            ],
                                          ));
                                    },
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  FlatButton(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    onPressed: () async {
                                      await FirebaseFirestore.instance
                                          .collection(uid)
                                          .doc("history")
                                          .collection("history")
                                          .doc(product.id)
                                          .delete();
                                      try {
                                        await orders
                                            .where("url",
                                                isEqualTo: product["url"])
                                            .get()
                                            .then((snapshot) {
                                          snapshot.docs.first.reference
                                              .delete();
                                        });
                                      } catch (e) {
                                        print(e);
                                      }
                                      print("deleted order");
                                    },
                                    child: Text(
                                      "Recieved",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "An upfront of ${double.parse(product.data()["price"]) * int.parse(product.data()["number"]) * (60 / 100.0)} RWF is payable",
                                style: TextStyle(
                                  color: Colors.yellow,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // add order for admin
  Future addOrder(dynamic product, String uid, String number) async {
    dynamic data;
    try {
      final DocumentReference document = users.doc(uid);
      await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
        data = snapshot.data();
      });
      await orders.doc(uid).set({
        'fullName': data["fullName"],
        'email': data["email"],
        'phone': data["phone"],
        'url': product["url"],
        "title": product["title"],
        "description": product["description"],
        "price": product["price"],
        "number": number,
      });
    } catch (e) {
      print(e);
    }
  }

  // get orders for admin
  Widget getOrders() {
    return StreamBuilder<QuerySnapshot>(
      stream: orders.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Text('An Error has occured'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading...");
        }

        return ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (context, index) => Divider(
            color: Color(0xffd96b00),
            endIndent: 32,
            thickness: 1,
            indent: 32,
          ),
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot order = snapshot.data.docs[index];
            return Material(
              type: MaterialType.transparency,
              child: Column(
                children: [
                  Text(
                    order.data()["fullName"],
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    order.data()["email"],
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    order.data()["phone"],
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  ListTile(
                    leading: Text(
                      "Order:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      "${order.data()["number"]} box/es of ${order.data()["title"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    trailing: Text(
                      "${double.parse(order.data()["price"]) * int.parse(order.data()["number"])} RWF",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
