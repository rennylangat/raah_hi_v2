import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:raah_hi_v2/pages/contribute/controllers/create_contribution_controller.dart';
import 'package:raah_hi_v2/utils/size_config.dart';
import 'package:raah_hi_v2/utils/text_style.dart';

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
    return Scaffold(
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
    );
  }
}
