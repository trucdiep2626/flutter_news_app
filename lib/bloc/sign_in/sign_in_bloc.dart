import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/bloc/sign_in/sign_in_event.dart';
import 'package:flutter_news_app/bloc/sign_in/sign_in_state.dart';
import 'package:flutter_news_app/repositories/user_repository.dart';
import 'package:flutter_news_app/validators/validators.dart';

class SignInBloc extends Bloc<SignInEvent,SignInState>{
  UserRepository userRepository;


  SignInBloc({required this.userRepository}):super(SignInState.initial());



  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async*{
   if(event is SetEmailToSignInEvent){
     yield* _mapSetEmailToSignInEventToState(event);
   }
   if(event is SetPasswordToSignInEvent){
     yield* _mapSetPasswordToSignInEventToState(event);
   }
   if(event is SignInWithEmailEvent){
     yield* _mapSignInWithEmailEventToState(event);
   }
  
  }

  Stream<SignInState> _mapSignInWithEmailEventToState(SignInWithEmailEvent event) async*{
    yield SignInState.loading();
    try{
      log(event.email);
      log(event.password);
      await userRepository.signInWithEmailAndPassword(event.email, event.password);
      log(event.email);
      log(event.password);
     yield SignInState.success();
   }catch(_){
     yield SignInState.failure();
   }
  }
  Stream<SignInState> _mapSetPasswordToSignInEventToState(SetPasswordToSignInEvent event) async*{
  // log(event.password);
    yield state.update(isValidPassword: Validators.isValidPassword(event.password));
  }

  Stream<SignInState> _mapSetEmailToSignInEventToState(SetEmailToSignInEvent event) async*{
    //log(event.email);
    yield state.update(isValidEmail: Validators.isValidEmail(event.email));
  }
}