import 'package:flutter/material.dart';
import 'package:apiblogs/models/blogPostModel.dart';
import 'package:apiblogs/services/blogService.dart';

class BlogController with ChangeNotifier {
  final BlogService _blogService = BlogService();
  List<BlogPost> _blogs = [];
  int _offset = 0;
  int _limit = 30;
  bool _isLoadingMore = false;
  bool _reachedEnd = false;

  List<BlogPost> get blogs => _blogs;
  bool get isLoadingMore => _isLoadingMore;
  bool get reachedEnd => _reachedEnd;

  Future<void> fetchBlogs() async {
    try {
      final newBlogs = await _blogService.fetchBlogs(_offset, _limit);
      _blogs.addAll(newBlogs);
      _offset += _limit;
      notifyListeners();
    } catch (e) {
      print('Error al buscar blogs: $e');
    }
  }

  Future<void> loadMoreBlogsManually() async {
    if (_isLoadingMore) return;
    try {
      _isLoadingMore = true;
      final newBlogs = await _blogService.fetchBlogs(_offset, _limit);
      if (newBlogs.isEmpty) {
        _reachedEnd = true;
      } else {
        _blogs.addAll(newBlogs);
        _offset += _limit;
      }
    } catch (e) {
      print('Error al cargar más blogs manualmente: $e');
    } finally {
      _isLoadingMore = false;
      notifyListeners();
    }
  }
}
