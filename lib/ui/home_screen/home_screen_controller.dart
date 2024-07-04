import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  Map<String, dynamic> userData = {};
  bool isLoading = false;
  int totalOrders = 0;
  int totalUsers = 0;
  int totalProviders = 0;
  @override
  onInit() {
    getData();
    super.onInit();
  }

  Future<void> getData() async {
    isLoading = true;
    update();
    Stream<QuerySnapshot> ordersData = FirebaseFirestore.instance
        .collection("Orders")
        .where("status", isNotEqualTo: "Cancel")
        .snapshots();
    ordersData.listen((event) {
      totalOrders = event.docs.length;
      update();
    });
    Stream<QuerySnapshot> uData =
        FirebaseFirestore.instance.collection("User").snapshots();
    uData.listen((event) {
      totalUsers = event.docs.length;
      update();
    });
    Stream<QuerySnapshot> pData =
        FirebaseFirestore.instance.collection("service_providers").snapshots();
    pData.listen((event) {
      totalProviders = event.docs.length;
      update();
    });
    Stream<DocumentSnapshot> data = FirebaseFirestore.instance
        .collection("Admin")
        .doc("adminData")
        .snapshots();
    data.listen((event) {
      userData = {};
      userData = event.data() as Map<String, dynamic>;
      isLoading = false;
      update();
    });
  }
}
