import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CreateContributionController extends GetxController {
  bool isEditingStarted = false;
  TextEditingController placeNameController = TextEditingController();
  TextEditingController nearestLandmarkController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String selectedCategory = "Select Category";
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
}
