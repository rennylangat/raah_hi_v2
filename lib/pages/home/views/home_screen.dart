import 'package:flutter/material.dart';
import 'package:raah_hi_v2/widgets/bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      // ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
      body: Container(),
    );
  }
}
