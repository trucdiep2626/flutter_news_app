import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_news_app/data/providers/user_provider.dart';

class UserRepository {
  UserProvider _userProvider = UserProvider();

  Future signInWithEmailAndPassword(String email, String password) async {
    return await _userProvider.signInWithEmailAndPassword(email, password);
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    return await _userProvider.signUpWithEmailAndPassword(email, password);
  }

  Future signOut() async {
    return await _userProvider.signOut();
  }

  Future<bool> isSignedIn() async {
    return await _userProvider.isSignedIn();
  }

  Future<User?> getUser() async {
    return await _userProvider.getUser();
  }
}
