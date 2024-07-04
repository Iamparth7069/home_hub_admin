import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  var conectionStatus = 0.obs;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (event) => _updateConnectionStatus(event),
    );
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
      return _updateConnectionStatus(result);
    } on PlatformException catch (e) {
      print("ERROR  ++++++++++$e");
    }
  }

  _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        conectionStatus.value = 1;
        print("===============>${conectionStatus.value.toString()}");
        break;
      case ConnectivityResult.mobile:
        conectionStatus.value = 2;
        print("===============>${conectionStatus.value.toString()}");
        print(conectionStatus.value.toString());

        break;
      case ConnectivityResult.none:
        conectionStatus.value = 0;
        print("===============>${conectionStatus.value.toString()}");
        print(conectionStatus.value.toString());

        break;
      default:
        Get.snackbar("Network Error", "Failed to get network connection");
        break;
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
