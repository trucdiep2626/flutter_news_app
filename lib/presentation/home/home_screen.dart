import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/bloc/authentication/authentication_bloc.dart';
import 'package:flutter_news_app/bloc/authentication/authentication_event.dart';
import 'package:flutter_news_app/bloc/home/home_bloc.dart';
import 'package:flutter_news_app/bloc/home/home_event.dart';
import 'package:flutter_news_app/bloc/home/home_state.dart';
import 'package:flutter_news_app/models/user.dart';

import 'package:flutter_news_app/repositories/user_repository.dart';

class HomeScreen extends StatelessWidget {
  final UserRepository userRepository;

  HomeScreen({required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            HomeBloc(userRepository: userRepository)..add(UpdateHomeEvent()),
        child: BlocBuilder<HomeBloc, HomeState>(builder: (context, homeState) {
          if (homeState is HomeLoadingDataState)
            return Scaffold(
              body: Center(
                child: Container(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          else if (homeState is HomeLoadDataSuccessState) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                leading: Icon(Icons.search),
                title: Text(
                  'News',
                  style: TextStyle(color: Colors.blueAccent),
                ),
                actions: [
                  IconButton(onPressed:() {
                    BlocProvider.of<HomeBloc>(context)
                        .add(UpdateHomeEvent());
                  },  icon: Icon(Icons.update, color: Colors.blueAccent,)),
                  IconButton(
                      onPressed: () {
                        BlocProvider.of<AuthenticationBloc>(context)
                            .add(SignedOutEvent());
                      },
                      icon: Icon(Icons.exit_to_app)),
                ],
              ),
              body: Center(
                child: Text('Home'),
              ),
              // ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.white,
              leading: Icon(Icons.search),
              title: Text(

                'News',
                style: TextStyle(color: Colors.blueAccent),
              ),
              actions: [  IconButton(onPressed:() {
                BlocProvider.of<HomeBloc>(context)
                    .add(UpdateHomeEvent());
              },  icon: Icon(Icons.update, color: Colors.blueAccent,)),
                IconButton(
                    onPressed: () {
                      BlocProvider.of<AuthenticationBloc>(context)
                          .add(SignedOutEvent());
                    },
                    icon: Icon(Icons.exit_to_app,color: Colors.blueAccent)),
              ],
            ),
            body: Center(
              child: Container(
                child: Text('Error'),
              ),
            ),
          );
        }));
  }
}
