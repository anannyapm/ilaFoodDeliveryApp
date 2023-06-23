import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/auth_controller.dart';
import 'package:ila/app/controller/login_controller.dart';
import 'package:ila/app/utils/constants/constants.dart';
import 'package:pinput/pinput.dart';

import '../../../../utils/constants/color_constants.dart';
import '../../../shared/widgets/customtext.dart';

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
                          onPressed: () => Get.back(),
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
                  const Row(
                    children: [
                      CustomText(
                        text: "Code",
                        size: 18,
                      )
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
                    controller:loginController.otpCode ,
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
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      authController.verifyOTP();
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        backgroundColor: kGreen,
                        padding: const EdgeInsets.all(15),
                        elevation: 0),
                    child: Text(
                      "SUBMIT",
                      style: TextStyle(
                          color: kWhite,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              kHeightBox20
            ],
          ),
        ),
      ),
    );
  }
}
