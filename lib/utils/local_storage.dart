import 'package:get_storage/get_storage.dart';

class LocalStorage {
  static final box = GetStorage();

  static String uid = "uId";
  static String userData = "userData";
  static String fcmToken = "fcmToken";
  static String otp = "otp";

  static Future<void> sendUserId({required String userId}) async {
    await box.write(uid, userId);
  }

  static Future getUserId() async {
    String userId = await box.read(uid);
    return userId;
  }

  static Future<void> sendFcmToken({required String fcm}) async {
    await box.write(fcmToken, fcm);
  }

  static Future getFcmToken() async {
    String fcm = await box.read(fcmToken);

    return fcm;
  }

  static Future<void> sendOtp({required String value}) async {
    await box.write(otp, value);
  }

  static Future getOtp() async {
    String value = await box.read(otp);

    return value;
  }
}
