import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:home_hub_control_room/Response%20Model/service_provider_req_res_model.dart';
import 'package:home_hub_control_room/constant/app_color.dart';
import 'package:home_hub_control_room/ui/Drawer%20Screen/drawer_screen_controller.dart';

import 'package:home_hub_control_room/ui/Service%20Provider%20Menagement/service_provider_menagement_controller.dart';
import 'package:home_hub_control_room/ui/Widgets/app_search_field.dart';
import 'package:home_hub_control_room/utils/app_routes.dart';
import 'package:home_hub_control_room/utils/extension.dart';
import 'package:sizer/sizer.dart';

class ServiceProviderMenagementScreen extends StatefulWidget {
  const ServiceProviderMenagementScreen({super.key});

  @override
  State<ServiceProviderMenagementScreen> createState() =>
      _ServiceProviderMenagementScreenState();
}

class _ServiceProviderMenagementScreenState
    extends State<ServiceProviderMenagementScreen> {
  ServiceProviderMenagementController serviceProviderMenagementController =
      Get.put(ServiceProviderMenagementController());
  DrawerScreenController drawerScreenController =
      Get.find<DrawerScreenController>();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
              leading: GestureDetector(
                  onTap: () {
                    drawerScreenController.advancedDrawerController
                        .showDrawer();
                  },
                  child: const Icon(Icons.menu)),
              bottom: PreferredSize(
                preferredSize: Size(100.w, 5.h),
                child: const TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: [
                      Tab(
                        text: "Pending",
                      ),
                      Tab(
                        text: "Accepted",
                      ),
                      Tab(
                        text: "Rejected",
                      ),
                    ]),
              ),
              title: "Provider Requests"
                  .boldOpenSans(fontColor: Colors.black, fontSize: 15.sp)),
          body: TabBarView(
              children: [pendingScreen(), completedScreen(), rejectedScreen()]),
        ));
  }
}

Widget pendingScreen() {
  return GetBuilder<ServiceProviderMenagementController>(
    builder: (controller) {
      return controller.pendingReq.isEmpty
          ? Center(
              child: "No Pendin Request Found"
                  .semiOpenSans(fontColor: Colors.black, fontSize: 12.sp),
            )
          : Column(
              children: [
                2.h.addHSpace(),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.pendingReq.length,
                    itemBuilder: (context, index) {
                      ServiceProviderReqResModel serviceProvider =
                          controller.pendingReq[index];
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.serviceProviderProfileScreen,
                              arguments: serviceProvider);
                        },
                        child: Card(
                          child: Container(
                            height: 20.h,
                            width: 90.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: Stack(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    2.w.addWSpace(),
                                    Container(
                                      width: 17.w,
                                      height: 17.w,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(200),
                                          color: lightPurple),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(200),
                                          child: CachedNetworkImage(
                                              imageUrl:
                                                  serviceProvider.images ?? "",
                                              fit: BoxFit.cover)),
                                    ).paddingOnly(top: 2.h),
                                    3.w.addWSpace(),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        1.h.addHSpace(),
                                        Center(
                                          child:
                                              "${serviceProvider.fname} ${serviceProvider.lname}"
                                                  .boldOpenSans(
                                                      fontColor: Colors.black,
                                                      fontSize: 15.sp),
                                        ),
                                        1.h.addHSpace(),
                                        Row(
                                          children: [
                                            "Email : ".boldOpenSans(
                                                fontColor: Colors.black,
                                                fontSize: 11.sp),
                                            SizedBox(
                                              width: 60.w,
                                              child: "${serviceProvider.email}"
                                                  .semiOpenSans(
                                                      fontColor: Colors.black,
                                                      fontSize: 12.sp),
                                            ),
                                          ],
                                        ),
                                        1.h.addHSpace(),
                                        Row(
                                          children: [
                                            "Service : ".boldOpenSans(
                                                fontColor: Colors.black,
                                                fontSize: 11.sp),
                                            "${serviceProvider.services}"
                                                .semiOpenSans(
                                                    fontColor: Colors.black,
                                                    fontSize: 12.sp),
                                          ],
                                        ),
                                        1.h.addHSpace(),
                                        Row(
                                          children: [
                                            "Date : ".boldOpenSans(
                                                fontColor: Colors.black,
                                                fontSize: 11.sp),
                                            "14/05/2009".semiOpenSans(
                                                fontColor: Colors.black,
                                                fontSize: 12.sp),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Positioned(
                                  right: 10,
                                  top: 10,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.orange,
                                    radius: 7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ).paddingOnly(top: 2.h),
                      );
                    },
                  ),
                )
              ],
            );
    },
  );
}

