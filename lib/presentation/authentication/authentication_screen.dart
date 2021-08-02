import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/bloc/authentication/authentication_bloc.dart';
import 'package:flutter_news_app/bloc/authentication/authentication_event.dart';
import 'package:flutter_news_app/bloc/authentication/authentication_state.dart';
import 'package:flutter_news_app/models/user.dart';
import 'package:flutter_news_app/presentation/authentication/sign_in/sign_in_screen.dart';
import 'package:flutter_news_app/presentation/home/home_screen.dart';
import 'package:flutter_news_app/repositories/user_repository.dart';



class AuthenticationScreen extends StatelessWidget {


  final UserRepository _userRepository = UserRepository();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>
    AuthenticationBloc(userRepository: _userRepository)
      ..add(AuthenticationEventStarted()),
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(builder: (context, authenticationState)
      {
        if (authenticationState is AuthenticationStateSuccess)
        {
          return HomeScreen(userRepository: _userRepository);
        }
        if (authenticationState is AuthenticationStateFailure)
        {
          return SignInScreen(userRepository: _userRepository);
        }
        return Center(
          child: CircularProgressIndicator(),
        ) ;
      }),);
  }


}