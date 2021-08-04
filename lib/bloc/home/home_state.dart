import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class HomeState extends Equatable{

}

class HomeLoadingDataState extends HomeState{
  final int selectedIndex;
  HomeLoadingDataState({required this.selectedIndex}) ;

  @override
  List<Object?> get props => [ this.selectedIndex];
}
class HomeLoadDataSuccessState extends HomeState{
  final List news;
  final int selectedIndex;
  HomeLoadDataSuccessState({required this.news, required this.selectedIndex})  ;
  @override
  List get props=>[this.news,this.selectedIndex];


}
class HomeLoadDataFailureState extends HomeState{

  final int selectedIndex;
  HomeLoadDataFailureState({required this.selectedIndex}) ;
  @override
  // TODO: implement props
  List<Object?> get props =>  [ this.selectedIndex];
}
