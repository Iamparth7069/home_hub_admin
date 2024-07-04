import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_hub_control_room/Firebase%20Service/service_provider_req_service.dart';
import 'package:home_hub_control_room/Response%20Model/service_provider_req_res_model.dart';
import 'package:home_hub_control_room/constant/app_color.dart';

import 'package:home_hub_control_room/utils/extension.dart';
import 'package:sizer/sizer.dart';

class ServiceProviderProfileScreen extends StatefulWidget {
  const ServiceProviderProfileScreen({super.key});

  @override
  State<ServiceProviderProfileScreen> createState() =>
      _ServiceProviderProfileScreenState();
}

class _ServiceProviderProfileScreenState
    extends State<ServiceProviderProfileScreen> {
  ServiceProviderReqResModel serviceProvider = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            2.h.addHSpace(),
            Center(
              child: Container(
                height: 13.h,
                width: 13.h,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(100)),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: serviceProvider.images ?? "")),
              ),
            ),
            2.h.addHSpace(),
            Center(
              child: "${serviceProvider.fname} ${serviceProvider.lname}"
                  .boldOpenSans(fontSize: 13.sp, fontColor: Colors.black),
            ),
            5.h.addHSpace(),
            Card(
              child: Container(
                width: 100.w,
                height: 7.h,
                child: Row(
                  children: [
                    3.w.addWSpace(),
                    "Email : "
                        .boldOpenSans(fontSize: 12.sp, fontColor: Colors.black),
                    "${serviceProvider.email}"
                        .semiOpenSans(fontSize: 12.sp, fontColor: Colors.black),
                  ],
                ),
              ),
            ),
            1.h.addHSpace(),
            Card(
              child: Container(
                width: 100.w,
                height: 7.h,
                child: Row(
                  children: [
                    3.w.addWSpace(),
                    "Contact : "
                        .boldOpenSans(fontSize: 12.sp, fontColor: Colors.black),
                    "${serviceProvider.contact}"
                        .semiOpenSans(fontSize: 12.sp, fontColor: Colors.black),
                    "   ${serviceProvider.contactOptional}"
                        .semiOpenSans(fontSize: 12.sp, fontColor: Colors.black),
                  ],
                ),
              ),
            ),
            1.h.addHSpace(),
            Card(
              child: Container(
                width: 100.w,
                height: 7.5.h,
                child: Row(
                  children: [
                    3.w.addWSpace(),
                    "Address :  "
                        .boldOpenSans(fontSize: 12.sp, fontColor: Colors.black),
                    Expanded(
                      child: "${serviceProvider.address}".semiOpenSans(
                          fontSize: 12.sp,
                          maxLines: 2,
                          textOverflow: TextOverflow.ellipsis,
                          fontColor: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            1.h.addHSpace(),
            Card(
              child: Container(
                width: 100.w,
                height: 7.5.h,
                child: Row(
                  children: [
                    3.w.addWSpace(),
                    "Service :  "
                        .boldOpenSans(fontSize: 12.sp, fontColor: Colors.black),
                    "${serviceProvider.services}".semiOpenSans(
                        fontSize: 12.sp,
                        textOverflow: TextOverflow.ellipsis,
                        fontColor: Colors.black),
                  ],
                ),
              ),
            ),
            1.5.h.addHSpace(),
            "Documents ".boldOpenSans(fontSize: 13.sp, fontColor: Colors.black),
            1.5.h.addHSpace(),
            Card(
              child: Container(
                width: 100.w,
                height: 7.5.h,
                child: Row(
                  children: [
                    3.w.addWSpace(),
                    "AdardCard :  "
                        .boldOpenSans(fontSize: 12.sp, fontColor: Colors.black),
                    "Image".semiOpenSans(
                        fontSize: 12.sp,
                        textOverflow: TextOverflow.ellipsis,
                        fontColor: Colors.black),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          Get.dialog(
                            Dialog(
                              insetPadding: EdgeInsets.zero,
                              child: Container(
                                width: 90.w,
                                height: 30.h,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(20)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        serviceProvider.useraadharcard ?? "",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.visibility)),
                  ],
                ),
              ),
            ),
            2.h.addHSpace(),
            const Spacer(),
            serviceProvider.status == "Pending"
                ? Row(
                    children: [
                      Expanded(
                          child: appButton(
                              onTap: () {
                                ServiceProviderReqService
                                    .rejectServiceProviderRequest(
                                        serviceProviderReqResModel:
                                            serviceProvider);
                                Get.back();
                              },
                              bordorColor: Colors.red,
                              color: Colors.transparent,
                              text: "Reject",
                              borderRadius: 12,
                              fontSize: 12.sp,
                              fontColor: Colors.red)),
                      2.w.addWSpace(),
                      Expanded(
                          child: appButton(
                              onTap: () {
                                ServiceProviderReqService
                                    .sendServiceProviderData(
                                        serviceProviderReqResModel:
                                            serviceProvider);
                                Get.back();
                              },
                              text: "Accept",
                              color: Colors.green,
                              fontSize: 12.sp,
                              borderRadius: 12,
                              fontColor: Colors.white))
                    ],
                  )
                : const SizedBox(),
            3.h.addHSpace(),
          ],
        ).paddingSymmetric(horizontal: 2.w),
      ),
    );
  }
}
