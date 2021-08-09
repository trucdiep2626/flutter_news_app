import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/bloc/home/home_event.dart';
import 'package:flutter_news_app/bloc/home/home_state.dart';
import 'package:flutter_news_app/data/models/categories_list.dart';
import 'package:flutter_news_app/data/repositories/news_repository.dart';
import 'package:flutter_news_app/data/repositories/user_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserRepository userRepository;

  HomeBloc({required this.userRepository}) : super(HomeLoadingDataState(selectedIndex: 0));



  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is UpdateHomeEvent) {
      yield* _mapUpdateHomeEventToState(event);
    }
  }

  Stream<HomeState> _mapUpdateHomeEventToState(UpdateHomeEvent event) async* {
   yield HomeLoadingDataState(selectedIndex: event.selectedIndex);
    try  {
     // log('))))))))))))))))))))))))))))))');
      final news = await NewsRepository().fetchNews(category: categories[event.selectedIndex]);
      log(news.length.toString()+'+++++++++++++++++');
      yield HomeLoadDataSuccessState(news: news,selectedIndex: event.selectedIndex);
    } catch (_) {
      log('error');
     yield HomeLoadDataFailureState(selectedIndex: event.selectedIndex);
    }
  }
}
