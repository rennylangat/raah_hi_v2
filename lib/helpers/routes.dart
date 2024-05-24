import 'package:get/get.dart';
import 'package:raah_hi_v2/pages/home/views/home_screen.dart';
import 'package:raah_hi_v2/pages/splash/views/splash_screen.dart';

class RouteHelper {
  static const String splashScreen = '/';
  static const String homeScreen = '/home';

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: homeScreen, page: () => const HomeScreen()),
  ];
}
