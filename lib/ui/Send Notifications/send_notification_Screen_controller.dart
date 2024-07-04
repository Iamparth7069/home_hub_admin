import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:home_hub_control_room/Firebase%20Service/notification_service.dart';
import 'package:home_hub_control_room/Response%20Model/service_provider_req_res_model.dart';
import 'package:home_hub_control_room/Response%20Model/user_res_model.dart';

class SendNotificationScreenController extends GetxController {
  int selctedvalue = 0;
  bool isSending = false;
  TextEditingController title = TextEditingController();
  TextEditingController discription = TextEditingController();
  setRadioSelect({required int index}) {
    selctedvalue = index;
    update();
  }

  double progressValue = 0.0;

  Future<void> sendToUser() async {
    isSending = true;
    update();
    QuerySnapshot data =
        await FirebaseFirestore.instance.collection("User").get();
    int total = data.docs.length;
    double addValue = 100 / total;
    data.docs.forEach((element) {
      UserResModel userResModel =
          UserResModel.fromMap(element.data() as Map<String, dynamic>);
      print("FCM ::${userResModel.fcmToken}");
      NotificationService.sendMessage(
          title: title.text.trim(),
          msg: discription.text.trim(),
          receiverFcmToken: userResModel.fcmToken);
      progressValue += addValue;
    });
    isSending = false;
    update();
  }

  Future<void> sendToServiceProvider() async {
    isSending = true;
    update();
    QuerySnapshot data =
        await FirebaseFirestore.instance.collection("service_providers").get();
    int total = data.docs.length;
    double addValue = 100 / total;
    data.docs.forEach((element) {
      Map<String, dynamic> data = element.data() as Map<String, dynamic>;
      NotificationService.sendMessage(
          title: title.text.trim(),
          msg: discription.text.trim(),
          receiverFcmToken: data["fcmToken"]);
      progressValue += addValue;
      update();
    });
    isSending = false;
    update();
  }
}
