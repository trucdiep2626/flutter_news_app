import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
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
  late WebViewController _webViewController;
  double _webViewHeight = 1; @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar:  AppBar(
        //  // automaticallyImplyLeading: true,
        //   centerTitle: true,
        //   elevation: 0,
        //   backgroundColor: Colors.white,
        //   leading:
        //   title:    Image.network(
        //     'https://s.vnecdn.net/vnexpress/i/v20/logos/vne_logo_rss.png',
        //     height: 64.h,
        //     width: ScreenUtil().screenWidth,
        //     fit: BoxFit.fitHeight,
        //   ),
        //    actions: [
        //      IconButton(
        //          onPressed: () {
        //            BlocProvider.of<AuthenticationBloc>(context)
        //                .add(SignedOutEvent());
        //          },
        //          icon: Icon(Icons.exit_to_app, color:Colors.white)),
        //    ],
        // ),
        body:Stack(
          children: [
            Positioned.fill(
              top: 0.h,
              child: Container(
               height: MediaQuery.of(context).size.height,
             width: MediaQuery.of(context).size.width,
              child: WebView(
           //  javascriptMode: JavascriptMode.unrestricted,
                initialUrl:  widget.article.link,
                javascriptMode: JavascriptMode.unrestricted,
                onPageFinished: (String url) => _onPageFinished(context, url),
                onWebViewCreated: (controller) async {
                  _webViewController = controller;
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
        ),
        bottomNavigationBar: Row(
         //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_back_ios_outlined,
                  color: Colors.black38,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onPageFinished(BuildContext context, String url) async {
    double newHeight = double.parse(
      await _webViewController.evaluateJavascript("document.documentElement.scrollHeight;"),
    );
    setState(() {

      _webViewHeight = newHeight;
      log(_webViewHeight.toString());
    });
  }
}