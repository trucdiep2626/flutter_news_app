import 'package:flutter_news_app/data/models/article.dart';
import 'package:flutter_news_app/data/models/category.dart';
import 'package:flutter_news_app/data/providers/news_provider.dart';

class NewsRepository {
  NewsProvider _newsProvider = NewsProvider();

  Future<List<Article>> fetchNews({required Category category}) async {
    return await _newsProvider.fetchNews(category: category);
  }
}
