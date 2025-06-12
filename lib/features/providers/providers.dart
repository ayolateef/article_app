import 'package:article_app/core/services/api_service.dart';
import 'package:article_app/features/providers/post_provider.dart';
import 'package:article_app/features/providers/theme_provider.dart';
import 'package:provider/provider.dart';



final allProviders = [
  Provider(create: (_) => ApiService()),
  ChangeNotifierProvider(
    create: (context) => PostProvider(apiService: context.read<ApiService>()),
  ),

  ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
  ),
];