import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/Home/Api/Api%20manager.dart';
import 'package:news/Home/Category/TabWidget.dart';
import 'package:news/Home/News/NewsItem.dart';
import 'package:news/Model/newsResponce.dart';
import 'package:news/Model/sourceResponce.dart';
import 'package:news/Mytheme.dart';

class NewsWidget extends StatefulWidget {
  Source source;
  NewsWidget({required this.source});
  static const String routeName = 'categoryDetails';

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Container(
              color: MyTheme.whiteColor

          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: FutureBuilder<NewsResponce?>(
                future: ApiManager.getNewsBySourceId(widget.source.id ?? ''),
                builder: (context,snapshot){

                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: MyTheme.primaryLightColor,
                      ),
                    );
                  }else if(snapshot.hasError){
                    return Column(
                      children: [
                        Text('something wrong'),
                        ElevatedButton(onPressed: (){
                          ApiManager.getNewsBySourceId(widget.source.id ?? '');
                          setState(() {

                          });
                        }, child: Text('Try Again'))
                      ],
                    );
                  }
                  if (snapshot.data?.status != 'ok') {
                    return Column(
                      children: [
                        Text(snapshot.data!.message!),
                        ElevatedButton(
                          onPressed: () {
                            ApiManager.getNewsBySourceId(widget.source.id ?? '');
                            setState(() {});
                          },
                          child: Text('Try Again'),
                        )
                      ],
                    );
                  }
                  var newsList = snapshot.data?.articles ?? [];
                  return ListView.builder(itemBuilder: (context,index){
                    return NewItem(news: newsList[index]);
                  },
                  itemCount: newsList.length,);
                }
            ),
          ),
        ]);
  }
}