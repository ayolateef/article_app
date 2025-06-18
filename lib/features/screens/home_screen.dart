import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../routes.dart';
import '../providers/post_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/post_cart.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  bool _isSearchVisible = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Articles',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              context.watch<ThemeProvider>().isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () => context.read<ThemeProvider>().toggleTheme(),
          ),
          IconButton(
            icon: Icon(
              _isSearchVisible ? Icons.close : Icons.search,
            ),
            onPressed: () {
              setState(() {
                _isSearchVisible = !_isSearchVisible;
                if (!_isSearchVisible) {
                  _searchController.clear();
                  postProvider.filterPosts('');
                }
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: _isSearchVisible ? 64.h : 0,
            child: _isSearchVisible
                ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search by title...',
                    hintStyle: Theme.of(context).textTheme.bodyMedium,
                    prefixIcon: Icon(
                      Icons.search,
                      size: 20.sp,
                    ),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                      icon: Icon(
                        Icons.clear,
                        size: 20.sp,
                      ),
                      onPressed: () {
                        _searchController.clear();
                        postProvider.filterPosts('');
                      },
                    )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                  ),
                  style: Theme.of(context).textTheme.bodyMedium,
                  onChanged: postProvider.filterPosts,
                ),
              ),
            ).animate().slideY(begin: -1, end: 0)
                : const SizedBox.shrink(),
          ),
          Expanded(
            child: RefreshIndicator(
              color: Theme.of(context).colorScheme.primary,
              onRefresh: postProvider.fetchPosts,
              child: postProvider.isLoading
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Loading...',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              )
                  : postProvider.error != null
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 40.sp,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Error: ${postProvider.error}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      onPressed: postProvider.fetchPosts,
                      child: Text(
                        'Retry',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                  ],
                ),
              )
                  : postProvider.posts.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.sentiment_dissatisfied,
                      size: 40.sp,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'No posts found',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              )
                  : ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                itemCount: postProvider.filteredPosts.length,
                itemBuilder: (context, index) {
                  final post = postProvider.filteredPosts[index];

                  return Animate(
                    effects: [
                      FadeEffect(
                        delay: Duration(milliseconds: 100 * index),
                        duration: const Duration(milliseconds: 300),
                      ),
                      const SlideEffect(
                        begin: Offset(0, 0.2),
                        end: Offset.zero,
                        duration: Duration(milliseconds: 300),
                      ),
                    ],
                    child: PostCard(
                      post: post,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.detail,
                          arguments: post,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}