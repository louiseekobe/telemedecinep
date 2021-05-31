import 'package:firebase_auth/firebase_auth.dart';
import 'package:medecineapp/models/user.dart';

class AuthServices {
  //instance de notre base de donnee dans firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user objet base on fibrebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
    //same thing
    //.map((FirebaseUser user) => _userFomFirebaseUser(user));
  }

  //sign in with email
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult resultat = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      FirebaseUser user = resultat.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //reset password
  Future reset(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
