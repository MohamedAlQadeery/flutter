import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class BaseAuth {
  Future<FirebaseUser> googleSignin();
}

class Auth implements BaseAuth {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<FirebaseUser> googleSignin() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final GoogleSignInAccount _googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication _googleSignInAuthontication =
        await _googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: _googleSignInAuthontication.idToken,
        accessToken: _googleSignInAuthontication.accessToken);

    try {
      FirebaseUser user = (await _firebaseAuth.signInWithCredential(credential))
          as FirebaseUser;

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
