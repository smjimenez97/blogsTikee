import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apiblogs/controllers/blogController.dart';
import 'package:apiblogs/views/blogListView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BlogController>(
      create: (_) => BlogController()..fetchBlogs(),
      child: MaterialApp(
        title: 'Blog App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BlogListView(),
      ),
    );
  }
}
