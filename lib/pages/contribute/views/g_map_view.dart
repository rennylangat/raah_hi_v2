import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:raah_hi_v2/pages/contribute/controllers/create_contribution_controller.dart';

class GMapView extends StatefulWidget {
  const GMapView({super.key});

  static final randNum = Random().nextInt(50);

  @override
  State<GMapView> createState() => _GMapViewState();
}

class _GMapViewState extends State<GMapView> {
  late CreateContributionController controller;
  @override
  void initState() {
    super.initState();
    controller = Get.find<CreateContributionController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(result: GMapView.randNum);
          },
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          child:
              GetBuilder<CreateContributionController>(builder: (controller) {
            return controller.fetchLocation
                ? const CupertinoActivityIndicator()
                : GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        controller.currLocation.latitude!,
                        controller.currLocation.longitude!,
                      ),
                      zoom: 16.4746,
                    ),
                    zoomControlsEnabled: true,
                    zoomGesturesEnabled: true,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    onMapCreated: (GoogleMapController mapsController) {
                      controller.bigMapsController.complete(mapsController);
                    },
                    markers: {
                      controller.marker ??
                          Marker(
                            markerId: const MarkerId('1'),
                            position: controller.kGooglePlex.target,
                          )
                    },
                    buildingsEnabled: true,
                    onTap: (LatLng latLng) {
                      controller.getAddressFromMarker(latLng: latLng);
                    },
                  );
          }),
        ),
      ),
    );
  }
}
