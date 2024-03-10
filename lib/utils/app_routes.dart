import 'package:get/get.dart';
import 'package:home_hub_admin/ui/SplashScreen/splash_screen.dart';

class Routes {
  static String splashScreen = "/";

  static final getPages = [
    GetPage(name: splashScreen, page: () => SplashScreen()),
  ];
}
