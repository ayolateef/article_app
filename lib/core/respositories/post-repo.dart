
import 'package:article_app/core/models/comments.dart';
import 'package:article_app/core/models/posts.dart';

import '../services/api_service.dart';

class PostRepository {
  final ApiService apiService;

  PostRepository({required this.apiService});

  Future<List<Post>> getPosts() async {
    return await apiService.fetchPosts();
  }

  Future<List<Comment>> getComments(int postId) async {
    return await apiService.fetchComments(postId);
  }
}