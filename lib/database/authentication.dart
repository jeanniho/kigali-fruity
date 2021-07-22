import 'package:firebase_auth/firebase_auth.dart';
import 'package:k_fruity/database/database.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //track auth state change
  Stream<User> get user {
    return _auth.authStateChanges();
  }

  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password, {bool admin=false}) async {
    try {
      final UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final User user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future signUpWithEmailAndPassword(String fullname,
      String phone,  String email, String password, {bool admin=false}) async {
    try {
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final User user = result.user;
      await Database(uid: user.uid).userProfile(fullname, phone, user.email, admin: admin);
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //log out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}