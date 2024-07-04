import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:home_hub_control_room/Firebase%20Service/notification_service.dart';
import 'package:home_hub_control_room/Firebase%20Service/repo.dart';
import 'package:home_hub_control_room/Response%20Model/service_provider_req_res_model.dart';
import 'package:home_hub_control_room/Response%20Model/service_provider_res_model.dart';
import 'package:home_hub_control_room/Response%20Model/transectionResModel.dart';
import 'package:home_hub_control_room/Response%20Model/widraval_res_model.dart';
import 'package:home_hub_control_room/constant/app_color.dart';
import 'package:home_hub_control_room/ui/Payment%20Screen/payment_request_screen_controller.dart';
import 'package:home_hub_control_room/utils/extension.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

import '../Drawer Screen/drawer_screen_controller.dart';

class PaymentRequestScreen extends StatefulWidget {
  const PaymentRequestScreen({super.key});

  @override
  State<PaymentRequestScreen> createState() => _PaymentRequestScreenState();
}

class _PaymentRequestScreenState extends State<PaymentRequestScreen> {
  DrawerScreenController drawerScreenController =
      Get.find<DrawerScreenController>();
  PaymentRequestScreenController paymentRequestScreenController =
      Get.put(PaymentRequestScreenController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: GetBuilder<PaymentRequestScreenController>(
          builder: (controller) {
            return Scaffold(
              appBar: controller.isMultiSelect
                  ? AppBar(
                      leading: GestureDetector(
                          onTap: () {
                            drawerScreenController.advancedDrawerController
                                .showDrawer();
                          },
                          child: const Icon(Icons.menu)),
                      title: "Total Amount".boldOpenSans(
                          fontColor: Colors.black, fontSize: 14.sp),
                      actions: [
                          "₹ ${controller.totalAmount}".boldOpenSans(
                              fontColor: Colors.green, fontSize: 14.sp),
                          2.w.addWSpace(),
                          IconButton(
                            onPressed: () {
                              Get.dialog(StatefulBuilder(
                                builder: (context, setState) {
                                  return Dialog(
                                      backgroundColor: Colors.transparent,
                                      child: Container(
                                        width: 500,
                                        height: 300,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: Column(
                                          children: [
                                            4.h.addHSpace(),
                                            'Are you sure?'.boldOpenSans(
                                                fontSize: 15.sp,
                                                fontColor: Colors.black),
                                            4.h.addHSpace(),
                                            '"Do you wish to proceed with the payment? Your confirmation helps us ensure a smooth transaction."'
                                                .semiOpenSans(
                                                    fontColor: Colors.grey,
                                                    textAlign: TextAlign.center,
                                                    maxLines: 2,
                                                    fontSize: 10.sp),
                                            const Spacer(),
                                            controller.isSendPayment == true
                                                ? const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  )
                                                : Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      1.w.addWSpace(),
                                                      Expanded(
                                                        child: appButton(
                                                            borderRadius: 10,
                                                            bordorColor:
                                                                Colors.red,
                                                            color: Colors
                                                                .transparent,
                                                            text: "Cancle",
                                                            fontColor:
                                                                Colors.red,
                                                            fontSize: 11.sp,
                                                            onTap: () {
                                                              Get.back();
                                                            }),
                                                      ),
                                                      2.w.addWSpace(),
                                                      Expanded(
                                                          child: appButton(
                                                              borderRadius: 10,
                                                              text: "Pay",
                                                              color:
                                                                  Colors.green,
                                                              fontColor:
                                                                  Colors.white,
                                                              fontSize: 11.sp,
                                                              onTap: () async {
                                                                await controller
                                                                    .sendPayment()
                                                                    .then(
                                                                  (value) {
                                                                    Get.back();
                                                                    Get.dialog(
                                                                        StatefulBuilder(
                                                                      builder:
                                                                          (context,
                                                                              setState) {
                                                                        backAfterTime();
                                                                        return Dialog(
                                                                            backgroundColor:
                                                                                Colors.transparent,
                                                                            child: Container(
                                                                              width: 500,
                                                                              height: 300,
                                                                              color: Colors.transparent,
                                                                              child: Lottie.asset("assets/lottie/s.json"),
                                                                            ));
                                                                      },
                                                                    ));
                                                                  },
                                                                );
                                                              })),
                                                      1.w.addWSpace(),
                                                    ],
                                                  ),
                                            const Spacer(),
                                          ],
                                        ),
                                      ));
                                },
                              ));
                            },
                            icon: const Icon(
                              Icons.account_balance_wallet,
                              color: Colors.green,
                            ),
                          )
                        ])
                  : AppBar(
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
                                text: "Withdrawal",
                              ),
                              Tab(
                                text: "Refund",
                              ),
                            ]),
                      ),
                      title: "Payment Requests".boldOpenSans(
                          fontColor: Colors.black, fontSize: 14.sp)),
              body: TabBarView(children: [
                withdrawalScreen(),
                refundScreen(),
              ]),
            );
          },
        ));
  }

  Widget refundScreen() {
    return GetBuilder<PaymentRequestScreenController>(
      builder: (controller) {
        return controller.isLoading == true
            ? const CircularProgressIndicator()
            : controller.refundData.isEmpty
                ? Center(
                    child: "Opps ! No Data Found"
                        .semiOpenSans(fontSize: 12.sp, fontColor: Colors.black),
                  )
                : ListView.builder(
                    itemCount: controller.refundUserData.length,
                    padding: EdgeInsets.only(top: 1.h),
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          controller.selectedIndex.contains(index)
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.green,
                                )
                              : const SizedBox(),
                          Expanded(
                            child: ListTile(
                              onLongPress: () {
                                controller.setMultiSelectValue(value: true);
                                controller.setSelectedIndex(
                                    value: index,
                                    amount:
                                        controller.refundData[index].amount);
                              },
                              onTap: () {
                                if (controller.isMultiSelect == true) {
                                  controller.setSelectedIndex(
                                      value: index,
                                      amount:
                                          controller.refundData[index].amount);
                                  print("HYYYYYYYYYY");
                                } else {}
                              },
                              leading: Container(
                                width: 14.w,
                                height: 14.w,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(100)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(200),
                                  child: CachedNetworkImage(
                                      imageUrl: controller
                                          .refundUserData[index].profileImage,
                                      fit: BoxFit.cover),
                                ),
                              ),
                              title:
                                  "${controller.refundUserData[index].firstName} ${controller.refundUserData[index].lastName}"
                                      .semiOpenSans(
                                          fontColor: Colors.black,
                                          fontSize: 12.sp),
                              subtitle: DateFormat('MMM dd, yyyy')
                                  .format(controller.refundData[index].date)
                                  .mediumOpenSans(
                                      fontColor: Colors.grey, fontSize: 9.sp),
                              trailing:
                                  "₹ ${controller.refundData[index].amount}"
                                      .boldOpenSans(
                                          fontColor: appColor, fontSize: 13.sp),
                            ),
                          ),
                        ],
                      );
                    },
                  );
      },
    );
  }

  Widget withdrawalScreen() {
    return GetBuilder<PaymentRequestScreenController>(
      builder: (controller) {
        return controller.isLoading == true
            ? const Center(child: CircularProgressIndicator())
            : controller.withdrawalData.isEmpty
                ? Center(
                    child: "Opps ! No Data Found"
                        .semiOpenSans(fontSize: 12.sp, fontColor: Colors.black),
                  )
                : ListView.builder(
                    itemCount: controller.withdrawalData.length,
                    padding: EdgeInsets.only(top: 1.h),
                    itemBuilder: (context, index) {
                      return Expanded(
                        child: ListTile(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isDismissible: false,
                              scrollControlDisabledMaxHeightRatio: 500,
                              isScrollControlled: true,
                              builder: (context) {
                                return bottomSheet(
                                    withdrawalResModel:
                                        controller.withdrawalData[index],
                                    serviceProviderReqResModel:
                                        controller.withdrawalUserData[index]);
                              },
                            );
                          },
                          leading: Container(
                            width: 14.w,
                            height: 14.w,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(100)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(200),
                              child: CachedNetworkImage(
                                  imageUrl: controller
                                      .withdrawalUserData[index].Images
                                      .toString(),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          title:
                              "${controller.withdrawalUserData[index].fname} ${controller.withdrawalUserData[index].lname}"
                                  .semiOpenSans(
                                      fontColor: Colors.black, fontSize: 12.sp),
                          subtitle: DateFormat('MMM dd, yyyy')
                              .format(controller.withdrawalData[index].date)
                              .mediumOpenSans(
                                  fontColor: Colors.grey, fontSize: 9.sp),
                          trailing:
                              "₹ ${controller.withdrawalData[index].amountWithdraw}"
                                  .boldOpenSans(
                                      fontColor: appColor, fontSize: 13.sp),
                        ),
                      );
                    },
                  );
      },
    );
  }

  Widget bottomSheet(
      {required WithdrawalResModel withdrawalResModel,
      required ServiceProviderRes serviceProviderReqResModel}) {
    bool isFinished = false;
    return GetBuilder<PaymentRequestScreenController>(
      builder: (controller) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: StatefulBuilder(
            builder: (context, setState) {
              return SizedBox(
                width: 100.w,
                height: 50.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    2.h.addHSpace(),
                    Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(500)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(500),
                          child: CachedNetworkImage(
                              imageUrl: serviceProviderReqResModel.Images ?? "",
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    1.h.addHSpace(),
                    Center(
                      child: "₹ ${withdrawalResModel.amountWithdraw}"
                          .boldOpenSans(
                              fontColor: appColor,
                              fontSize: 18.sp,
                              textAlign: TextAlign.center),
                    ),
                    2.h.addHSpace(),
                    Row(
                      children: [
                        "Name :".boldOpenSans(
                            fontColor: Colors.black, fontSize: 12.sp),
                        "  ${serviceProviderReqResModel.fname} ${serviceProviderReqResModel.lname}"
                            .semiOpenSans(
                                fontColor: Colors.black, fontSize: 12.sp)
                      ],
                    ),
                    2.h.addHSpace(),
                    Row(
                      children: [
                        "Email :".boldOpenSans(
                            fontColor: Colors.black, fontSize: 12.sp),
                        "  ${serviceProviderReqResModel.email}".semiOpenSans(
                            fontColor: Colors.black, fontSize: 12.sp)
                      ],
                    ),
                    3.h.addHSpace(),
                    Row(
                      children: [
                        "Contact :".boldOpenSans(
                            fontColor: Colors.black, fontSize: 12.sp),
                        "  ${serviceProviderReqResModel.contectnumber}"
                            .semiOpenSans(
                                fontColor: Colors.black, fontSize: 12.sp)
                      ],
                    ),
                    const Spacer(),
                    controller.isSendPayment == true
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Center(
                            child: appButton(
                                onTap: () async {
                                  controller.setIsSendPayment(
                                      isSendPayment: true);
                                  await paymentRequestCollection
                                      .doc(withdrawalResModel.id)
                                      .delete();
                                  Map<String, dynamic> empty = {};
                                  DocumentReference dd =
                                      await transectionCollection.add(empty);
                                  TransectionResModel t = TransectionResModel(
                                      from: "admin",
                                      to: withdrawalResModel.providerId,
                                      status: "Completed",
                                      type: "Withdraw",
                                      amount:
                                          "${withdrawalResModel.amountWithdraw}",
                                      transectionId: dd.id,
                                      time: DateTime.now());
                                  await transectionCollection
                                      .doc(dd.id)
                                      .set(t.toMap());

                                  ///Code FOr update Wallet info in firebase for admin
                                  DocumentSnapshot adminDD =
                                      await FirebaseFirestore.instance
                                          .collection("Admin")
                                          .doc("adminData")
                                          .get();
                                  Map<String, dynamic> adminData =
                                      adminDD.data() as Map<String, dynamic>;

                                  await FirebaseFirestore.instance
                                      .collection("Admin")
                                      .doc("adminData")
                                      .update({
                                    "payment": adminData["payment"] +
                                        withdrawalResModel.amountWithdraw
                                  });
                                  await FirebaseFirestore.instance
                                      .collection("Admin")
                                      .doc("adminData")
                                      .update({
                                    "wallet": adminData["wallet"] -
                                        withdrawalResModel.amountWithdraw
                                  });
                                  Get.back();
                                  NotificationService.sendMessage(
                                      title: "Withdrawal Amount",
                                      msg:
                                          "Your withdrawal of Rs. ${withdrawalResModel.amountWithdraw} is Provided to Your Upi",
                                      receiverFcmToken:
                                          serviceProviderReqResModel.fcmToken);
                                  controller.setIsSendPayment(
                                      isSendPayment: false);
                                },
                                text: "Pay Now",
                                fontSize: 12.sp)),
                    2.h.addHSpace(),
                  ],
                ).paddingSymmetric(horizontal: 2.w),
              );
            },
          ),
        );
      },
    );
  }

  void backAfterTime() {
    Future.delayed(const Duration(milliseconds: 1200))
        .then((value) => Get.back());
  }
}
