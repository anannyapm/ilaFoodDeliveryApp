import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/auth_controller.dart';
import 'package:ila/app/controller/login_controller.dart';
import 'package:ila/app/utils/constants/constants.dart';
import 'package:ila/app/view/shared/widgets/custom_button.dart';
import 'package:pinput/pinput.dart';

import '../../../../utils/constants/color_constants.dart';
import '../../../shared/widgets/custom_text.dart';

class OtpBottomSheet extends StatelessWidget {
  OtpBottomSheet({super.key});

  final LoginController loginController = Get.put(LoginController());
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              kHeightBox10,
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            loginController.otpCode.clear();
                            Get.back();
                          },
                          icon: const Icon(Icons.close)),
                    ],
                  ),
                  const CustomText(
                    text: "Verification",
                    lines: 3,
                    size: 30,
                    weight: FontWeight.w900,
                    align: TextAlign.left,
                  ),
                  CustomText(
                    text: "Please enter the 6 digit code here",
                    color: kGreyDark,
                    size: 15,
                    weight: FontWeight.w400,
                    align: TextAlign.left,
                  ),
                  kHeightBox10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(
                        text: "Code",
                        size: 18,
                      ),
                      Obx(() => TextButton(
                          onPressed: () => loginController.resendOTP.value
                              ? authController.resendOtp()
                              : null,
                          child: CustomText(
                            text: loginController.resendOTP.value
                                ? "Resend Code"
                                : "${loginController.resendAfter} seconds",
                            color: kBlueShade,
                            weight: FontWeight.bold,
                          )))
                    ],
                  ),
                  kHeightBox20,
                  Pinput(
                    androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
                    submittedPinTheme: PinTheme(
                        textStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: kOrange.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(8))),
                    defaultPinTheme: PinTheme(
                        textStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: kLightBlue,
                            borderRadius: BorderRadius.circular(8))),
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    autofocus: true,
                    controller: loginController.otpCode,
                    length: 6,
                    onChanged: (otp) {
                      loginController.otpCode.text = otp;
                      log(loginController.otpCode.text);
                    },
                  ),
                  kHeightBox20,
                  kHeightBox10,
                ],
              ),
              Obx(
                () => authController.isLoading.value == true
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                      padding: 15,
                      text: CustomText(
                        text: "SUBMIT",
                        color: kWhite,
                        size: 18,
                        weight: FontWeight.bold,
                      ),
                      function: () {
                        authController.verifyOTP();
                      },
                      color: kGreen)),),
              kHeightBox20
            ],
          ),
        ),
      ),
    );
  }
}
