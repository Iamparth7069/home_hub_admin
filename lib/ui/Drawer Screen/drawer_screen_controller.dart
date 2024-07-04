import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:home_hub_control_room/ui/Offer%20Screen/offer_screen.dart';
import 'package:home_hub_control_room/ui/Payment%20Screen/payment_request_screen.dart';
import 'package:home_hub_control_room/ui/Send%20Notifications/send_notification_screen.dart';
import 'package:home_hub_control_room/ui/Service%20Provider%20Menagement/service_provider_menagement_screen.dart';
import 'package:home_hub_control_room/ui/Services%20Screen/services_screen.dart';
import 'package:home_hub_control_room/ui/Transection%20Screen/transection_screen.dart';
import 'package:home_hub_control_room/ui/home_screen/home_screen.dart';

class DrawerScreenController extends GetxController {
  final advancedDrawerController = AdvancedDrawerController();
  int screenNo = 0;
  List widgets = [
    HomeScreen(),
    const ServiceProviderMenagementScreen(),
    const ServicesScreen(),
    const OfferScreen(),
    const PaymentRequestScreen(),
    const TransectionScreen(),
    const SendNotificationScreen(),
  ];

  void setScreenNo(int value) {
    screenNo = value;
    update();
  }
}
