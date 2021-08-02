import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable{
  @override
  List<Object?> get props => throw UnimplementedError();
}


class UpdateHomeEvent extends HomeEvent{

}