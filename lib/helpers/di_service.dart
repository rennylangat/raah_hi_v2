import 'package:get/instance_manager.dart';
import 'package:raah_hi_v2/pages/contribute/controllers/create_contribution_controller.dart';
import 'package:raah_hi_v2/pages/contribute/controllers/explore_controller.dart';
import 'package:raah_hi_v2/pages/contribute/controllers/single_destination_controller.dart';
import 'package:raah_hi_v2/pages/home/controllers/home_controller.dart';
import 'package:raah_hi_v2/pages/splash/controllers/splash_controller.dart';

Future<void> init() async {
  Get.lazyPut(() => SplashController());
  Get.lazyPut(() => HomeController());
  Get.lazyPut(() => ExploreController());
  Get.lazyPut(() => SingleDestinationController());
  Get.lazyPut(() => CreateContributionController());
}
