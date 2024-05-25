import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:raah_hi_v2/pages/contribute/models/destination_model.dart';

class ExploreController extends GetxController {
  List<Destination> destination = [];
  List<Destination> recommended = [];
  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  getDestination() {
    for (int i = 0; i < 10; i++) {
      recommended.add(destination[i]);
    }
    update();
  }

  loadData() async {
    final String response =
        await rootBundle.loadString("assets/files/converted_mountainData.json");
    final data = await jsonDecode(response);
    for (var item in data) {
      destination.add(Destination.fromJson(item));
    }
    getDestination();
  }
}
