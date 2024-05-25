import 'package:cached_network_image/cached_network_image.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:raah_hi_v2/pages/contribute/controllers/single_destination_controller.dart';
import 'package:raah_hi_v2/pages/contribute/models/destination_model.dart';
import 'package:raah_hi_v2/utils/app_colors.dart';
import 'package:raah_hi_v2/utils/size_config.dart';
import 'package:raah_hi_v2/utils/text_style.dart';

class SingleDestinatonView extends StatefulWidget {
  const SingleDestinatonView({super.key});

  @override
  State<SingleDestinatonView> createState() => _SingleDestinatonViewState();
}

class _SingleDestinatonViewState extends State<SingleDestinatonView> {
  late final Destination destination;
  @override
  void initState() {
    super.initState();
    destination = Get.arguments[0];
    Get.put(SingleDestinationController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          DestinationHeaderWidget(destination: destination),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 2,
                        children: [
                          Icon(
                            MdiIcons.mapMarker,
                            size: 16,
                            color: Colors.grey,
                          ),
                          Text(
                            destination.location,
                            style: interRegular.copyWith(
                              color: AppColor.hintText,
                              fontSize: getProportionateScreenHeight(10),
                            ),
                          )
                        ]),
                    Text(
                      destination.name,
                      style: TextStyle(
                        fontSize: getProportionateScreenHeight(26),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(8)),
                    ExpandText(
                      destination.description!,
                      maxLines: 4,
                      indicatorIconColor: AppColor.secondary,
                      style: TextStyle(
                          fontSize: getProportionateScreenHeight(12),
                          color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Rating: ${destination.rating}",
                      style: TextStyle(
                        fontSize: getProportionateScreenHeight(16),
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Price: ${destination.rating}",
                      style: TextStyle(
                        fontSize: getProportionateScreenHeight(16),
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Activities: ${destination.firstClimbedDate}",
                      style: TextStyle(
                        fontSize: getProportionateScreenHeight(16),
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Tags: ${destination.altitude}",
                      style: TextStyle(
                        fontSize: getProportionateScreenHeight(16),
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DestinationHeaderWidget extends StatelessWidget {
  const DestinationHeaderWidget({
    super.key,
    required this.destination,
  });

  final Destination destination;

  @override
  Widget build(BuildContext context) {
    return ImageSlideshow(
      height: getProportionateScreenHeight(300),
      width: double.infinity,
      children: destination.images
          .asMap()
          .entries
          .map((e) => Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(destination
                        .images[destination.images.indexOf(e.value)]),
                    fit: BoxFit.cover,
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    AppBar(
                      backgroundColor: Colors.transparent,
                      toolbarHeight: getProportionateScreenHeight(35),
                      elevation: 0,
                      leading: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(2),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Wrap(
                            spacing: 2,
                            alignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Icon(
                                MdiIcons.imageMultiple,
                                color: Colors.white,
                                size: 16,
                              ),
                              Text(
                                "${destination.images.length}",
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}
