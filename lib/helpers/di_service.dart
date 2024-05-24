import 'package:get/instance_manager.dart';
import 'package:raah_hi_v2/pages/home/controllers/home_controller.dart';
import 'package:raah_hi_v2/pages/splash/controllers/splash_controller.dart';

Future<void> init() async {
  Get.lazyPut(() => SplashController());
  Get.lazyPut(() => HomeController());
}
