import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_hub_control_room/constant/app_color.dart';
import 'package:home_hub_control_room/network/network_controller.dart';
import 'package:home_hub_control_room/ui/Offer%20Screen/add_offer_screen_controller.dart';
import 'package:home_hub_control_room/ui/Offer%20Screen/offer_screen_controller.dart';
import 'package:home_hub_control_room/utils/extension.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

class AddOfferScreen extends StatefulWidget {
  const AddOfferScreen({super.key});

  @override
  State<AddOfferScreen> createState() => _AddOfferScreenState();
}

class _AddOfferScreenState extends State<AddOfferScreen> {
  AddOfferScreenController addOfferScreenController =
      Get.put(AddOfferScreenController());
  // NetworkController networkController = Get.find<NetworkController>();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    addOfferScreenController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back)),
        title:
            "Add Offers".boldOpenSans(fontColor: Colors.black, fontSize: 15.sp),
      ),
      body: Form(
        key: formKey,
        child: SafeArea(
          child: GetBuilder<AddOfferScreenController>(
            builder: (controller) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: 95.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                        color: controller.bgColor,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    controller.discount.boldOpenSans(
                                        fontColor: Colors.white,
                                        fontSize: 30.sp),
                                    controller.title.boldOpenSans(
                                        fontColor: Colors.white,
                                        fontSize: 17.sp),
                                    controller.discription.semiOpenSans(
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
                              child: controller.image != null
                                  ? Image.file(controller.image!)
                                  : const SizedBox(),
                            ),
                          )
                        ],
                      ),
                    ),
                    3.h.addHSpace(),
                    Card(
                        child: customTextFormField(
                      onChanged: (value) {
                        controller.setDiscount(value: value);
                      },
                      hintText: "Discount",
                      maxLines: 1,
                      validator: (p0) {
                        if (p0?.trim() == "") {
                          return "Please Enter Discount";
                        }
                      },
                    )),
                    1.h.addHSpace(),
                    Card(
                        child: customTextFormField(
                      onChanged: (value) {
                        controller.setTitle(value: value);
                      },
                      hintText: "Title",
                      maxLines: 1,
                      validator: (p0) {
                        if (p0?.trim() == "") {
                          return "Please Enter Title";
                        }
                      },
                    )),
                    1.h.addHSpace(),
                    Card(
                        child: customTextFormField(
                      onChanged: (value) {
                        controller.setDiscription(value: value);
                      },
                      hintText: "Discription",
                      maxLines: 5,
                      validator: (p0) {
                        if (p0?.trim() == "") {
                          return "Please Enter Discription";
                        }
                      },
                    )),
                    1.h.addHSpace(),
                    GestureDetector(
                      onTap: () {
                        controller.pickImage();
                      },
                      child: Card(
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                              color: const Color(0xfffafafa),
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            children: [
                              Text(
                                controller.image == null
                                    ? "Select Image"
                                    : "Image Selected",
                              ),
                              const Spacer(),
                              controller.image == null
                                  ? const Icon(Icons.image)
                                  : GestureDetector(
                                      onTap: () {
                                        controller.removeImage();
                                      },
                                      child: const Icon(Icons.close))
                            ],
                          ).paddingSymmetric(horizontal: 3.w),
                        ),
                      ),
                    ),
                    10.h.addHSpace(),
                    controller.isSendData == true
                        ? LoadingAnimationWidget.hexagonDots(
                            color: appColor, size: 11.w)
                        : appButton(
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                if (controller.image == null) {
                                  showMessege(
                                      title: "Something Went Wrong",
                                      messege: "Please Select Image");
                                } else {
                                  await controller.sendDataToFirebase();
                                  showMessege(
                                      title: "Success",
                                      messege: "Offer Added Successfully");
                                  Get.back();
                                }
                              }
                            },
                            text: "Submit",
                            fontColor: Colors.white,
                            color: Colors.deepPurple,
                            borderRadius: 10)
                  ],
                ).paddingSymmetric(horizontal: 2.w, vertical: 1.h),
              );
            },
          ),
        ),
      ),
    );
  }
}
