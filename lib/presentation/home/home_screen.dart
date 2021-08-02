import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/bloc/authentication/authentication_bloc.dart';
import 'package:flutter_news_app/bloc/authentication/authentication_event.dart';
import 'package:flutter_news_app/models/user.dart';

import 'package:flutter_news_app/repositories/user_repository.dart';

class HomeScreen extends StatelessWidget {

  final UserRepository userRepository;

  HomeScreen({required this.userRepository});


  @override
  Widget build(BuildContext context) {
    return

        Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Icon(Icons.search),
        title: Text(
          'News',
          style: TextStyle(color: Colors.blueAccent),
        ),
        actions: [
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
}
