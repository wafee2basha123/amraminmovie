import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news/Model/newsResponce.dart';

import 'newsArticle.dart';

class NewItem extends StatelessWidget {
  final Articles news;

  NewItem({required this.news});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsArticle(news: news),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: CachedNetworkImage(
                imageUrl: news.urlToImage ?? '',
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.28,
                fit: BoxFit.fill,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            SizedBox(height: 10),
            Text(
              news.author ?? '',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 10),
            Text(
              news.title ?? '',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              news.publishedAt ?? '',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.end,
            ),
          ],
        ),
      ),
    );
  }
}
