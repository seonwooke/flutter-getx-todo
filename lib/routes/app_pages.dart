import 'package:get/get.dart';

import '../pages/pages.dart';
import 'routes.dart';

class AppPages {
  static List<GetPage<dynamic>> pages = [
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
