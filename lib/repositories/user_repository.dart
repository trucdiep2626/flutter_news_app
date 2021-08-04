import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_news_app/models/user.dart';

class UserRepository{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // AuthService(this._auth); //create user obj
  UserModel? userFromFirebaseUser(User user)
  {
    return user!=null ?UserModel(  userId: user.uid):null;
  }
  //
  //auth change user stream
  // Stream <UserModel> get user{
  //   return _auth.authStateChanges().map((User? user) => userFromFirebaseUser(user!)!);
  // }

  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password)async{
   return await _auth.signInWithEmailAndPassword(email: email.trim(), password: password);
    // try{
    //   UserCredential result =await _auth.signInWithEmailAndPassword(email: email.trim(), password: password);
    //   User? user= result.user;
    //
    //   return userFromFirebaseUser(user!);
    // }catch(e){
    //   log(e.toString());
    //   return null;
    // }
  }

  //register
  Future signUpWithEmailAndPassword(String email, String password)async{
    await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password);
  }

  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e)
    {
      log(e.toString());
      return null;
    }
  }

  Future<bool> isSignedIn ()async{
    return await _auth.currentUser !=null;
  }

  Future<User?> getUser() async{
    return await _auth.currentUser;
  }
}