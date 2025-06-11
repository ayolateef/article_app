import 'package:article_app/core/models/comments.dart';
import 'package:article_app/core/models/posts.dart';
import 'package:article_app/core/respositories/post-repo.dart';
import 'package:flutter/material.dart';

import '../../core/services/api_service.dart';



class PostProvider extends ChangeNotifier {
  final ApiService apiService;
  List<Post> posts = [];
  List<Post> filteredPosts = [];
  List<Comment> comments = [];
  bool isLoading = false;
  String? error;
  String searchQuery = '';

  PostProvider({required this.apiService}) {
    fetchPosts(); // Fetch posts on initialization
  }

  Future<void> fetchPosts() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      posts = await apiService.fetchPosts();
      filteredPosts = posts;
      print('Posts loaded in provider: ${posts.length}'); // Debug log
    } catch (e) {
      error = 'Failed to load posts: $e';
      print('Error in provider: $error'); // Debug log
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchComments(int postId) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      comments = await apiService.fetchComments(postId);
      print('Comments loaded in provider: ${comments.length}'); // Debug log
    } catch (e) {
      error = 'Failed to load comments: $e';
      print('Error in provider: $error'); // Debug log
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void filterPosts(String query) {
    searchQuery = query;
    if (query.isEmpty) {
      filteredPosts = posts;
    } else {
      filteredPosts = posts
          .where((post) => post.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}