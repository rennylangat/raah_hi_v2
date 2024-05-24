import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:raah_hi_v2/pages/splash/controllers/splash_controller.dart';
import 'package:raah_hi_v2/utils/size_config.dart';
import 'package:simple_animations/animation_builder/play_animation_builder.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GetBuilder<SplashController>(
      builder: (context) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  PlayAnimationBuilder(
                      tween: Tween<double>(begin: 0, end: 200),
                      duration: const Duration(milliseconds: 2500),
                      curve: Curves.easeOut,
                      builder: (context, value, child) {
                        return ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: SizeConfig.screenHeight * 0.9,
                            minHeight: SizeConfig.screenHeight * 0.5,
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'assets/images/playstore.png',
                                  width: value,
                                  height: value,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
