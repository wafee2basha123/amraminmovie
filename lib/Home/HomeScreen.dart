import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/Home/Category/CategoryDetails.dart';
import 'package:news/Home/Category/CategoryFragment.dart';
import 'package:news/Home/Settings.dart';
import 'package:news/Model/Category.dart';
import 'package:news/Mytheme.dart';
import 'package:news/Search.dart';

import 'News/Drawer.dart';

class HomeScreen extends StatefulWidget {

  static const String routeName = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: MyTheme.whiteColor,
          child: Image.asset('assets/images/back.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
            backgroundColor: Colors.white70,
            appBar: AppBar(
              title: Text(
                selectedMenuItem == HomeDrawer.settings
                    ? 'Setting'
                    : selectedCategory == null
                    ? 'News App'
                    : selectedCategory!.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    showSearch(context: context, delegate: SearchIc());
                  }

                ),
              ],
            ),
            drawer: Drawer(
              child: HomeDrawer(onSideMenuClick: onSideMenuClick,),
            ),
            body: selectedMenuItem == HomeDrawer.settings ?
            SettingTab() :
            selectedCategory == null ?
            CategoryFragment(onCategoryItemClink: onCategoryItemClick ,) :
            CategoryDetails(category: selectedCategory!)
        ),
      ],
    );
  }

  CategoryDM? selectedCategory;

  // bysgl fih el user e5taro
  void onCategoryItemClick(CategoryDM  newSelectedCategory ) {
    selectedCategory = newSelectedCategory;
    setState(() {
    });

  }

  int selectedMenuItem = HomeDrawer.categories;

  void onSideMenuClick(int newSelectedMenu) {
    selectedMenuItem = newSelectedMenu;
    selectedCategory = null;
    Navigator.pop(context);
    setState(() {
    });

  }

}
