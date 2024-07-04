import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:home_hub_control_room/Firebase%20Service/notification_service.dart';
import 'package:home_hub_control_room/Firebase%20Service/repo.dart';
import 'package:home_hub_control_room/Response%20Model/refund_res_model.dart';
import 'package:home_hub_control_room/Response%20Model/service_provider_req_res_model.dart';
import 'package:home_hub_control_room/Response%20Model/transectionResModel.dart';
import 'package:home_hub_control_room/Response%20Model/user_res_model.dart';
import 'package:home_hub_control_room/Response%20Model/widraval_res_model.dart';

import '../../Response Model/service_provider_res_model.dart';

class PaymentRequestScreenController extends GetxController {
  List<RefundResModel> refundData = [];
  List<UserResModel> refundUserData = [];
  List<WithdrawalResModel> withdrawalData = [];
  List<ServiceProviderRes> withdrawalUserData = [];
  bool isLoading = false;
  bool isMultiSelect = false;
  List selectedIndex = [];
  int totalAmount = 0;
  bool isSendPayment = false;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    selectedIndex.clear();
    getAllData();
  }

  void setMultiSelectValue({required bool value}) {
    isMultiSelect = value;
    update();
  }

  void setIsSendPayment({required bool isSendPayment}) {
    isSendPayment = this.isSendPayment;
    update();
  }

  void setSelectedIndex({required int value, required int amount}) {
    if (selectedIndex.contains(value)) {
      selectedIndex.remove(value);
      totalAmount = totalAmount - amount;
    } else {
      selectedIndex.add(value);
      totalAmount = totalAmount + amount;
    }
    update();
    if (selectedIndex.isEmpty) {
      isMultiSelect = false;
      totalAmount = 0;
      update();
    }
  }

  Future<void> getAllData() async {
    try {
      Stream<QuerySnapshot> dd = paymentRequestCollection.snapshots();
      isLoading = true;
      update();
      dd.listen((event) {
        refundData.clear();
        refundUserData.clear();
        withdrawalData.clear();
        withdrawalUserData.clear();
        if (event.docs.isEmpty) {
          isLoading = false;
          update();
          return null;
        }
        event.docs.forEach((element) async {
          Map<String, dynamic> data = element.data() as Map<String, dynamic>;
          data.addAll({"id": element.id});
          print(data);
          if (data['type'] == "Refund") {
            RefundResModel refundResModel = RefundResModel.fromJson(data);
            UserResModel userResModel =
                await getUserData(userId: refundResModel.userId);
            refundData.add(refundResModel);
            refundUserData.add(userResModel);
          } else {
            WithdrawalResModel withdrawalResModel =
                WithdrawalResModel.fromJson(data);
            print("Id :- ${withdrawalResModel.providerId}");
            ServiceProviderRes serviceProviderReqResModel =
                await getServiceProviderData(
                    userId: withdrawalResModel.providerId);
            withdrawalData.add(withdrawalResModel);
            withdrawalUserData.add(serviceProviderReqResModel);
          }
          isLoading = false;
          update();
        });
      });
    } catch (e) {
      isLoading = false;
      update();
      print("ERROR ${e}");
    }
  }

  Future<UserResModel> getUserData({required String userId}) async {
    DocumentSnapshot dd = await userCollection.doc(userId).get();

    return UserResModel.fromMap(dd.data() as Map<String, dynamic>);
  }

  Future<ServiceProviderRes> getServiceProviderData(
      {required String userId}) async {
    DocumentSnapshot dd = await serviceProviders.doc(userId).get();

    return ServiceProviderRes.formMap(dd.data() as Map<String, dynamic>);
  }

  Future<void> sendPayment() async {
    isSendPayment = true;
    update();
    selectedIndex.forEach((element) async {
      Map<String, dynamic> emptyMap = {};
      DocumentReference dd = await transectionCollection.add(emptyMap);
      TransectionResModel transectionResModel = TransectionResModel(
          from: "admin",
          to: refundData[element].userId,
          status: "Completed",
          type: "Refund",
          amount: "${refundData[element].amount}",
          transectionId: dd.id,
          time: DateTime.now());
      await transectionCollection.doc(dd.id).set(transectionResModel.toMap());

      ///Code FOr update Wallet info in firebase for admin
      DocumentSnapshot adminDD = await FirebaseFirestore.instance
          .collection("Admin")
          .doc("adminData")
          .get();
      Map<String, dynamic> adminData = adminDD.data() as Map<String, dynamic>;

      await FirebaseFirestore.instance
          .collection("Admin")
          .doc("adminData")
          .update({"refund": adminData["refund"] + refundData[element].amount});
      await FirebaseFirestore.instance
          .collection("Admin")
          .doc("adminData")
          .update({"wallet": adminData["wallet"] - refundData[element].amount});
      await paymentRequestCollection.doc(refundData[element].id).delete();
      NotificationService.sendMessage(
          title: "Partial Payment Refund",
          msg: "80% of your payment has been refunded by the admin.",
          receiverFcmToken: refundUserData[element].fcmToken);
    });
    totalAmount = 0;
    selectedIndex.clear();
    isMultiSelect = false;
    isSendPayment = false;
    update();
  }
}
