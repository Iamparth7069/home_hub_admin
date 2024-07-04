import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:home_hub_control_room/Firebase%20Service/repo.dart';

class TransectionScreenController extends GetxController {
  List<Map<String, dynamic>> trData = [];
  List<Map<String, dynamic>> trUserData = [];
  @override
  onInit() {
    super.onInit();
    getAllTransections();
  }

  Future<void> getAllTransections() async {
    Stream<QuerySnapshot> data =
        transectionCollection.orderBy("time", descending: true).snapshots();
    data.listen((event) {
      event.docs.forEach((element) async {
        Map<String, dynamic> mapData = element.data() as Map<String, dynamic>;
        if (mapData["type"] == "Payment") {
          Map<String, dynamic> userData =
              await getUserData(userId: mapData["from"]);
          trUserData.add(userData);
        } else if (mapData["type"] == "Withdraw") {
          Map<String, dynamic> userData =
              await getServiceProviderData(userId: mapData["to"]);
          trUserData.add(userData);
        } else {
          Map<String, dynamic> userData =
              await getUserData(userId: mapData["to"]);
          trUserData.add(userData);
        }
        trData.add(mapData);
        update();
      });
    });
  }

  Future<Map<String, dynamic>> getUserData({required String userId}) async {
    DocumentSnapshot data = await userCollection.doc(userId).get();

    return data.data() as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> getServiceProviderData(
      {required String userId}) async {
    DocumentSnapshot data = await serviceProviders.doc(userId).get();

    return data.data() as Map<String, dynamic>;
  }
}
