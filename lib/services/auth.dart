import 'package:crave_coffee/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crave_coffee/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on firebaseUser
  User1 _userFromFirebaseUser(User user) {
    return user != null ? User1(uid: user.uid) : null;
  }

  //Anonymous sign-in
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print("Errorrrrr : ${e.toString()}");
      return null;
    }
  }

  //Sign-in with email-password

  //Register with email-password

  //Sign out

}
