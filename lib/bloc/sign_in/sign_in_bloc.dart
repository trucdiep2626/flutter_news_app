import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/bloc/sign_in/sign_in_event.dart';
import 'package:flutter_news_app/bloc/sign_in/sign_in_state.dart';
import 'package:flutter_news_app/data/repositories/user_repository.dart';
import 'package:flutter_news_app/validators/validators.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  UserRepository userRepository;

  SignInBloc({required this.userRepository}) : super(SignInState.initial());

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    if (event is SetEmailToSignInEvent) {
      yield* _mapSetEmailToSignInEventToState(event);
    }
    if (event is SetPasswordToSignInEvent) {
      yield* _mapSetPasswordToSignInEventToState(event);
    }
    if (event is SignInWithEmailEvent) {
      yield* _mapSignInWithEmailEventToState(event);
    }
    if (event is ShowPasswordEventInSignIn) {
      yield* _mapShowPasswordEventInSignInToState(event);
    }
  }

  Stream<SignInState> _mapSignInWithEmailEventToState(
      SignInWithEmailEvent event) async* {
    yield SignInState.loading();
    try {
      if (event.email != null && event.password != null)
        await userRepository.signInWithEmailAndPassword(
            event.email, event.password);
      yield SignInState.success();
    } catch (_) {
      yield SignInState.failure();
      yield SignInState.initial();
    }
  }

  Stream<SignInState> _mapSetPasswordToSignInEventToState(
      SetPasswordToSignInEvent event) async* {
    yield state.update(isValidPassword: event.password != '');
  }

  Stream<SignInState> _mapSetEmailToSignInEventToState(
      SetEmailToSignInEvent event) async* {
    yield state.update(isValidEmail: event.email !='');
  }

  Stream<SignInState> _mapShowPasswordEventInSignInToState(
      ShowPasswordEventInSignIn event) async* {
    yield state.update(showPassword: event.showPassword);
  }
}
