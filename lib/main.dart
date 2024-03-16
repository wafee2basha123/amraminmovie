import 'package:flutter/material.dart';
import 'Screens/CategoryScreen.dart';
import 'Screens/SearchScreen.dart';
import 'Screens/WatchListScreen.dart';
import 'Screens/homeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        SearchScreen.routeName: (context) => SearchScreen(),
        CategoryScreen.routeName: (context) => CategoryScreen(),
        WatchListScreen.routeName: (context) => WatchListScreen(),

      },
    );
  }
}