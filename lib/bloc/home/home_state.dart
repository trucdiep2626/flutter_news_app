import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class HomeState extends Equatable{
  const HomeState();


}

class HomeLoadingDataState extends HomeState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
class HomeLoadDataSuccessState extends HomeState{
  final List news;

  HomeLoadDataSuccessState({required this.news});
  @override
  List get props=>[this.news];


}
class HomeLoadDataFailureState extends HomeState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
