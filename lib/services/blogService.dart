import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:apiblogs/models/blogPostModel.dart';

class BlogService {
  final String apiUrl =
      'https://api.slingacademy.com/v1/sample-data/blog-posts';

  Future<List<BlogPost>> fetchBlogs(int offset, int limit) async {
    try {
      final response =
          await http.get(Uri.parse('$apiUrl?offset=$offset&limit=$limit'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['blogs'];
        return data.map((json) => BlogPost.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load blogs: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load blogs: $e');
    }
  }
}
