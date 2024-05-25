import 'package:get/get.dart';
import 'package:raah_hi_v2/pages/contribute/views/explore_screen.dart';
import 'package:raah_hi_v2/pages/contribute/views/single_destination_view.dart';
import 'package:raah_hi_v2/pages/home/views/home_screen.dart';
import 'package:raah_hi_v2/pages/splash/views/splash_screen.dart';

class RouteHelper {
  static const String splashScreen = '/';
  static const String homeScreen = '/home';
  static const String exploreScreen = '/explore';
  static const String singleDestinationView = '/single-destination';

  static List<GetPage> routes = [
    GetPage(
      name: splashScreen,
      page: () => const SplashScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(name: homeScreen, page: () => const HomeScreen()),
    GetPage(name: exploreScreen, page: () => const ExploreScreen()),
    GetPage(
        name: singleDestinationView,
        page: () => const SingleDestinatonView(),
        transition: Transition.zoom),
  ];
}
