import 'package:flutter/material.dart';
import 'package:flutter_news_app/bloc/simple_bloc_observer.dart';
import 'package:flutter_news_app/presentation/app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer= SimpleBlocObserver();
  runApp(MyApp());
}




