import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:home_hub_control_room/constant/app_assets.dart';
import 'package:home_hub_control_room/utils/app_routes.dart';
import 'package:home_hub_control_room/utils/extension.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPassshow = true;
  final key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: key,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: SvgPicture.asset(
                    "assets/images/svg/login.svg",
                    height: 40.h,
                  ),
                ),
                "Login Now"
                    .boldOpenSans(fontColor: Colors.black, fontSize: 20.sp),
                SizedBox(
                  height: 5.h,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || !AppAssets.isvalidemail(value)) {
                      return "Enter the Valid Email";
                    } else {
                      return null;
                    }
                  },
                  controller: emailController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Email",
                    filled: true,
                    fillColor: Colors.grey[100],
                    prefixIcon: const Icon(Icons.email),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: isPassshow,
                  validator: (value) {
                    if (value == null || !AppAssets.isvalidpassword(value)) {
                      return "Enter the validPassword";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "Password",
                      filled: true,
                      fillColor: Colors.grey[100],
                      prefixIcon: const Icon(Icons.password),
                      suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isPassshow = !isPassshow;
                            });
                          },
                          child: Icon(isPassshow == false
                              ? Icons.visibility_off
                              : Icons.remove_red_eye_sharp))),
                ),
                SizedBox(
                  height: 15.h,
                ),
                appButton(
                    onTap: () {
                      if (key.currentState!.validate()) {
                        if (emailController.text.trim() != "admin@gmail.com") {
                          print("Please Enter valid email address");
                          showMessege(
                              title: "Login Failed",
                              messege: "Please Enter valid email address");
                        } else if (passwordController.text.trim() !=
                            "Admin@123") {
                          print("Please Enter valid email address");
                          showMessege(
                              title: "Login Failed",
                              messege: "Please Enter valid password");
                        } else {
                          ///Navigate to home page
                          Get.offAllNamed(Routes.drawerScreen);
                        }
                      }
                    },
                    fontColor: Colors.white,
                    fontSize: 12.sp,
                    text: "Login")
              ],
            ),
          )),
    );
  }
}
