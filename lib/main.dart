import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:newsreader/Model/model.dart';

String apiKey = '4576561238fe403fb04784dcdb55634b';
Future<List<Article>> fetchNewsArticle() async {
  final response = await http.get('http://newsapi.org/v2/top-headlines?country=br&apiKey='+apiKey);
  
  if (response.statusCode == 200) {

    List articles = json.decode(response.body)['articles'];
    return articles.map((article) => new Article.fromJson(article)).toList();
  } else {

    throw Exception("Failed to load article list");
  }
}

void main() => runApp(new ArticleScreen());

class ArticleScreen extends StatefulWidget 
{

  @override
  State<StatefulWidget> createState() => ArticleScreenState();

}

class ArticleScreenState extends State<ArticleScreen>
{
  var listArticles;
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() { 
    super.initState();
    refreshListArticle();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'F5 Notícias',
      theme: ThemeData(primarySwatch: Colors.red),
      home: Scaffold(
        appBar: AppBar(title: Text('F5 Notícias'),),
        body: Center(
          child: RefreshIndicator(
            key: refreshKey,
            child: FutureBuilder<List<Article>>(
              future: listArticles,
              builder: (context, snapshot){
                if(snapshot.hasError) {
                  return Text('Erro: ${snapshot.error}');
                } else if(snapshot.hasData) {
                  List<Article> articles = snapshot.data;
                  return new ListView(
                    children: articles.map((article) => GestureDetector(
                      onTap: (){

                      },
                      child: Card(
                        elevation: 1.0,
                        color: Colors.white,
                        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 2.0),
                              width: 100.0,
                              height: 140.0,
                              child: Image.asset("assets/news.png"),
                            ),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          margin: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                                          child: Text('${article.source.name}', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
                                        ),
                                      )
                                    ],
                                  ),

                                  Container(
                                    child: Text('${article.description}', style: TextStyle(color: Colors.grey, fontSize: 12.0, fontWeight: FontWeight.bold),),
                                  ),

                                  Container(
                                    child: Text('Autor: ${article.author}', style: TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )).toList());
                }

                return CircularProgressIndicator();
              },
            ),
            onRefresh: refreshListArticle),
        )
      )
    );
  }

  Future<Null> refreshListArticle() async {
    refreshKey.currentState?.show(atTop: false);

    setState(() {
      listArticles = fetchNewsArticle();
    });

    return null;
  }
}
