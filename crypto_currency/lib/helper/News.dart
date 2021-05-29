import 'dart:convert';

import 'package:crypto_currency/models/article.dart';
import 'package:http/http.dart' as http;

class News{

  List<ArticleModel> news = [];

  Future<void> getNews() async{
    String url = "https://newsapi.org/v2/top-headlines?country=tr&category=business&apiKey=46cbb489b18043d4baf637dacb923393";

    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == 'ok'){
      jsonData["articles"].forEach((element){

        if(element["urlToImage"] != null && element["description"] != null){

         ArticleModel articlemodel = ArticleModel(
            title: element['title'],
             author: element['author'],
           description: element['description'],
           url: element['url'],
           urlToImage: element['urlToImage'],
           content: element['content'],
         );

         news.add(articlemodel);
        }

      });
    }
  }

}