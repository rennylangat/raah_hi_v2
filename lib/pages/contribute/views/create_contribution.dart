import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:raah_hi_v2/helpers/routes.dart';
import 'package:raah_hi_v2/pages/contribute/controllers/create_contribution_controller.dart';
import 'package:raah_hi_v2/utils/app_colors.dart';
import 'package:raah_hi_v2/utils/size_config.dart';
import 'package:raah_hi_v2/utils/text_style.dart';
import 'package:raah_hi_v2/widgets/text_box_widget.dart';
import 'package:shimmer/shimmer.dart';

class CreateContribution extends StatefulWidget {
  const CreateContribution({super.key});

  @override
  State<CreateContribution> createState() => _CreateContributionState();
}

class _CreateContributionState extends State<CreateContribution> {
  @override
  void initState() {
    super.initState();
    Get.put(CreateContributionController());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateContributionController>(builder: (controller) {
      return PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          if (didPop) {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              final bool shouldPop = await showSaveDialog(
                  context: context, controller: controller);
              if (context.mounted && shouldPop) {
                Get.back();
              }
            });
          }
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'Create Contribution',
              style: interBold.copyWith(
                fontSize: getProportionateScreenHeight(18),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.check,
                  color: Colors.black,
                ),
              )
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Share a must-see spot with the tribe",
                        style: interMedium.copyWith(
                          fontSize: getProportionateScreenHeight(14),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(15),
                      ),
                      Text(
                        "Place Name (Required)",
                        style: interLight.copyWith(
                          fontSize: getProportionateScreenHeight(8),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(5),
                      ),
                      CustomTextField(
                        hintText: "Enter the place name",
                        controller: controller.placeNameController,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return "Place name is required";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(15),
                      ),
                      Text(
                        "Category (Required)",
                        style: interLight.copyWith(
                          fontSize: getProportionateScreenHeight(8),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(15),
                      ),
                      CustomDropDown(
                        dropdownItems: controller.categories,
                        onChanged: (value) {
                          controller.selectedCategory = value.toString();
                          controller.update();
                        },
                        hintText: "Select Category",
                        selectedValue: controller.selectedCategory,
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(15),
                      ),
                      Text(
                        "Address (Required)",
                        style: interLight.copyWith(
                          fontSize: getProportionateScreenHeight(8),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(15),
                      ),
                      CustomTextField(
                        hintText: "Select Address",
                        controller: controller.addressController,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return "Address is required";
                          }
                          return null;
                        },
                        isShowSuffixIcon: true,
                        suffixWidget: IconButton(
                          icon: Icon(
                            MdiIcons.crosshairsGps,
                            size: 20,
                            color: AppColor.secondary,
                          ),
                          onPressed: () {
                            controller.getCurrLocation();
                          },
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(180),
                        width: SizeConfig.screenWidth,
                        child: controller.fetchLocation
                            ? Shimmer.fromColors(
                                baseColor: AppColor.shimmerBaseColor,
                                highlightColor: AppColor.shimmerSplashColor,
                                child: Container(
                                  color: Colors.white,
                                ),
                              )
                            : Stack(
                                children: [
                                  Positioned(
                                    bottom: 5,
                                    left: 4,
                                    child: GestureDetector(
                                      onTap: () async {
                                        final location = await Get.toNamed(
                                            RouteHelper.gMapView);

                                        log("Result $location");
                                        controller.addressController.text =
                                            location.toString();
                                        controller.update();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.4),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 6),
                                        child: Text(
                                          "Edit map location",
                                          style: interRegular.copyWith(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    child: SizedBox(
                                      height: getProportionateScreenHeight(150),
                                      width: SizeConfig.screenWidth * 0.9,
                                      child: GoogleMap(
                                        mapType: MapType.normal,
                                        initialCameraPosition:
                                            controller.kGooglePlex,
                                        zoomControlsEnabled: true,
                                        zoomGesturesEnabled: true,
                                        myLocationEnabled: true,
                                        myLocationButtonEnabled: true,
                                        onMapCreated: (GoogleMapController
                                            mapsController) {
                                          controller.mapsController
                                              .complete(mapsController);
                                        },
                                        markers: {
                                          controller.marker ??
                                              Marker(
                                                markerId: const MarkerId('1'),
                                                position: controller
                                                    .kGooglePlex.target,
                                              )
                                        },
                                        buildingsEnabled: true,
                                        onTap: (LatLng latLng) {
                                          controller.getAddressFromMarker(
                                              latLng: latLng);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(15),
                      ),
                      const Divider(
                        color: AppColor.utilityOutline,
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(15),
                      ),
                      ExpansionTile(
                        shape: Border.all(
                            color: AppColor.textColor.withOpacity(0.001)),
                        iconColor: AppColor.secondary,
                        title: const Text("Add more details"),
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Pricing"),
                          SizedBox(
                            height: getProportionateScreenHeight(10),
                          ),
                          CustomTextField(
                            hintText: "Enter the pricing if any",
                            controller: controller.contactController,
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(10),
                          ),
                          const Text("Description"),
                          SizedBox(
                            height: getProportionateScreenHeight(5),
                          ),
                          CustomTextField(
                            hintText: "Enter the description",
                            controller: controller.descriptionController,
                            maxLines: 3,
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(15),
                          ),
                          const Text("Media"),
                          SizedBox(
                            height: getProportionateScreenHeight(5),
                          ),
                          GestureDetector(
                            onTap: () async {
                              controller.pickImages();
                            },
                            child: Container(
                              width: getProportionateScreenWidth(120),
                              height: getProportionateScreenHeight(90),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: AppColor.utilityOutline,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    MdiIcons.plus,
                                    size: 32,
                                    color: AppColor.hintText,
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(10),
                                  ),
                                  Text(
                                    "Add Pictures",
                                    style: interRegular.copyWith(
                                      color: AppColor.hintText,
                                      fontSize:
                                          getProportionateScreenHeight(12),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(25),
                          ),
                          Visibility(
                            visible: controller.images.isNotEmpty,
                            child: SizedBox(
                              height: getProportionateScreenHeight(90),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.images.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: getProportionateScreenWidth(80),
                                    height: getProportionateScreenHeight(90),
                                    margin: const EdgeInsets.only(right: 10),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Positioned(
                                          top: -8,
                                          right: -5,
                                          child: IconButton(
                                            onPressed: () {
                                              controller.removeImage(index);
                                            },
                                            icon: Icon(
                                              MdiIcons.closeCircle,
                                              color: Colors.red,
                                              size: 14,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 0,
                                          bottom: 0,
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            width:
                                                getProportionateScreenWidth(70),
                                            height:
                                                getProportionateScreenHeight(
                                                    70),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                image: FileImage(File(controller
                                                    .images[index].path)),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: const Text("Contact & About "),
                        shape: Border.all(
                            color: AppColor.textColor.withOpacity(0.001)),
                        iconColor: AppColor.secondary,
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Contact"),
                          SizedBox(
                            height: getProportionateScreenHeight(10),
                          ),
                          CustomTextField(
                            hintText: "Enter the contact number",
                            controller: controller.contactController,
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(10),
                          ),
                          CustomTextField(
                            hintText: "Enter the email",
                            controller: controller.emailController,
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(10),
                          ),
                          CustomTextField(
                            hintText: "Enter the website",
                            controller: controller.websiteController,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(15),
                      ),
                      InkWell(
                        onTap: () async {
                          if (!controller.formKey.currentState!.validate()) {
                            return;
                          }
                          await controller.submitContribution();
                        },
                        child: Container(
                          width: double.infinity,
                          height: getProportionateScreenHeight(45),
                          decoration: BoxDecoration(
                            color: AppColor.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Submit",
                              style: interMedium.copyWith(
                                color: Colors.white,
                                fontSize: getProportionateScreenHeight(14),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Future<bool> showSaveDialog(
      {required BuildContext context,
      required CreateContributionController controller}) async {
    final res = await showDialog(
      context: context,
      useSafeArea: true,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: AlertDialog(
            title: Center(
              child: Text(
                "Save to Drafts",
                style: interSemiBold.copyWith(
                  color: AppColor.primary,
                  fontSize: getProportionateScreenHeight(20),
                ),
              ),
            ),
            content: Text(
              "Do you want to save this contribution to drafts?",
              textAlign: TextAlign.center,
              style: interRegular.copyWith(
                fontSize: getProportionateScreenHeight(12),
                color: AppColor.textColor,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back(result: false);
                },
                child: Text(
                  "No",
                  style: interSemiBold.copyWith(
                    color: AppColor.textColor,
                    fontSize: getProportionateScreenHeight(14),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  controller.saveToDrafts();
                  Get.back(result: true);
                },
                child: Text(
                  "Yes",
                  style: interSemiBold.copyWith(
                    color: AppColor.primary,
                    fontSize: getProportionateScreenHeight(14),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
    return res;
  }
}

class CustomDropDown extends StatelessWidget {
  final List dropdownItems;
  final String? selectedValue;
  final String hintText;
  final Function(Object?)? onChanged;
  const CustomDropDown({
    super.key,
    required this.dropdownItems,
    this.selectedValue,
    required this.onChanged,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: getProportionateScreenHeight(45),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColor.utilityOutline,
        ),
        color: AppColor.textBoxFillColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4.0),
      child: DropdownButton(
        items: dropdownItems.map((value) {
          return DropdownMenuItem(
            value: value,
            child: Text(
              value,
              style: interRegular.copyWith(
                color: AppColor.textColor,
                fontSize: getProportionateScreenHeight(13),
              ),
            ),
          );
        }).toList(),
        underline: const SizedBox(),
        isExpanded: true,
        isDense: false,
        elevation: 0,
        value: selectedValue,
        hint: SizedBox(
          width: double.infinity,
          child: Text(
            hintText,
            style: interRegular.copyWith(
              color: AppColor.textColor,
              fontSize: getProportionateScreenHeight(12),
            ),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
