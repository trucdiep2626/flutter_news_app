import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable{}

class SetEmailToSignUpEvent extends SignUpEvent{
  final String email;

  SetEmailToSignUpEvent({required this.email});

  @override
  // TODO: implement props
  List<Object?> get props =>[this.email];
}
class SetPasswordToSignUpEvent extends SignUpEvent{
  final String password;

  SetPasswordToSignUpEvent({required this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [this.password];
}

class SignUpWithEmailEvent extends SignUpEvent{
  final String email;
  final String password;

  SignUpWithEmailEvent({required this.email,required this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [this.password, this.email];
}