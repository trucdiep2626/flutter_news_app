import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/bloc/home/home_event.dart';
import 'package:flutter_news_app/bloc/home/home_state.dart';
import 'package:flutter_news_app/models/news.dart';
import 'package:flutter_news_app/repositories/user_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserRepository userRepository;

  HomeBloc({required this.userRepository}) : super(HomeLoadingDataState());

  HomeState get initialState => HomeLoadingDataState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is UpdateHomeEvent) {
      yield* _mapUpdateHomeEventToState(event);
    }
  }

  Stream<HomeState> _mapUpdateHomeEventToState(UpdateHomeEvent event) async* {
   // yield HomeLoadingDataState();
    try  {
      log('))))))))))))))))))))))))))))))');
      final news = await News().getNews();
      log(news.length.toString()+'+++++++++++++++++');
      yield HomeLoadDataSuccessState(news: news);
    } catch (_) {
      log('error');
    //  yield HomeLoadDataFailureState();
    }
  }
}
