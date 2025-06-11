import 'package:article_app/core/constants/app_colors.dart';
import 'package:article_app/core/constants/nav_key.dart';
import 'package:article_app/core/services/app_init_services.dart';
import 'package:article_app/features/providers/providers.dart';
import 'package:article_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppInitService().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: allProviders,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) {
          return MaterialApp(
            title: 'Article App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
              scaffoldBackgroundColor: AppColors.white,
              fontFamily: 'Inter',
              useMaterial3: true,
            ),
            navigatorKey: NavKey.appNavKey,
            onGenerateRoute: Routes.onGenerateRoute,
            initialRoute: Routes.home,
          );
        },
      ),
    );
  }
}