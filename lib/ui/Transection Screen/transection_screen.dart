import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_hub_control_room/constant/app_color.dart';
import 'package:home_hub_control_room/ui/Drawer%20Screen/drawer_screen_controller.dart';
import 'package:home_hub_control_room/ui/Transection%20Screen/transection_screen_controller.dart';
import 'package:home_hub_control_room/utils/extension.dart';
import 'package:sizer/sizer.dart';

class TransectionScreen extends StatefulWidget {
  const TransectionScreen({super.key});

  @override
  State<TransectionScreen> createState() => _TransectionScreenState();
}

class _TransectionScreenState extends State<TransectionScreen> {
  DrawerScreenController drawerScreenController =
      Get.find<DrawerScreenController>();
  TransectionScreenController transectionScreenController =
      Get.put(TransectionScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                drawerScreenController.advancedDrawerController.showDrawer();
              },
              child: const Icon(Icons.menu)),
          title: "Transactions"
              .boldOpenSans(fontColor: Colors.black, fontSize: 14.sp),
        ),
        body: GetBuilder<TransectionScreenController>(
          builder: (controller) {
            return ListView.builder(
              itemCount: controller.trData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: lightPurple,
                      borderRadius: BorderRadius.circular(300),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(300),
                      child: CachedNetworkImage(
                          imageUrl: controller.trData[index]["type"] ==
                                  "Withdraw"
                              ? "${controller.trUserData[index]["Images"]} "
                              : "${controller.trUserData[index]["profileImage"]} ",
                          fit: BoxFit.cover),
                    ),
                  ),
                  title: controller.trData[index]["type"] == "Payment"
                      ? "${controller.trUserData[index]["firstName"]} ${controller.trUserData[index]["lastName"]}"
                          .semiOpenSans(
                              fontColor: Colors.black, fontSize: 12.sp)
                      : controller.trData[index]["type"] == "Withdraw"
                          ? "${controller.trUserData[index]["fname"]} ${controller.trUserData[index]["lname"]}"
                              .semiOpenSans(
                                  fontColor: Colors.black, fontSize: 12.sp)
                          : "Bhavik Zadafiya".semiOpenSans(
                              fontColor: Colors.black, fontSize: 12.sp),
                  trailing: (controller.trData[index]["type"] == "Payment"
                          ? " + ${controller.trData[index]["amount"]}"
                          : " - ${controller.trData[index]["amount"]}")
                      .boldOpenSans(
                          fontColor:
                              controller.trData[index]["type"] == "Payment"
                                  ? Colors.green
                                  : Colors.red,
                          fontSize: 12.sp),
                ).paddingSymmetric(vertical: 0.5.h);
              },
            );
          },
        ));
  }
}
