import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_hub_control_room/Response%20Model/offer_res_model.dart';
import 'package:home_hub_control_room/ui/Drawer%20Screen/drawer_screen_controller.dart';
import 'package:home_hub_control_room/ui/Offer%20Screen/offer_screen_controller.dart';

import 'package:home_hub_control_room/utils/app_routes.dart';
import 'package:home_hub_control_room/utils/extension.dart';
import 'package:sizer/sizer.dart';

class OfferScreen extends StatefulWidget {
  const OfferScreen({super.key});

  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  DrawerScreenController drawerScreenController =
      Get.find<DrawerScreenController>();
  OfferScreenController offerScreenController =
      Get.put(OfferScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              drawerScreenController.advancedDrawerController.showDrawer();
            },
            child: const Icon(Icons.menu)),
        title: "Offers".boldOpenSans(fontColor: Colors.black, fontSize: 15.sp),
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed(Routes.addOfferScreen);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: GetBuilder<OfferScreenController>(
        builder: (controller) {
          return ListView.builder(
            itemCount: controller.offersData.length,
            itemBuilder: (context, index) {
              OfferResModel offer = controller.offersData[index];
              return Container(
                width: 95.w,
                height: 25.h,
                decoration: BoxDecoration(
                  color: Color(int.parse(offer.color.toString())),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 3.h,
                      bottom: 1.5.h,
                      left: 3.w,
                      child: SizedBox(
                        width: 50.w,
                        height: 25.h,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              (offer.discount ?? "").boldOpenSans(
                                  fontColor: Colors.white, fontSize: 30.sp),
                              (offer.title ?? "").boldOpenSans(
                                  fontColor: Colors.white, fontSize: 17.sp),
                              (offer.discription ?? "").semiOpenSans(
                                  maxLines: 2,
                                  textOverflow: TextOverflow.ellipsis,
                                  fontColor: Colors.white,
                                  fontSize: 12.sp),
                            ]),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 3.w,
                      child: SizedBox(
                        height: 22.h,
                        width: 40.w,
                        child: CachedNetworkImage(
                          imageUrl: offer.image ?? "",
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    )
                  ],
                ),
              ).paddingSymmetric(horizontal: 2.w, vertical: 1.h);
            },
          );
        },
      ),
    );
  }
}
