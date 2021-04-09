import 'package:crave_coffee/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on firebaseUser
  User1 _userFromFirebaseUser(User user) {
    return user != null ? User1(uid: user.uid) : null;
  }

  // auth changed user stream
  Stream<User1> get user {
    // return _auth.authStateChanges().map((User user) => _userFromFirebaseUser(user));
    return _auth.authStateChanges().map(_userFromFirebaseUser);
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
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print("Errorrrrrr: ${e.toString()}");
      return null;
    }
  }

  //Register with email-password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print("Errorrrrrr: ${e.toString()}");
      return null;
    }
  }

  //Sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      //do nothing
      print("Erorrrrr: ${e.toString()}");
    }
  }
}
