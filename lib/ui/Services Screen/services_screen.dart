import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_hub_control_room/Response%20Model/service_res_model.dart';
import 'package:home_hub_control_room/constant/app_color.dart';
import 'package:home_hub_control_room/ui/Drawer%20Screen/drawer_screen_controller.dart';

import 'package:home_hub_control_room/ui/Services%20Screen/service_screen_controller.dart';
import 'package:home_hub_control_room/ui/Widgets/app_search_field.dart';
import 'package:home_hub_control_room/utils/extension.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  TextEditingController searchController = TextEditingController();
  ServiceScreenController serviceScreenController =
      Get.put(ServiceScreenController());
  DrawerScreenController drawerScreenController =
      Get.find<DrawerScreenController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              drawerScreenController.advancedDrawerController.showDrawer();
            },
            child: const Icon(Icons.menu)),
        title: "Services Menagement"
            .boldOpenSans(fontColor: Colors.black, fontSize: 14.sp),
        actions: [
          IconButton(
              onPressed: () {
                serviceScreenController.serviceNameController.clear();
                serviceScreenController.image = null;
                showModalBottomSheet(
                  context: context,
                  isDismissible: false,
                  scrollControlDisabledMaxHeightRatio: 500,
                  isScrollControlled: true,
                  builder: (context) {
                    return _showBottomSheet();
                  },
                );
              },
              icon: const Icon(
                Icons.add,
                size: 25,
                color: Colors.black,
              ))
        ],
        bottom: PreferredSize(
            preferredSize: Size(100.w, 7.h),
            child: Expanded(
                child: AppSearchField(
              controller: searchController,
              onTap: (value) {
                if (value.length >= 1) {
                  serviceScreenController.setSearchValue(value: true);
                  serviceScreenController.getSearchServices(searchValue: value);
                } else {
                  serviceScreenController.setSearchValue(value: false);
                }
              },
            ))),
      ),
      body: SafeArea(
        child: GetBuilder<ServiceScreenController>(
          builder: (controller) {
            List<ServiceResModel> serviceData = [];
            if (controller.isSearch == true) {
              serviceData.clear();
              serviceData = controller.searchServices;
            } else {
              serviceData.clear();
              serviceData = controller.allServices;
            }
            return serviceData.isEmpty
                ? Center(
                    child: "Opps! No Data Found"
                        .boldOpenSans(fontColor: Colors.black))
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: serviceData.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: SizedBox(
                                width: 100.w,
                                height: 8.h,
                                child: Center(
                                  child: ListTile(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        isDismissible: false,
                                        scrollControlDisabledMaxHeightRatio:
                                            500,
                                        isScrollControlled: true,
                                        builder: (context) {
                                          controller
                                                  .serviceNameController.text =
                                              serviceData[index].serviceName ??
                                                  "";
                                          return _showBottomSheet(
                                              serviceResModel:
                                                  serviceData[index]);
                                        },
                                      );
                                    },
                                    leading: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              serviceData[index].image ?? "",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    title: Row(
                                      children: [
                                        "${serviceData[index].serviceName}"
                                            .semiOpenSans(
                                                textOverflow:
                                                    TextOverflow.ellipsis,
                                                fontSize: 12.sp,
                                                fontColor: Colors.black,
                                                maxLines: 2),
                                        const Spacer(),
                                        const Icon(Icons.chevron_right),
                                        // PopupMenuButton(
                                        //   itemBuilder: (BuildContext context) {
                                        //     return [
                                        //       PopupMenuItem(
                                        //         height: 3.h,
                                        //         child: ListTile(
                                        //           leading:
                                        //               const Icon(Icons.edit),
                                        //           title: const Text('Edit'),
                                        //           onTap: () {
                                        //             // Handle edit option
                                        //             Navigator.pop(context);
                                        //           },
                                        //         ),
                                        //       ),
                                        //       PopupMenuItem(
                                        //         child: ListTile(
                                        //           leading:
                                        //               const Icon(Icons.delete),
                                        //           title: const Text('Delete'),
                                        //           onTap: () {
                                        //             // Handle delete option
                                        //             Navigator.pop(context);
                                        //           },
                                        //         ),
                                        //       ),
                                        //     ];
                                        //   },
                                        // )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ).paddingOnly(top: 1.h);
                          },
                        ),
                      )
                    ],
                  ).paddingSymmetric(horizontal: 2.w);
          },
        ),
      ),
    );
  }

  Widget _showBottomSheet({ServiceResModel? serviceResModel}) {
    return StatefulBuilder(
      builder: (context, setState) {
        return GetBuilder<ServiceScreenController>(
          builder: (controller) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                width: 100.w,
                height: 40.h,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    2.h.addHSpace(),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            color: lightPurple,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: controller.image != null
                                ? Image.file(controller.image!)
                                : serviceResModel?.image == null
                                    ? const SizedBox()
                                    : CachedNetworkImage(
                                        imageUrl: serviceResModel?.image ?? "",
                                      ),
                          ),
                        ),
                        Positioned(
                          bottom: -5,
                          right: -5,
                          child: IconButton(
                            onPressed: () {
                              controller.pickImage();
                            },
                            icon: const Icon(
                              Icons.image,
                              color: appColor,
                              size: 20,
                            ),
                          ),
                        )
                      ],
                    ),
                    3.h.addHSpace(),
                    customTextFormField(
                        textEditingController: controller.serviceNameController,
                        hintText: "Service Name",
                        fillColor: lightPurple.withOpacity(0.3)),
                    const Spacer(),
                    controller.isSendData == true
                        ? LoadingAnimationWidget.hexagonDots(
                            color: appColor, size: 5.h)
                        : appButton(
                            onTap: () async {
                              print("zsadasd");
                              if (serviceResModel == null) {
                                if (controller.image == null &&
                                    controller.serviceNameController.text
                                            .trim() ==
                                        "") {
                                  showMessege(
                                      title: "Somthig Went Wrong!",
                                      messege: "Please Insert Data ");
                                } else if (controller.image == null) {
                                  showMessege(
                                      title: "Somthig Went Wrong!",
                                      messege: "Please Select Image  ");
                                } else if (controller.serviceNameController.text
                                        .trim() ==
                                    "") {
                                  showMessege(
                                      title: "Somthig Went Wrong!",
                                      messege: "Please Enter Service Name");
                                } else {
                                  await controller.sendServiceData();
                                }
                              } else {
                                if (controller.serviceNameController.text
                                            .trim() ==
                                        serviceResModel.serviceName &&
                                    controller.image == null) {
                                  showMessege(
                                      title: "Somthig Went Wrong!",
                                      messege: "No Changes Found");
                                } else {
                                  ServiceResModel res = ServiceResModel(
                                      did: serviceResModel.did,
                                      serviceName: controller
                                          .serviceNameController.text
                                          .trim(),
                                      image: serviceResModel.image,
                                      createdAt: serviceResModel.createdAt);
                                  await controller.updateService(
                                      serviceResModel: res);
                                  controller.serviceNameController.clear();
                                  controller.image = null;
                                }
                              }
                            },
                            borderRadius: 10,
                            color: appColor.withOpacity(0.7),
                            fontSize: 12.sp,
                            fontColor: Colors.white,
                            text: serviceResModel == null
                                ? "Add Service"
                                : "Update Service"),
                    3.h.addHSpace(),
                  ],
                ).paddingSymmetric(horizontal: 2.w),
              ),
            );
          },
        );
      },
    );
  }
}
