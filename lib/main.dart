import 'package:article_app/core/constants/nav_key.dart';
import 'package:article_app/core/services/app_init_services.dart';
import 'package:article_app/features/providers/providers.dart';
import 'package:article_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'core/constants/app_theme.dart';
import 'features/providers/theme_provider.dart';

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
          return Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) => MaterialApp(
              title: 'Article App',
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
              navigatorKey: NavKey.appNavKey,
              onGenerateRoute: Routes.onGenerateRoute,
              initialRoute: Routes.home,
            ),
          );
        },
      ),
    );
  }
}