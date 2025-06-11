import 'package:article_app/core/respositories/post-repo.dart';
import 'package:article_app/core/services/api_service.dart';
import 'package:article_app/features/providers/post_provider.dart';
import 'package:provider/provider.dart';

// final allProviders = [
//   Provider(create: (_) => ApiService()),
//   ProxyProvider<ApiService, PostRepository>(
//     update: (_, apiService, __) => PostRepository(apiService: apiService),
//   ),
//   ChangeNotifierProvider(
//     create: (context) => PostProvider(
//       postRepository: context.read<PostRepository>(),
//     ),
//   ),
// ];

final allProviders = [
  Provider(create: (_) => ApiService()),
  ChangeNotifierProvider(
    create: (context) => PostProvider(apiService: context.read<ApiService>()),
  ),
];