import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData mediaQueryData = const MediaQueryData();
  static double screenWidth = 0;
  static double screenHeight = 0;
  static Orientation orientation = Orientation.portrait;

  void init(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    if (orientation == Orientation.portrait) {
      screenWidth = mediaQueryData.size.width;
      screenHeight = mediaQueryData.size.height;
    } else {
      screenWidth = mediaQueryData.size.height;
      screenHeight = mediaQueryData.size.width;
    }
  }
}

double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  return (inputHeight / 812.0) * screenHeight;
}

double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  return (inputWidth / 375.0) * screenWidth;
}
