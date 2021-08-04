import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/bloc/authentication/authentication_bloc.dart';
import 'package:flutter_news_app/bloc/authentication/authentication_event.dart';
import 'package:flutter_news_app/models/article.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {

  final Article article;
  ArticleView({required this.article});

  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {

  final Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
       // automaticallyImplyLeading: true,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.black38,
          ),
        ),
        title:    Image.network(
          'https://s.vnecdn.net/vnexpress/i/v20/logos/vne_logo_rss.png',
          height: 64.h,
          width: ScreenUtil().screenWidth,
          fit: BoxFit.fitHeight,
        ),
         actions: [
           IconButton(
               onPressed: () {
                 BlocProvider.of<AuthenticationBloc>(context)
                     .add(SignedOutEvent());
               },
               icon: Icon(Icons.exit_to_app, color:Colors.white)),
         ],
      ),
      body:Stack(
        children: [
          Positioned.fill(
            top: -220.h,
            child: Container(
             height: MediaQuery.of(context).size.height,
           width: MediaQuery.of(context).size.width,
            child: WebView(
             // javascriptMode: JavascriptMode.unrestricted,
              initialUrl:  widget.article.link,
              onWebViewCreated: (WebViewController webViewController){
                _controller.complete(webViewController);
              },
            ),
          ),),
          // Positioned.fill(
          //     top: 0,
          //     bottom: ScreenUtil().screenHeight-300,
          //     child:  ClipRRect(
          //         child: Image.network(
          //           widget.article.thumbnail!,
          //           height: 300.h,
          //           width: ScreenUtil().screenWidth,
          //           fit: BoxFit.cover,
          //         )),),
        ],
      )
    );
  }
}