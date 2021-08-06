import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/models/article.dart';
import 'package:flutter_news_app/presentation/article_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ArticleTile extends StatelessWidget {
  ArticleTile({Key? key, required this.article}) : super(key: key);
  final Article article;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleScreen(article: article)));
      },
      child: Container(
          margin: EdgeInsets.only(bottom: 20.h),
          width: ScreenUtil().screenWidth,
          child: Container(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(6),
                      bottomLeft: Radius.circular(6))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  article.thumbnail == ''
                      ? Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(6)),
                          width: ScreenUtil().screenWidth,
                          height: 200,
                          child: Text(
                            'No Image',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                fontSize: 20.sp,
                                color: Colors.black38,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                            article.thumbnail!,
                            height: 200.h,
                            width: ScreenUtil().screenWidth,
                            fit: BoxFit.cover,
                          )),
                  SizedBox(
                    height: 12.h,
                  ),
                  Text(
                    article.title!,
                    maxLines: 2,
                    style: GoogleFonts.nunito(
                      textStyle: TextStyle(
                        fontSize: 24.sp,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    article.description!.split('</a>').last,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    softWrap: false,
                    style: GoogleFonts.nunito(
                      textStyle: TextStyle(
                        fontSize: 19.sp,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    getTime(article.pubDate!)!,
                    style: GoogleFonts.nunito(
                      textStyle: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.black38,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }

  String? getTime(String time) {
    int pubDate = DateTime.parse(time).millisecondsSinceEpoch;
    int frowPubDateToNow = DateTime.now().millisecondsSinceEpoch - pubDate;
    return (frowPubDateToNow <= 86400000 && frowPubDateToNow >= 3600000)
        ? (frowPubDateToNow / 3600000).ceil().toString() + ' giờ trước'
        : (frowPubDateToNow < 3600000 && frowPubDateToNow >= 60000)
            ? '${frowPubDateToNow / 60000} phút trước'
            : frowPubDateToNow < 60000
                ? 'Vừa cập nhật'
                : DateFormat('dd-MM-yyyy').format(DateTime.parse(time));
  }
}
