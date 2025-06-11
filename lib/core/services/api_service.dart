import 'package:article_app/core/models/comments.dart';
import 'package:article_app/core/models/posts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class ApiService {
  final String primaryBaseUrl = 'https://jsonplaceholder.typicode.com';
  final String fallbackBaseUrl = 'https://dummyjson.com';

  Future<List<Post>> fetchPosts() async {
    try {
      final response = await http.get(Uri.parse('$primaryBaseUrl/posts'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        print('Posts fetched from jsonplaceholder: ${data.length} items');
        return data.map((json) => Post.fromJson(json)).toList();
      } else {
        print('Primary API failed: ${response.statusCode} ${response.reasonPhrase}');
        // Fallback to dummyjson API
        final fallbackResponse = await http.get(Uri.parse('$fallbackBaseUrl/posts'));
        if (fallbackResponse.statusCode == 200) {
          final Map<String, dynamic> data = jsonDecode(fallbackResponse.body);
          final List<dynamic> posts = data['posts'] ?? [];
          print('Posts fetched from dummyjson: ${posts.length} items');
          return posts.map((json) => Post.fromJson(json)).toList();
        } else {
          throw Exception('Fallback API failed: ${fallbackResponse.statusCode} ${fallbackResponse.reasonPhrase}');
        }
      }
    } catch (e) {
      print('Error fetching posts: $e');
      rethrow;
    }
  }

  Future<List<Comment>> fetchComments(int postId) async {
    try {
      final response = await http.get(Uri.parse('$primaryBaseUrl/comments?postId=$postId'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        print('Comments fetched from jsonplaceholder for post $postId: ${data.length} items');
        return data.map((json) => Comment.fromJson(json)).toList();
      } else {
        print('Primary comments API failed: ${response.statusCode} ${response.reasonPhrase}');
        // Fallback to dummyjson comments API
        final fallbackResponse = await http.get(Uri.parse('$fallbackBaseUrl/comments'));
        if (fallbackResponse.statusCode == 200) {
          final Map<String, dynamic> data = jsonDecode(fallbackResponse.body);
          final List<dynamic> comments = data['comments'] ?? [];
          // Filter comments by postId client-side
          final filteredComments = comments
              .where((json) => json['postId'] == postId)
              .map((json) => Comment.fromJson(json))
              .toList();
          print('Comments fetched from dummyjson for post $postId: ${filteredComments.length} items');
          return filteredComments;
        } else {
          throw Exception('Fallback comments API failed: ${fallbackResponse.statusCode} ${fallbackResponse.reasonPhrase}');
        }
      }
    } catch (e) {
      print('Error fetching comments: $e');
      rethrow;
    }
  }
}