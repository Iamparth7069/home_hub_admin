import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:home_hub_control_room/Firebase%20Service/repo.dart';
import 'package:home_hub_control_room/Response%20Model/service_provider_req_res_model.dart';

class ServiceProviderReqService {
  static Future<List<ServiceProviderReqResModel>>
      getAllServiceProviderData() async {
    List<ServiceProviderReqResModel> dataList = [];
    QuerySnapshot serviceProviderDataSnapshot =
        await serviceProviderRequestCollection.get();

    for (var element in serviceProviderDataSnapshot.docs) {
      Map<String, dynamic> data = element.data() as Map<String, dynamic>;
      ServiceProviderReqResModel service =
          ServiceProviderReqResModel.fromJson(data);
      dataList.add(service);
    }
    return dataList;
  }

  static Future<void> sendServiceProviderData(
      {required ServiceProviderReqResModel serviceProviderReqResModel}) async {
    String uId = serviceProviderReqResModel.uid ?? "";
    Map<String, dynamic> data = serviceProviderReqResModel.toJson();
    data.remove("status");
    data.remove("did");
    await serviceProviders.doc(uId).set(data);

    data.addAll({"status": "Completed", "did": serviceProviderReqResModel.did});

    await serviceProviderRequestCollection
        .doc(serviceProviderReqResModel.did)
        .set(data);
  }

  static Future<void> rejectServiceProviderRequest(
      {required ServiceProviderReqResModel serviceProviderReqResModel}) async {
    String uId = serviceProviderReqResModel.uid ?? "";
    String email = serviceProviderReqResModel.email ?? "";
    String password = serviceProviderReqResModel.password ?? "";

    serviceProviderRequestCollection
        .doc(serviceProviderReqResModel.did)
        .update({"status": "Rejected"});

    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      await FirebaseAuth.instance.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == "requires-recent-login") {
        print(e);
      } else {
        // Handle other Firebase exceptions
        print(e);
      }
    } catch (e) {
      print(e);
      // Handle general exception
    }
  }
}
