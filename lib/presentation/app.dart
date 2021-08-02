import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/presentation/authentication/wrapper.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'authentication/authentication_screen.dart';


class MyApp extends StatelessWidget {
  final Future<FirebaseApp> fbApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fbApp,
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return Text('Something went wrong');
          else if (snapshot.hasData)
            return ScreenUtilInit(designSize: Size(400, 700),
                builder: () =>
                    MaterialApp(
                      title: 'Flutter News App',
                      theme: ThemeData(
                        primarySwatch: Colors.blue,
                      ),
                      home: AuthenticationScreen(),
                    )
            );
          return Center(
            child: CircularProgressIndicator(),
          ) ;
        }
    );
  }
}