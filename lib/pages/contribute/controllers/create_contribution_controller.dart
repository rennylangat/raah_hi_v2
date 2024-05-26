import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:geocoder3/geocoder3.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart' as loc;

class CreateContributionController extends GetxController {
  bool isEditingStarted = false;
  TextEditingController placeNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool fetchLocation = false;
  late CameraPosition kGooglePlex;
  late GeoData geoData;
  final Completer<GoogleMapController> mapsController = Completer();
  final Completer<GoogleMapController> bigMapsController = Completer();
  final loc.Location location = loc.Location();
  List<Placemark> placeMarks = [];
  late loc.LocationData currLocation;
  Marker? marker;
  String googleApiKey = 'YOUR_API_KEY';
  final List<XFile> images = [];

  String? selectedCategory;
  List<String> categories = [
    "Select Category",
    "Hiking Trips",
    "Camping",
    "City Tours",
    "Cycling",
    "Adventure",
    "Nature"
  ];
  List<String> tags = [
    "Historical",
    "Adventure",
    "Nature",
    "Camping",
    "Religious",
    "Night Life",
    "City Tour",
    "Bus Station",
    "Railway Station",
    "Airport",
    "Market",
    "Mall",
    "Restaurant",
    "Hotel",
    "Spa",
    "Gym",
    "Hospital",
  ];
  List<String> selectedTags = [];
  String address = "Select Address";
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    googleApiKey = DotEnv.dotenv.env['googleMapsApiKey']!;
    log("Google Api Key $googleApiKey");
    getCurrLocation();
  }

  getCurrLocation() async {
    try {
      fetchLocation = true;
      update();
      bool serviceEnabled;
      loc.PermissionStatus permissionGranted;

      serviceEnabled = await location.serviceEnabled();

      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (serviceEnabled) {
          return;
        }
      }

      permissionGranted = await location.hasPermission();

      if (permissionGranted == loc.PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != loc.PermissionStatus.granted) {
          return;
        }
      }

      currLocation = await location.getLocation();
      log("Current Location: ${currLocation.latitude}, ${currLocation.longitude}");
      await getAddress(
          latLng: LatLng(currLocation.latitude!, currLocation.longitude!));

      await Geocoder3.getDataFromCoordinates(
        latitude: currLocation.latitude!,
        longitude: currLocation.longitude!,
        googleMapApiKey: googleApiKey,
      ).then((value) {
        geoData = value;
      });
      isEditingStarted = true;
      fetchLocation = false;
      update();
      log("Address on load: ${addressController.text.toString()}");

      return geoData.address.toString();
    } catch (e) {
      fetchLocation = false;
      log("Catch Error: $e");
      update();
      return null;
    }
  }

  getAddress({LatLng? latLng}) async {
    kGooglePlex = CameraPosition(
      target: latLng!,
      zoom: 16.4746,
    );
    double latitude = latLng.latitude;
    double longitude = latLng.longitude;
    geoData = await Geocoder3.getDataFromCoordinates(
      latitude: latitude,
      longitude: longitude,
      googleMapApiKey: googleApiKey,
    );

    placeMarks = await placemarkFromCoordinates(latitude, longitude);
    marker = Marker(
      markerId: const MarkerId("1"),
      position: kGooglePlex.target,
    );

    addressController.text = geoData.address.toString();

    update();
  }

  getAddressFromMarker({LatLng? latLng}) async {
    double latitude = latLng?.latitude ?? -1.2113238;
    double longitude = latLng?.longitude ?? 36.8846081;

    mapsController.future.then((value) {
      value.animateCamera(
        CameraUpdate.newLatLng(
          latLng!,
        ),
      );
    });
    marker = Marker(
      markerId: const MarkerId("1"),
      position: latLng!,
    );
    placeMarks = await placemarkFromCoordinates(latitude, longitude);

    geoData = await Geocoder3.getDataFromCoordinates(
      latitude: latitude,
      longitude: longitude,
      googleMapApiKey: googleApiKey,
    );

    log("Address: ${geoData.address.toString()}");

    addressController.text = geoData.address.toString();

    update();
  }

  pickImages() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      images.add(image);
      update();
    }
  }

  removeImage(int index) {
    images.removeAt(index);
    update();
  }

  submitContribution() {
    log("Place Name: ${placeNameController.text}");
    log("Address: ${addressController.text}");
    log("Description: ${descriptionController.text}");
    log("Contact: ${contactController.text}");
    log("Website: ${websiteController.text}");
    log("Email: ${emailController.text}");
    log("Selected Category: $selectedCategory");
    log("Selected Tags: $selectedTags");
    log("Images: $images");
  }

  Future<bool> saveToDrafts() async {
    log("Place Name: ${placeNameController.text}");
    log("Address: ${addressController.text}");
    log("Description: ${descriptionController.text}");
    log("Contact: ${contactController.text}");
    log("Website: ${websiteController.text}");
    log("Email: ${emailController.text}");
    log("Selected Category: $selectedCategory");
    log("Selected Tags: $selectedTags");
    log("Images: $images");

    box.write("placeName", placeNameController.text);
    box.write("address", addressController.text);
    box.write("description", descriptionController.text);
    box.write("contact", contactController.text);
    box.write("website", websiteController.text);
    box.write("email", emailController.text);
    box.write("selectedCategory", selectedCategory);
    box.write("selectedTags", selectedTags);
    box.write("images", images);
    return true;
  }
}
