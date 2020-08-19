import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/model/article.dart';

class News {
  List<Articles> news = [];

  String apiKey = '421d8f6f0a9b49d9827ac12445e0a01f';

  Future<void> getNews() async {
    String url =
        'https://newsapi.org/v2/everything?domains=wsj.com,nytimes.com&apiKey=$apiKey';

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null) {
          Articles articles = Articles(
            title: element['title'],
            content: element['content'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            description: element['description'],
            publishedAt: DateTime.parse(element['publishedAt']),
          );
          news.add(articles);
        }
      });
    }
  }
}
