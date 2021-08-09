import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_news_app/data/models/article.dart';
import 'package:flutter_news_app/data/models/category.dart';

class NewsProvider {
  Future<List<Article>> fetchNews({required Category category}) async {
    List<Article> news = [];
    var url = Uri.parse(category.url);

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['items'].forEach((element) {
        if (element['title'] != null && element['description'] != null) {
          Article article = Article.fromJson(element);
          news.add(article);
        }
      });
    }
    return news;
  }
}
