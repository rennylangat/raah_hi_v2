import 'package:flutter/material.dart';
import 'package:raah_hi_v2/utils/app_colors.dart';
import 'package:raah_hi_v2/utils/constants.dart';
import 'package:raah_hi_v2/utils/size_config.dart';
import 'package:raah_hi_v2/utils/text_style.dart';
import 'package:raah_hi_v2/widgets/bottom_nav.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(
        currentIndex: 1,
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: AppColor.primary,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add_circle_outline,
              color: AppColor.primary,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: SizeConfig.screenHeight,
                minHeight: SizeConfig.screenHeight,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Explore",
                    style: interBold.copyWith(
                      fontSize: getProportionateScreenHeight(20),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  Text(
                    "We hope you can find what you came for",
                    style: interRegular.copyWith(
                      color: AppColor.hintText,
                      fontSize: getProportionateScreenHeight(12),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(50),
                  ),
                  Row(
                    children: [
                      Text(
                        "Category",
                        style: interBold.copyWith(
                          fontSize: getProportionateScreenHeight(16),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "View All",
                        style: interRegular.copyWith(
                          color: AppColor.primary,
                          fontSize: getProportionateScreenHeight(12),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(15),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(80),
                    width: SizeConfig.screenWidth,
                    child: ListView.builder(
                      itemCount: categoriesList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: AppColor.secondaryLight,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(10),
                          width: getProportionateScreenWidth(105),
                          margin: const EdgeInsets.only(right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                categoriesList[index]["icon"],
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(20),
                              ),
                              Text(
                                "${categoriesList[index]["title"]}",
                                style: interRegular.copyWith(
                                  color: Colors.white,
                                  fontSize: getProportionateScreenHeight(12),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  Row(
                    children: [
                      Text(
                        "Recommended",
                        style: interBold.copyWith(
                          fontSize: getProportionateScreenHeight(16),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "View All",
                        style: interRegular.copyWith(
                          color: AppColor.primary,
                          fontSize: getProportionateScreenHeight(12),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(100),
                    width: SizeConfig.screenWidth,
                    child: ListView.builder(
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: const BoxDecoration(),
                          child: const Column(
                            children: [],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
