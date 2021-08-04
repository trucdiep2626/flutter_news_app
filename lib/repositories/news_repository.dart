
import 'dart:developer';

import 'package:flutter_news_app/models/article.dart';
import 'package:flutter_news_app/models/category.dart';
import 'package:http/http.dart' as http;
 import 'dart:convert';


class NewsRepository {


  Future<List<Article>> getNews({required Category category}) async{
    List<Article> news  = [];
    var url = Uri.parse(category.url);

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == 'ok'){
      jsonData['items'].forEach((element){
       // log(element['title']);
       // log(element['guid']);
      //  log(element['categories'].runtimeType.toString());
       // log(element['description']);
       // log(element['enclosure'].runtimeType.toString());
       // log(DateTime.parse(element['pubDate']).toString());
      //  log(element['thumbnail']);
      //  log(element['author']);
      // log(element['link']);
       // log(element['content']);
        if(element['title'] != null && element['description'] != null){
         // log(news.length.toString()+'555555555555555555555');
          Article article = Article(
            title: element['title'],
            guid: element['guid'],
            categories: element['categories']??null,
            author: element['author'],
            description: element['description'],
            link: element['link'],
            pubDate: DateTime.parse(element['pubDate']).toString(),
            content: element['content'],
            enclosure: element['enclosure']??null,
            thumbnail: element['thumbnail'],
          );
       //   log(article.enclosure.toString());
          news.add(article);
        //  log(news.length.toString()+'555555555555555555555');
        }

      });
    }
   // log(news.length.toString()+'555555555555555555555');
    return news;
  }
}