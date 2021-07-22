import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:k_fruity/admin%20pages/AdminSignIn.dart';
import 'package:k_fruity/admin%20pages/AdminSignUp.dart';
import 'package:k_fruity/admin%20pages/adminAccountDetails.dart';
import 'package:k_fruity/admin%20pages/adminHome.dart';
import 'package:k_fruity/database/authentication.dart';
import 'package:k_fruity/database/database.dart';
import 'package:k_fruity/pages/accountDetails.dart';
import 'package:k_fruity/pages/contact.dart';
import 'package:k_fruity/pages/purchaseHistory.dart';
import '../pages/home.dart';
import '../pages/signUp.dart';
import '../pages/signIn.dart';
import '../admin pages/orders.dart';
import '../admin pages/messages.dart';
import '../admin pages/uploadproduct.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
User _user = _auth.currentUser;

class SignedInDrawer extends StatefulWidget {
  SignedInDrawer({Key key}) : super(key: key);

  @override
  _SignedInDrawer createState() => _SignedInDrawer();
}

class _SignedInDrawer extends State<SignedInDrawer> {
  @override
  void initState() {
    super.initState();
    relaod();
  }

  relaod() async {
    await _user.reload();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: ListView(children: [
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft, end: Alignment.bottomRight,
                //stops: [0.1,0.4]
                colors: [Colors.pink[400], Colors.lightGreen[400]]),
          ),
          accountEmail: _user != null
              ? Database(uid: _user.uid).getEmail(admin: false)
              : Text("User email address"),
          accountName: _user != null
              ? Database(uid: _user.uid).getName(admin: false)
              : Text("User name"),
          currentAccountPicture: GestureDetector(
            child: CircleAvatar(
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
          ),
        ),
        InkWell(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
            child: ListTile(
                leading: Icon(Icons.shopping_cart), title: Text('Home'))),
        InkWell(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PurchaseHistory()),
            );
          },
          child: ListTile(
              leading: Icon(Icons.shopping_basket),
              title: Text('Purchase History')),
        ),
        InkWell(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ContactPage()),
            );
          },
          child: ListTile(
              leading: Icon(Icons.contact_page), title: Text('Contact')),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AccountPage()),
            );
          },
          child: ListTile(
            leading: Icon(Icons.person),
            title: Text('My account'),
          ),
        ),
        Divider(
          thickness: 2,
          endIndent: 8,
          indent: 8,
          color: Colors.lightGreen[400],
        ),
        InkWell(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdminSignIn()),
            );
          },
          child: ListTile(
            leading: Icon(Icons.admin_panel_settings),
            title: Text('Admin'),
          ),
        ),
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => new AlertDialog(
                title:
                    new Text("!Settings!"),
                content: new Text(
                  "Setting options still under development.",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Okay'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              )
            );
          },
          child: ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ),
        InkWell(
          onTap: () async {
            await Authentication().signOut();
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          child: ListTile(
              leading: Icon(Icons.power_settings_new), title: Text("Logout")),
        ),
      ]),
    );
  }
}

class SignedOutDrawer extends StatefulWidget {
  SignedOutDrawer({Key key}) : super(key: key);

  @override
  _SignedOutDrawerState createState() => _SignedOutDrawerState();
}

class _SignedOutDrawerState extends State<SignedOutDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: ListView(children: [
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft, end: Alignment.bottomRight,
                //stops: [0.1,0.4]
                colors: [Colors.pink[400], Colors.lightGreen[400]]),
          ),
          accountEmail: Text("Anonymous"),
          accountName: Text("Anonymous"),
          currentAccountPicture: GestureDetector(
            child: CircleAvatar(
                backgroundColor: Color(0xff004f00), child: Icon(Icons.person)),
          ),
        ),
        InkWell(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdminSignIn()),
            );
          },
          child: ListTile(
            leading: Icon(Icons.admin_panel_settings),
            title: Text('Admin'),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignIn()),
            );
          },
          child: ListTile(
            leading: Icon(Icons.lock_open),
            title: Text("Login"),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUp()),
            );
          },
          child: ListTile(
            leading: Icon(Icons.person_add),
            title: Text("Sign up"),
          ),
        ),
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => new AlertDialog(
                title: new Text("!Settings!"),
                content: new Text(
                  "You must be signed in to use this feature!",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Okay'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              )
            );
          },
          child: ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ),
      ]),
    );
  }
}

class AdminDrawer extends StatefulWidget {
  @override
  _AdminDrawerState createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {
  @override
  void initState() {
    super.initState();
    relaod();
  }

  relaod() async {
    await _user.reload();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: ListView(children: [
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft, end: Alignment.bottomRight,
                //stops: [0.1,0.4]
                colors: [Colors.pink[400], Colors.lightGreen[400]]),
          ),
          accountEmail: _user != null
              ? Database(uid: _user.uid).getEmail(admin: true)
              : Text("User email address"),
          accountName: _user != null
              ? Database(uid: _user.uid).getName(admin: true)
              : Text("User name"),
          currentAccountPicture: GestureDetector(
            child: CircleAvatar(
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
          ),
        ),
        InkWell(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminHomePage()),
              );
            },
            child: ListTile(leading: Icon(Icons.image), title: Text('Home'))),
        InkWell(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OrderPage()),
            );
          },
          child: ListTile(
              leading: Icon(Icons.shopping_bag), title: Text('Orders')),
        ),
        InkWell(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MessagePage()),
            );
          },
          child:
              ListTile(leading: Icon(Icons.message), title: Text('Messages')),
        ),
        InkWell(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UploadProduct()),
            );
          },
          child: ListTile(
              leading: Icon(Icons.upload_file), title: Text('Upload product')),
        ),
        InkWell(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ContactPage()),
            );
          },
          child: ListTile(
              leading: Icon(Icons.contact_page), title: Text('Contact')),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdminAccountPage()),
            );
          },
          child: ListTile(
            leading: Icon(Icons.person),
            title: Text('My account'),
          ),
        ),
        Divider(
          thickness: 2,
          endIndent: 8,
          indent: 8,
          color: Colors.lightGreen[400],
        ),
        InkWell(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdminSignUp()),
            );
          },
          child: ListTile(
            leading: Icon(Icons.admin_panel_settings),
            title: Text('Add admin'),
          ),
        ),
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => new AlertDialog(
                title:
                    new Text("!Settings!"),
                content: new Text(
                  "Setting options still under development.",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Okay'),
                    onPressed: () {
                      Navigator.of(context)
                          .pop();
                    },
                  ),
                ],
              ));
          },
          child: ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ),
        InkWell(
          onTap: () async {
            await Authentication().signOut();
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          child: ListTile(
              leading: Icon(Icons.power_settings_new), title: Text("Logout")),
        ),
      ]),
    );
  }
}
