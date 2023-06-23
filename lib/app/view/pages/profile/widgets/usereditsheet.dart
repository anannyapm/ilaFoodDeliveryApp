import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/auth_controller.dart';
import 'package:ila/app/controller/login_controller.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/utils/constants/constants.dart';
import 'package:ila/app/view/shared/widgets/customtext.dart';
import 'package:ila/app/view/shared/widgets/customtextformfield.dart';

class UserEditSheet extends StatelessWidget {
  UserEditSheet({super.key});
  final LoginController loginController = Get.put(LoginController());
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController(text:authController.userModel.name!);
    TextEditingController emailController = TextEditingController(text:authController.userModel.email!);
    TextEditingController phoneController = TextEditingController(text:authController.userModel.phoneNumber!);
    return SingleChildScrollView(
      child: Container(
        //decoration: const BoxDecoration(boxShadow: [BoxShadow(offset: Offset(0, 4))]),
        child: GetBuilder<AuthController>(
          init: AuthController(),
          builder: (controller) {
            return Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kHeightBox10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(text: "My Profile",size: 20,),
                      IconButton(onPressed: ()=>Get.back(), icon: const Icon(Icons.close))
                    ],
                  ),
                  kHeightBox20,
                  CustomTextFormField(
                      textColor: kBlueShade,
                      hint: "",
                      label:"Name",
                      textcontroller: nameController,
                      function: () {}),
                  CustomTextFormField(
                    readonly: true,
                      textColor: kBlueShade,
                      hint: "",
                      label:"Phone Number",
                      textcontroller: phoneController,
                      function: () {}),
                  CustomTextFormField(
                      textColor: kBlueShade,
                      hint: "",
                      label: "Email",
                      textcontroller: emailController,
                      function: () {}),
                      kHeightBox20,
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: ()  {
                             
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                backgroundColor:
                                    kGreen,
                                padding: const EdgeInsets.all(15),
                                elevation: 0),
                            child: Text(
                              "DONE",
                              style: TextStyle(
                                  color: kWhite,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      kHeightBox20
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
