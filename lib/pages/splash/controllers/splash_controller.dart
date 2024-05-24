import 'dart:developer';

import 'package:get/get.dart';
import 'package:raah_hi_v2/helpers/routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    log("We are ready");
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAndToNamed(RouteHelper.homeScreen);
    });
  }
}
