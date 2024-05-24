import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:raah_hi_v2/helpers/routes.dart';
import 'package:raah_hi_v2/utils/app_colors.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  const BottomNavBar({super.key, required this.currentIndex});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  var bottomNavBarIndex = 0;

  @override
  void initState() {
    super.initState();
    bottomNavBarIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DotNavigationBar(
        currentIndex: bottomNavBarIndex,
        margin: const EdgeInsets.only(left: 10, right: 10),
        marginR: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        paddingR: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        dotIndicatorColor: Colors.white,
        unselectedItemColor: Colors.grey[100],
        splashBorderRadius: 50,
        onTap: onNavTapped,
        backgroundColor: AppColor.primary,
        items: [
          DotNavigationBarItem(
            icon: Icon(MdiIcons.home),
            selectedColor: AppColor.secondaryDark,
          ),
          DotNavigationBarItem(
            icon: Icon(MdiIcons.viewGridOutline),
            selectedColor: AppColor.secondaryDark,
          ),
          DotNavigationBarItem(
            icon: Icon(MdiIcons.starOutline),
            selectedColor: AppColor.secondaryDark,
          ),
          DotNavigationBarItem(
            icon: Icon(MdiIcons.accountCircleOutline),
            selectedColor: AppColor.secondaryDark,
          ),
        ],
      ),
    );
  }

  void onNavTapped(int index) {
    setState(() {
      bottomNavBarIndex = index;
    });

    switch (index) {
      case 0:
        if (!(widget.currentIndex == 0)) {
          Get.offAndToNamed(RouteHelper.homeScreen);
        }
        break;
      case 1:
        if (!(widget.currentIndex == 1)) {
          Get.offAndToNamed(RouteHelper.exploreScreen);
        }
        break;

      case 2:
        break;

      case 3:
        break;
    }
  }
}
