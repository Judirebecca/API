
import 'package:flutter/material.dart';

import 'Helpers/AppNavigations/NavigationConfig.dart';
import 'Helpers/AppNavigations/NavigationHelpers.dart';

// Create a class App that extends the stateless widget
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      // to map the initial route set the firstpageconfig and the initial page and the page data is set tp empty string
      onGenerateRoute: AppRoute(
        initialPage: Pages.FirstPageConfig,
        initialPageData: "",
      ).onGenerateRoute,
      theme: ThemeData(useMaterial3: true),
    );
  }
}