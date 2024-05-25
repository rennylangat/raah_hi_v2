import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:raah_hi_v2/helpers/routes.dart';
import 'package:raah_hi_v2/pages/contribute/controllers/explore_controller.dart';
import 'package:raah_hi_v2/pages/contribute/models/destination_model.dart';
import 'package:raah_hi_v2/utils/app_colors.dart';
import 'package:raah_hi_v2/utils/constants.dart';
import 'package:raah_hi_v2/utils/size_config.dart';
import 'package:raah_hi_v2/utils/text_style.dart';
import 'package:raah_hi_v2/widgets/bottom_nav.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  void initState() {
    super.initState();
    Get.put(ExploreController());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExploreController>(builder: (controller) {
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
                      height: getProportionateScreenHeight(200),
                      width: SizeConfig.screenWidth,
                      child: ListView.builder(
                        itemCount: controller.recommended.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return RecommendCard(
                            index: index,
                            destination: controller.recommended[index],
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
    });
  }
}

class RecommendCard extends StatelessWidget {
  final int index;
  final Destination destination;
  const RecommendCard({
    super.key,
    required this.index,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(
          RouteHelper.singleDestinationView,
          arguments: [destination],
        );
      },
      splashColor: AppColor.primary.withOpacity(0.07),
      radius: SizeConfig.screenHeight * 0.2,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        width: SizeConfig.screenWidth * 0.6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: SizeConfig.screenWidth * 0.6,
              height: getProportionateScreenHeight(140),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    destination.images.first,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 10,
                    top: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4.0, vertical: 3.0),
                      child: Wrap(
                        spacing: 2,
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Icon(
                            MdiIcons.star,
                            color: Colors.white,
                            size: 16,
                          ),
                          Text(
                            "${destination.rating}",
                            style: interRegular.copyWith(
                              color: Colors.white,
                              fontSize: getProportionateScreenHeight(10),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: Container(
                      width: getProportionateScreenWidth(20),
                      height: getProportionateScreenHeight(20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.4),
                      ),
                      padding: const EdgeInsets.all(3.0),
                      child: Icon(
                        destination.starred ? Icons.star : Icons.star_border,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(8),
            ),
            Expanded(
              child: Text(
                destination.name,
                style: interBold.copyWith(
                  fontSize: getProportionateScreenHeight(13),
                ),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(4),
            ),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Icon(
                  MdiIcons.mapMarker,
                  color: AppColor.hintText,
                  size: 16,
                ),
                Text(
                  destination.location,
                  style: interRegular.copyWith(
                    color: AppColor.hintText,
                    fontSize: getProportionateScreenHeight(10),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
