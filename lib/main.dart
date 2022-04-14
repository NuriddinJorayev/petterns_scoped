import 'package:flutter/material.dart';
import 'package:patterns_scoped/pages/create_post_page.dart';
import 'package:patterns_scoped/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
      routes: {
        Home.id: (context) => Home(),
        Create_post.id: (context) => Create_post(),
      },
    );
  }
}