Widget completedScreen() {
  return GetBuilder<ServiceProviderMenagementController>(
    builder: (controller) {
      return controller.completedReq.isEmpty
          ? Center(
              child: "No Completed Request Found"
                  .semiOpenSans(fontColor: Colors.black, fontSize: 12.sp),
            )
          : Column(
              children: [
                2.h.addHSpace(),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.completedReq.length,
                    itemBuilder: (context, index) {
                      ServiceProviderReqResModel serviceProvider =
                          controller.completedReq[index];
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.serviceProviderProfileScreen,
                              arguments: serviceProvider);
                        },
                        child: Card(
                          child: Container(
                            height: 20.h,
                            width: 90.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: Stack(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    2.w.addWSpace(),
                                    Container(
                                      width: 17.w,
                                      height: 17.w,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(200),
                                          color: lightPurple),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(200),
                                          child: CachedNetworkImage(
                                              imageUrl:
                                                  serviceProvider.images ?? "",
                                              fit: BoxFit.cover)),
                                    ).paddingOnly(top: 2.h),
                                    3.w.addWSpace(),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        1.h.addHSpace(),
                                        Center(
                                          child:
                                              "${serviceProvider.fname} ${serviceProvider.lname}"
                                                  .boldOpenSans(
                                                      fontColor: Colors.black,
                                                      fontSize: 15.sp),
                                        ),
                                        1.h.addHSpace(),
                                        Row(
                                          children: [
                                            "Email : ".boldOpenSans(
                                                fontColor: Colors.black,
                                                fontSize: 11.sp),
                                            SizedBox(
                                              width: 60.w,
                                              child: "${serviceProvider.email}"
                                                  .semiOpenSans(
                                                      fontColor: Colors.black,
                                                      fontSize: 12.sp),
                                            ),
                                          ],
                                        ),
                                        1.h.addHSpace(),
                                        Row(
                                          children: [
                                            "Service : ".boldOpenSans(
                                                fontColor: Colors.black,
                                                fontSize: 11.sp),
                                            "${serviceProvider.services}"
                                                .semiOpenSans(
                                                    fontColor: Colors.black,
                                                    fontSize: 12.sp),
                                          ],
                                        ),
                                        1.h.addHSpace(),
                                        Row(
                                          children: [
                                            "Date : ".boldOpenSans(
                                                fontColor: Colors.black,
                                                fontSize: 11.sp),
                                            "14/05/2009".semiOpenSans(
                                                fontColor: Colors.black,
                                                fontSize: 12.sp),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Positioned(
                                  right: 10,
                                  top: 10,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.green,
                                    radius: 7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ).paddingOnly(top: 2.h),
                      );
                    },
                  ),
                )
              ],
            );
    },
  );
}

Widget rejectedScreen() {
  return GetBuilder<ServiceProviderMenagementController>(
    builder: (controller) {
      return controller.rejectedReq.isEmpty
          ? Center(
              child: "Opps! No Rejected Request Found"
                  .semiOpenSans(fontColor: Colors.black, fontSize: 12.sp),
            )
          : Column(
              children: [
                2.h.addHSpace(),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.rejectedReq.length,
                    itemBuilder: (context, index) {
                      ServiceProviderReqResModel serviceProvider =
                          controller.rejectedReq[index];
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.serviceProviderProfileScreen,
                              arguments: serviceProvider);
                        },
                        child: Card(
                          child: Container(
                            height: 20.h,
                            width: 90.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: Stack(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    2.w.addWSpace(),
                                    Container(
                                      width: 17.w,
                                      height: 17.w,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(200),
                                          color: lightPurple),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(200),
                                          child: CachedNetworkImage(
                                              imageUrl:
                                                  serviceProvider.images ?? "",
                                              fit: BoxFit.cover)),
                                    ).paddingOnly(top: 2.h),
                                    3.w.addWSpace(),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        1.h.addHSpace(),
                                        Center(
                                          child:
                                              "${serviceProvider.fname} ${serviceProvider.lname}"
                                                  .boldOpenSans(
                                                      fontColor: Colors.black,
                                                      fontSize: 15.sp),
                                        ),
                                        1.h.addHSpace(),
                                        Row(
                                          children: [
                                            "Email : ".boldOpenSans(
                                                fontColor: Colors.black,
                                                fontSize: 11.sp),
                                            SizedBox(
                                              width: 60.w,
                                              child: "${serviceProvider.email}"
                                                  .semiOpenSans(
                                                      textOverflow:
                                                          TextOverflow.ellipsis,
                                                      fontColor: Colors.black,
                                                      fontSize: 12.sp),
                                            ),
                                          ],
                                        ),
                                        1.h.addHSpace(),
                                        Row(
                                          children: [
                                            "Service : ".boldOpenSans(
                                                fontColor: Colors.black,
                                                fontSize: 11.sp),
                                            "${serviceProvider.services}"
                                                .semiOpenSans(
                                                    fontColor: Colors.black,
                                                    fontSize: 12.sp),
                                          ],
                                        ),
                                        1.h.addHSpace(),
                                        Row(
                                          children: [
                                            "Date : ".boldOpenSans(
                                                fontColor: Colors.black,
                                                fontSize: 11.sp),
                                            "14/05/2009".semiOpenSans(
                                                fontColor: Colors.black,
                                                fontSize: 12.sp),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Positioned(
                                  right: 10,
                                  top: 10,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.red,
                                    radius: 7,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ).paddingOnly(top: 2.h),
                      );
                    },
                  ),
                )
              ],
            );
    },
  );
}
