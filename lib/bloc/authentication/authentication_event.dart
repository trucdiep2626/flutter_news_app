import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable{

}
class AuthenticationEventStarted extends AuthenticationEvent{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class SignedInEvent extends AuthenticationEvent{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
class SignedOutEvent extends AuthenticationEvent{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}