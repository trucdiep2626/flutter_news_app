import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class UserProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInWithEmailAndPassword(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
        email: email.trim(), password: password);
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      return null;
    } catch (_) {
      return await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<bool> isSignedIn() async {
    return await _auth.currentUser != null;
  }

  Future<User?> getUser() async {
    return await _auth.currentUser;
  }
}
