import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/repositories/user_repository.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent,AuthenticationState>{
  final UserRepository userRepository;

  AuthenticationBloc({ required this.userRepository}): super(AuthenticationStateInitial());

  AuthenticationState get initialState => AuthenticationStateInitial();

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if(event is AuthenticationEventStarted)
      {
        yield* _mapAuthenticationEventStartedToState(event);
      }
    if (event is SignedInEvent)
      {
        yield* _mapSignedInEventToState(event);
      }
    if (event is SignedOutEvent)
    {
      yield* _mapSignedOutEventToState(event);
    }
  }

  Stream<AuthenticationState> _mapSignedOutEventToState(SignedOutEvent event) async* {
    await userRepository.signOut();
    log("sign out **************************");
    yield AuthenticationStateFailure();
  }

  Stream<AuthenticationState> _mapSignedInEventToState(SignedInEvent event) async* {

    final User? fbUser = await userRepository.getUser();

    yield AuthenticationStateSuccess(firebaseUser: fbUser);
  }

  Stream<AuthenticationState> _mapAuthenticationEventStartedToState(AuthenticationEventStarted event) async* {
    final isSignedIn = await userRepository.isSignedIn();
    if(isSignedIn)
      {
        final User? fbUser = await userRepository.getUser();
        yield AuthenticationStateSuccess(firebaseUser: fbUser);
      }
    else{
      yield AuthenticationStateFailure();
    }

  }

}