import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:raah_hi_v2/helpers/di_service.dart' as di_service;
import 'package:raah_hi_v2/helpers/routes.dart';

void main() async {
  await di_service.init();
  runApp(const RaahHi());
}

class RaahHi extends StatelessWidget {
  const RaahHi({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Raa-Hi App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      navigatorKey: Get.key,
      defaultTransition: Transition.fadeIn,
      getPages: RouteHelper.routes,
      initialRoute: RouteHelper.splashScreen,
    );
  }
}