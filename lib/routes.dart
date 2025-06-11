import 'package:article_app/core/models/posts.dart';
import 'package:article_app/features/screens/detail_screen.dart';
import 'package:article_app/features/screens/home_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String home = '/home';
  static const String detail = '/detail';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case detail:
        final post = settings.arguments as Post;
        return MaterialPageRoute(
          builder: (_) => DetailScreen(post: post),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
    }
  }
}