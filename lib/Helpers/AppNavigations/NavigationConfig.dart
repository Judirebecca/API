// ignore_for_file: constant_identifier_names, file_names, non_constant_identifier_names



import '../../Pages/FirstPage/FirstPage.dart';
import 'NavigationHelpers.dart';

// Declare the Routes as Enum
enum Routes {
  FirstPage,
}

// Create class named Pages which holds the pages in the application 
class Pages{ 
   
  // In the FirstPageConfig set the FirstPage as route and pass the data of firstpageconfig to the parameter extraData
  static final PageConfig FirstPageConfig = PageConfig(route: Routes.FirstPage , build: (_) => FirstPage(extraData: FirstPageConfig.data,));
}