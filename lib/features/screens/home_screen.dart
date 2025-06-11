
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../routes.dart';
import '../providers/post_provider.dart';
import '../widgets/post_cart.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        backgroundColor: AppColors.primary,
        title: Text(
          'Articles',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isSearchVisible ? Icons.close : Icons.search,
              color: Colors.white,
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
      backgroundColor: AppColors.white,
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
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.accent,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      size: 20.sp,
                      color: AppColors.accent,
                    ),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                      icon: Icon(
                        Icons.clear,
                        size: 20.sp,
                        color: AppColors.accent,
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
                    fillColor: Colors.white,
                  ),
                  style: TextStyle(fontSize: 14.sp),
                  onChanged: postProvider.filterPosts,
                ),
              ),
            ).animate().slideY(begin: -1, end: 0)
                : const SizedBox.shrink(),
          ),
          Expanded(
            child: RefreshIndicator(
              color: AppColors.primary,
              onRefresh: postProvider.fetchPosts,
              child: postProvider.isLoading
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Loading...',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.accent,
                      ),
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
                      color: AppColors.error,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Error: ${postProvider.error}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.error,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 12.h,
                        ),
                      ),
                      onPressed: postProvider.fetchPosts,
                      child: Text(
                        'Retry',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                  ],
                ),
              )
                  : postProvider.filteredPosts.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.sentiment_dissatisfied,
                      size: 40.sp,
                      color: AppColors.accent,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'No posts found',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.accent,
                      ),
                    ),
                  ],
                ),
              )
                  : ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                itemCount: postProvider.filteredPosts.length,
                itemBuilder: (context, index) {
                  final post = postProvider.filteredPosts[index];
                  return PostCard(
                    post: post,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.detail,
                        arguments: post,
                      );
                    },
                  ).animate()
                      .fadeIn(
                    delay: Duration(milliseconds: 100 * index),
                    duration: const Duration(milliseconds: 300),
                  )
                      .slideY(
                    begin: 0.2,
                    end: 0,
                    duration: const Duration(milliseconds: 300),
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