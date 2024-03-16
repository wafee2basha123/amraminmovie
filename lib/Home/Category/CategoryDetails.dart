import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/Home/Api/Api%20manager.dart';
import 'package:news/Home/Category/TabWidget.dart';
import 'package:news/Model/Category.dart';
import 'package:news/Model/sourceResponce.dart';
import 'package:news/Mytheme.dart';

class CategoryDetails extends StatefulWidget {

  static const String routeName = 'categoryDetails';
  CategoryDM category;
  CategoryDetails({required this.category});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Container(
            color: MyTheme.whiteColor

          ),
          Scaffold(
            backgroundColor: Colors.transparent,

            body: FutureBuilder<SourceResponce?>(
                future: ApiManager.getSources(widget.category.id),
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
                          ApiManager.getSources(widget.category.id);
                          setState(() {

                          });
                        }, child: Text('Try Again'))
                      ],
                    );
                  }
                  if(snapshot.data?.status != 'ok'){
                    return Column(
                      children: [
                        Text(snapshot.data!.message! ),
                        ElevatedButton(onPressed: (){
                          ApiManager.getSources(widget.category.id);
                          setState(() {

                          });
                        }, child: Text('Try Again'))
                      ],
                    );
                  }
                  var sourcesList = snapshot.data?.sources ?? [];
                  return TabWidget(sourceList: sourcesList);
                }
            ),
          ),
        ]);
  }
}