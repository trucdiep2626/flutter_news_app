import 'package:equatable/equatable.dart';

abstract class SignInEvent extends Equatable{}

class SetEmailToSignInEvent extends SignInEvent{
  final String email;

  SetEmailToSignInEvent({required this.email});

  @override
  // TODO: implement props
  List<Object?> get props =>[this.email];
}
class SetPasswordToSignInEvent extends SignInEvent{
  final String password;

  SetPasswordToSignInEvent({required this.password});

  @override
  // TODO: implement props
  List<Object?> get props =>[this.password];
}

class SignInWithEmailEvent extends SignInEvent{
  final String email;
  final String password;

  SignInWithEmailEvent({required this.email,required this.password});

  @override
  // TODO: implement props
  List<Object?> get props =>[this.password, this.email];
}