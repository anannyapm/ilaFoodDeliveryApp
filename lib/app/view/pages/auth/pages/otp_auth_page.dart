import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/auth_controller.dart';
import 'package:ila/app/controller/login_controller.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/utils/constants/constants.dart';
import 'package:ila/app/view/pages/auth/widgets/country_selector.dart';
import 'package:ila/app/view/shared/widgets/custom_button.dart';
import 'package:ila/app/view/shared/widgets/custom_text.dart';

import '../../../shared/widgets/custom_textformfield.dart';

class OtpAuthPage extends StatelessWidget {
  const OtpAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.put(LoginController());
    AuthController authController = Get.put(AuthController());
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
          child: Form(
            key: loginController.formKey1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                kHeightBox60,
                Column(
                  children: [
                    const CustomText(
                      text: "Enter your mobile number to get OTP",
                      lines: 3,
                      size: 25,
                      weight: FontWeight.w900,
                      align: TextAlign.left,
                    ),
                    kHeightBox20,
                    CountryCodeWidget(),
                    kWidthBox20,
                    CustomTextFormField(
                      onchanged: loginController.checkField,
                      hint: 'Mobile Number',
                      label: "Mobile Number",
                      type: TextInputType.phone,
                      textcontroller: loginController.textEditingController,
                    ),
                    kHeightBox20,
                    kHeightBox20,
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Obx(() => CustomButton(
                          padding: 15,
                          text: loginController.isVerifying.value
                              ?  Center(
                                  child: CircularProgressIndicator(color: kWhite,),
                                )
                              : CustomText(
                                  text: "GET OTP",
                                  color: kWhite,
                                  size: 18,
                                  weight: FontWeight.bold,
                                ),
                          function: () async {
                            loginController.isLogButtonEnabled.value
                                ? await authController.verifyPhoneNumber()
                                : log("Not verified");
                          },
                          color: loginController.isLogButtonEnabled.value
                              ? kGreen
                              : kGreen.withOpacity(0.4))),
                    )
                  ],
                ),
                kHeightBox10,
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/food1.png"),
                            fit: BoxFit.cover)),
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
