import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:home_hub_control_room/Firebase%20Service/repo.dart';
import 'package:home_hub_control_room/Response%20Model/offer_res_model.dart';

import 'package:home_hub_control_room/utils/extension.dart';
import 'package:image_picker/image_picker.dart';

class AddOfferScreenController extends GetxController {
  String title = "";
  String discount = "";
  String discription = "";
  String finalColorCode = "";
  Color? bgColor;
  ImagePicker imagePicker = ImagePicker();
  File? image;
  bool isSendData = false;
  List colors = [
    0xfff35f8b,
    0xffd3858e,
    0xff83b9c3,
    0xffc97738,
    0xffccbed8,
    0xff54bcd8,
    0xfffeda75,
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    bgColor = pickRandomColor();
  }

  void removeImage() {
    image = null;
    update();
  }

  Future<void> pickImage() async {
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    image = File(file!.path);
    update();
  }

  Color pickRandomColor() {
    Random random = Random();
    int index = random.nextInt(colors.length);
    int colorCode = colors[index];
    finalColorCode = colorCode.toString();
    return Color(colorCode);
  }

  void setTitle({required String value}) {
    title = value;
    update();
  }

  void setDiscount({required String value}) {
    discount = value;
    update();
  }

  void setDiscription({required String value}) {
    discription = value;
    update();
  }

  Future<String> sendImage({required String docId}) async {
    try {
      isSendData = true;
      update();

      final storageRef = FirebaseStorage.instance.ref();
      // Define the path in the Storage where you want to save the image
      final imageRef = storageRef.child("offerImage/$docId.jpg");

      // Upload the file to Firebase Storage

      if (image != null) {
        final uploadTask = imageRef.putFile(image!);

        // Wait for the upload to complete
        final snapshot = await uploadTask;

        // Get the URL of the uploaded file
        final imageUrl = await snapshot.ref.getDownloadURL();

        return imageUrl;
      } else {
        return "";
      }
    } on FirebaseException catch (e) {
      // Handle any errors
      print(e.toString());
      isSendData = false;
      update();
      return "";
    }
    return "";
  }

  Future<void> sendDataToFirebase() async {
    try {
      Map<String, dynamic> emptyMap = {};
      DocumentReference doc = await offerCollection.add(emptyMap);
      String imageUrl = await sendImage(docId: doc.id);
      OfferResModel offerResModel = OfferResModel(
          image: imageUrl,
          title: title,
          color: finalColorCode,
          createdAt: DateTime.now(),
          dId: doc.id,
          discount: discount,
          discription: discription);

      await offerCollection.doc(doc.id).set(offerResModel.toMap());
      isSendData = false;
      update();
    } on FirebaseException catch (e) {
      print("ERROR ==========>  $e");
      isSendData = false;
      update();
      showMessege(
          title: "Something Went Wrong",
          messege: "There are some Problem Please Try again");
    }
  }
}
