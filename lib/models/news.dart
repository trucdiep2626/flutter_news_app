
import 'dart:developer';

import 'package:flutter_news_app/models/article.dart';
import 'package:http/http.dart' as http;
 import 'dart:convert';


class News {



  Future<List<Article>> getNews() async{
    List<Article> news  = [];
    var url = Uri.parse('https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Fvnexpress.net%2Frss%2Ftin-moi-nhat.rss');

    var response = await http.get(url);
//log('99999999999999999999999');
    var jsonData = jsonDecode(response.body);
log(jsonData["items"].runtimeType.toString()+'))))))))))))))))))))))))))');
//log(jsonData.keys.toString());
    //log((jsonData['status'] == 'ok').toString());
    if(jsonData['status'] == 'ok'){
  //    log('99999999999999999999999');
      log(jsonData['items'][0].keys.toString());
     // jsonData['items'].forEach(());
      jsonData['items'].forEach((element){
        log(element['title']);
        log(element['guid']);
        log(element['categories'].runtimeType.toString());
        log(element['description']);
        log(element['enclosure'].runtimeType.toString());
        log(DateTime.parse(element['pubDate']).toString());
        log(element['thumbnail']);
        log(element['author']);
        log(element['link']);
        log(element['content']);
        if(element['title'] != null && element['description'] != null){
          log(news.length.toString()+'555555555555555555555');
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
          log(article.enclosure.toString());
          news.add(article);
          log(news.length.toString()+'555555555555555555555');
        }

      });
    }
    log(news.length.toString()+'555555555555555555555');
    return news;
  }
}