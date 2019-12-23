import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:instagram_demo/screens/feed_screen.dart';
import 'package:instagram_demo/screens/login_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
//  print("in google signin");
  static final _auth = FirebaseAuth.instance;
  static final _firestore = Firestore.instance;
  static final GoogleSignIn googleSignIn = GoogleSignIn();

  static Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;
    print(user.email);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    return 'signInWithGoogle succeeded: $user';
  }

  static void signupUser(
      BuildContext context, String name, String email, String password) async {
    // ignore: unused_element
    try {
      print(email);
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
          email: email.toString().trim(), password: password);

      FirebaseUser sigendInUser = authResult.user;
      if (sigendInUser != null) {
        _firestore
            .collection('/users')
            .document(sigendInUser.uid)
            .setData({'name': name, 'email': email, 'profileImageUrl': ''});
        Navigator.pushReplacementNamed(context, FeedScreen.id);
      }
    } catch (e) {
      print(e);
    }
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();

    print("User Sign Out");
  }

  static void logout(BuildContext context) {
    _auth.signOut();
    Navigator.pushReplacementNamed(context, LoginScreen.id);
  }

  static void login(BuildContext context, String email, String password) {
    print('in');
    _auth.signInWithEmailAndPassword(
        email: email.toString().trim(), password: password);
    Navigator.pushReplacementNamed(context, FeedScreen.id);
  }
}
