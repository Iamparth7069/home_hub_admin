import 'package:get/get.dart';
import 'package:home_hub_control_room/ui/Drawer%20Screen/drawer_screen.dart';
import 'package:home_hub_control_room/ui/Login%20Screen/login_screen.dart';
import 'package:home_hub_control_room/ui/Offer%20Screen/add_offer_screen.dart';
import 'package:home_hub_control_room/ui/Payment%20Screen/payment_request_screen.dart';
import 'package:home_hub_control_room/ui/Service%20Provider%20Menagement/service_provider_menagement_screen.dart';
import 'package:home_hub_control_room/ui/Service%20Provider%20Menagement/service_provider_profile_screen.dart';
import 'package:home_hub_control_room/ui/Services%20Screen/services_screen.dart';

import 'package:home_hub_control_room/ui/SplashScreen/splash_screen.dart';
import 'package:home_hub_control_room/ui/no%20Internet/no_internet_screen.dart';

import '../ui/Offer Screen/offer_screen.dart';

class Routes {
  static String splashScreen = "/";
  static String loginScreen = "/loginScreen";
  static String servicesScreen = "/ServicesScreen";
  static String serviceProviderMenagementScreen =
      "/serviceProviderMenagementScreen";
  static String serviceProviderProfileScreen = "/serviceProviderProfileScreen";
  static String drawerScreen = "/drawerScreen";
  static String offerScreen = "/offerScreen";
  static String addOfferScreen = "/addOfferScreen";
  static String checkInternetScreen = "/checkInternetScreen";
  static String paymentRequestScreen = "/paymentRequestScreen";

  static final getPages = [
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(
        name: serviceProviderMenagementScreen,
        page: () => const ServiceProviderMenagementScreen()),
    GetPage(
        name: serviceProviderProfileScreen,
        page: () => const ServiceProviderProfileScreen()),
    GetPage(name: servicesScreen, page: () => const ServicesScreen()),
    GetPage(name: drawerScreen, page: () => const DrawerScreen()),
    GetPage(name: offerScreen, page: () => const OfferScreen()),
    GetPage(name: addOfferScreen, page: () => const AddOfferScreen()),
    GetPage(name: checkInternetScreen, page: () => const CheckInternetScreen()),
    GetPage(
        name: paymentRequestScreen, page: () => const PaymentRequestScreen()),
  ];
}
