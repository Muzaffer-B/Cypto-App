import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_currency/helper/News.dart';
import 'package:crypto_currency/helper/data.dart';
import 'package:crypto_currency/models/article.dart';
import 'package:crypto_currency/models/categorymodel.dart';
import 'package:flutter/material.dart';

import 'article_view.dart';


class news extends StatefulWidget {
  @override
  _newsState createState() => _newsState();
}

class _newsState extends State<news> {



  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> artciles = new List<ArticleModel>();

  bool _loading = true;

  @override
  void initState() {

    super.initState();
    categories = getCategories();
    getNews();


  }

  getNews() async {
    News newsClasss = News();
    await newsClasss.getNews();
    artciles = newsClasss.news;

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'News',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: _loading
            ? Center(
                child: Container(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black87),
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: <Widget>[
                      /// Categories
                      Container(
                        height: 70,
                        child: ListView.builder(
                            itemCount: categories.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return CategoryTile(
                                imageUrl: categories[index].imageurl,
                                categoryname: categories[index].categoryName,
                              );
                            }),
                      ),

                      /// Blogs
                      Container(
                        padding: EdgeInsets.only(top: 16),
                        child: ListView.builder(
                            itemCount: artciles.length,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return BlogTile(
                                  imageurl: artciles[index].urlToImage,
                                  title: artciles[index].title,
                                  description: artciles[index].description,
                                  url: artciles[index].url);
                            }),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final imageUrl, categoryname;
  CategoryTile({this.imageUrl, this.categoryname});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: 120,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 120,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),
              child: Text(
                categoryname,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageurl, title, description,url;
  BlogTile(
      {@required this.imageurl,
      @required this.title,
      @required this.description,
      @required this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ArticleView(
             blogUrl: url,

            )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(imageurl),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
