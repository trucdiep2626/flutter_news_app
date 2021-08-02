import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationState extends Equatable{
  const
  AuthenticationState();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class AuthenticationStateInitial extends AuthenticationState{

}
class AuthenticationStateSuccess extends AuthenticationState{
  final User? firebaseUser;

  AuthenticationStateSuccess({required this.firebaseUser});
  @override
  List<User?> get props=>[this.firebaseUser];


}
class AuthenticationStateFailure extends AuthenticationState{

}

