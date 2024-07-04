import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:home_hub_control_room/utils/app_routes.dart';

class SplashScreenController extends GetxController {
  String displayText = '';
  int index = 0;
  final String _fullText = 'Help Harbor';

  @override
  void onInit() {
    super.onInit();

    _navigate();
  }

  void _navigate() {
    final box = GetStorage();
    Future.delayed(const Duration(seconds: 3)).then(
      (value) {
        Get.offNamed(Routes.loginScreen);
      },
    );
  }
}
