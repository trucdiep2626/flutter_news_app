import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/bloc/sign_up/sign_up_event.dart';
import 'package:flutter_news_app/bloc/sign_up/sign_up_state.dart';
import 'package:flutter_news_app/data/repositories/user_repository.dart';
import 'package:flutter_news_app/validators/validators.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  UserRepository userRepository;

  SignUpBloc({required this.userRepository}) : super(SignUpState.initial());

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SetEmailToSignUpEvent) {
      yield* _mapSetEmailToSignUpEventToState(event);
    }
    if (event is SetPasswordToSignUpEvent) {
      yield* _mapSetPasswordToSignUpEventToState(event);
    }
    if (event is SignUpWithEmailEvent) {
      yield* _mapSignUpWithEmailEventToState(event);
    }
    if (event is ShowPasswordEventInSignUp) {
      yield* _mapShowPasswordEventInSignUpToState(event);
    }
  }

  Stream<SignUpState> _mapSignUpWithEmailEventToState(
      SignUpWithEmailEvent event) async* {
    yield SignUpState.loading();
    try {
      var user = await userRepository.signUpWithEmailAndPassword(
          event.email, event.password);
      if (user == null) {
        yield SignUpState.failure();
        yield SignUpState.initial();
        return;
      }
      yield SignUpState.success();
    } catch (_) {
      yield SignUpState.failure();
      yield SignUpState.initial();
    }
  }

  Stream<SignUpState> _mapSetPasswordToSignUpEventToState(
      SetPasswordToSignUpEvent event) async* {
    yield state.update(
        isValidPassword: Validators.isValidPassword(event.password));
  }

  Stream<SignUpState> _mapSetEmailToSignUpEventToState(
      SetEmailToSignUpEvent event) async* {
    yield state.update(isValidEmail: Validators.isValidEmail(event.email));
  }

  Stream<SignUpState> _mapShowPasswordEventInSignUpToState(
      ShowPasswordEventInSignUp event) async* {
    yield state.update(showPassword: event.showPassword);
  }
}
