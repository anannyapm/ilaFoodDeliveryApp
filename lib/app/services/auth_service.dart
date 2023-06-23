import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/login_controller.dart';
import 'package:ila/app/services/firebase_services.dart';
import 'package:pinput/pinput.dart';

import '../utils/constants/color_constants.dart';
import '../view/pages/auth/pages/otp_bottomsheet.dart';

class AuthService {
  LoginController loginController = Get.put(LoginController());
  String _verificationId = "";

  Future<void> verifyPhone(String phoneNumber) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        loginController.otpCode.setText(credential.smsCode!);

        //await auth.signInWithCredential(credential);
        log(loginController.otpCode.text);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-numer') {
          Get.snackbar("Error", "The mobile number is not valid",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: kWarning,
              colorText: kWhite);
        } else {
          Get.snackbar("Error", "Something Went Wrong",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: kWarning,
              colorText: kWhite);
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        
        Get.bottomSheet(
            backgroundColor: kWhite, elevation: 0, OtpBottomSheet());
        _verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  Future<void> verifyOtp(String otp) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: otp);

    // Sign the user in (or link) with the credential
    await auth.signInWithCredential(credential);
  }
}
