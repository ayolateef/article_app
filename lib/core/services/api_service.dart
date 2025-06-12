import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:async';

import '../models/comments.dart';
import '../models/posts.dart';


class ApiService {
  final String primaryBaseUrl = 'https://jsonplaceholder.typicode.com';
  final String fallbackBaseUrl = 'https://dummyjson.com';

  // Common headers for requests
  final Map<String, String> _headers = {
    'User-Agent': 'ArticleApp/1.0 (Flutter; ${Platform.isAndroid ? 'Android' : 'iOS'})',
    'Accept': 'application/json',
  };

  Future<List<Post>> fetchPosts() async {
    try {
      final response = await http
          .get(Uri.parse('$primaryBaseUrl/posts'), headers: _headers)
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        print('Posts fetched from jsonplaceholder: ${data.length} items');
        return data.map((json) => Post.fromJson(json)).toList();
      } else {
        print('Primary API failed: ${response.statusCode} ${response.reasonPhrase}');
        // Fallback to dummyjson API
        final fallbackResponse = await http
            .get(Uri.parse('$fallbackBaseUrl/posts'), headers: _headers)
            .timeout(const Duration(seconds: 10));
        if (fallbackResponse.statusCode == 200) {
          final Map<String, dynamic> data = jsonDecode(fallbackResponse.body);
          final List<dynamic> posts = data['posts'] ?? [];
          print('Posts fetched from dummyjson: ${posts.length} items');
          return posts.map((json) => Post.fromJson(json)).toList();
        } else {
          throw Exception('Fallback API failed: ${fallbackResponse.statusCode} ${fallbackResponse.reasonPhrase}');
        }
      }
    } on SocketException catch (e) {
      print('SocketException fetching posts: $e');
      throw Exception('Connection error: $e');
    } on TimeoutException catch (e) {
      print('TimeoutException fetching posts: $e');
      throw Exception('Request timed out: $e');
    } on http.ClientException catch (e) {
      print('ClientException fetching posts: $e');
      throw Exception('Network error: $e');
    }
  }

  Future<List<Comment>> fetchComments(int postId) async {
    try {
      final response = await http
          .get(Uri.parse('$primaryBaseUrl/comments?postId=$postId'), headers: _headers)
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        print('Comments fetched from jsonplaceholder for post $postId: ${data.length} items');
        return data.map((json) => Comment.fromJson(json)).toList();
      } else {
        print('Primary comments API failed: ${response.statusCode} ${response.reasonPhrase}');
        // Fallback to dummyjson comments API
        final fallbackResponse = await http
            .get(Uri.parse('$fallbackBaseUrl/comments'), headers: _headers)
            .timeout(const Duration(seconds: 10));
        if (fallbackResponse.statusCode == 200) {
          final Map<String, dynamic> data = jsonDecode(fallbackResponse.body);
          final List<dynamic> comments = data['comments'] ?? [];
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
    } on SocketException catch (e) {
      print('SocketException fetching comments: $e');
      throw Exception('Connection error: $e');
    } on TimeoutException catch (e) {
      print('TimeoutException fetching comments: $e');
      throw Exception('Request timed out: $e');
    } on http.ClientException catch (e) {
      print('ClientException fetching comments: $e');
      throw Exception('Network error: $e');
    }
  }
}