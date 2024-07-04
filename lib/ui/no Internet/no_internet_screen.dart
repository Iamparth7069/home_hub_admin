import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_hub_control_room/network/network_controller.dart';
import 'package:home_hub_control_room/ui/Drawer%20Screen/drawer_screen.dart';

class CheckInternetScreen extends StatefulWidget {
  const CheckInternetScreen({super.key});

  @override
  State<CheckInternetScreen> createState() => _CheckInternetScreenState();
}

class _CheckInternetScreenState extends State<CheckInternetScreen> {
  NetworkController networkController = Get.find<NetworkController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => networkController.conectionStatus.value == 0
          ? SizedBox()
          : DrawerScreen()),
    );
  }
}
