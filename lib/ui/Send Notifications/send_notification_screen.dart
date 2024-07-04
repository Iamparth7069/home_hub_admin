import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:home_hub_control_room/constant/app_color.dart';
import 'package:home_hub_control_room/ui/Drawer%20Screen/drawer_screen_controller.dart';
import 'package:home_hub_control_room/ui/Send%20Notifications/send_notification_Screen_controller.dart';
import 'package:home_hub_control_room/utils/extension.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class SendNotificationScreen extends StatefulWidget {
  const SendNotificationScreen({super.key});

  @override
  State<SendNotificationScreen> createState() => _SendNotificationScreenState();
}

class _SendNotificationScreenState extends State<SendNotificationScreen> {
  DrawerScreenController drawerScreenController =
      Get.find<DrawerScreenController>();
  SendNotificationScreenController sendNotificationScreenController =
      Get.put(SendNotificationScreenController());
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                drawerScreenController.advancedDrawerController.showDrawer();
              },
              child: const Icon(Icons.menu)),
          title: "Send Notifications"
              .boldOpenSans(fontSize: 12.sp, fontColor: Colors.black),
        ),
        body: GetBuilder<SendNotificationScreenController>(
          builder: (controller) {
            return SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Lottie.asset("assets/lottie/Notification.json",
                        width: 60.w),
                    TextFormField(
                      controller: controller.title,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Please Enter Title";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Title",
                      ),
                    ),
                    2.h.addHSpace(),
                    TextFormField(
                      controller: controller.discription,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return "Please Enter Discription";
                        }
                        return null;
                      },
                      maxLines: 5,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Discription",
                      ),
                    ),
                    3.h.addHSpace(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RadioMenuButton(
                            value: 0,
                            groupValue: controller.selctedvalue,
                            onChanged: (value) {
                              controller.setRadioSelect(index: value!);
                            },
                            child: "All Users".semiOpenSans(
                                fontColor: Colors.black, fontSize: 12.sp)),
                        RadioMenuButton(
                            value: 1,
                            groupValue: controller.selctedvalue,
                            onChanged: (value) {
                              controller.setRadioSelect(index: value!);
                            },
                            child: "All Service Provider".semiOpenSans(
                                fontColor: Colors.black, fontSize: 12.sp)),
                      ],
                    ),
                    11.h.addHSpace(),
                    controller.isSending == true
                        ? Center(
                            child: LinearProgressIndicator(
                                value: controller.progressValue,
                                minHeight: 8,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                          )
                        : appButton(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                if (controller.selctedvalue == 0) {
                                  controller.sendToUser().then(
                                    (value) {
                                      showMessege(title: "Notification Send ");
                                    },
                                  );
                                } else {
                                  controller.sendToServiceProvider().then(
                                      (value) => showMessege(
                                          title: "Notification Send "));
                                }
                              }
                            },
                            text: "Send Notification",
                            fontSize: 12.sp,
                            height: 60)
                  ],
                ).paddingSymmetric(horizontal: 2.w),
              ),
            );
          },
        ));
  }
}
