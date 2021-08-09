import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_news_app/data/models/article.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleScreen extends StatefulWidget {

  final Article article;
  ArticleScreen({required this.article});

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  late WebViewController _webViewController;
  double _webViewHeight = 1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:  Container(
               height: MediaQuery.of(context).size.height,
             width: MediaQuery.of(context).size.width,
              child: WebView(
                initialUrl:  widget.article.link,
                javascriptMode: JavascriptMode.unrestricted,
                onPageFinished: (String url) => _onPageFinished(context, url),
                onWebViewCreated: (controller) async {
                  _webViewController = controller;
                },
              ),
            ),
        bottomNavigationBar: Row(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Padding(
                padding:EdgeInsets.symmetric(vertical: 10.h,horizontal: 25.h),
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
    });
  }
}