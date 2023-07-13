import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/login_controller.dart';
import 'package:ila/app/services/firebase_services.dart';
import 'package:ila/app/view/shared/widgets/show_snackbar.dart';
import 'package:pinput/pinput.dart';

import '../utils/constants/color_constants.dart';
import '../view/pages/auth/pages/otp_bottomsheet.dart';

class AuthService {
  LoginController loginController = Get.put(LoginController());
  String _verificationId = "";
  int? _resendToken;

  Future<void> verifyPhone(String phoneNumber) async {
    loginController.isVerifying.value = true;
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        loginController.otpCode.setText(credential.smsCode!);

        log(loginController.otpCode.text);
      },
      verificationFailed: (FirebaseAuthException e) {
        loginController.isVerifying.value = false;

        log(e.toString());
        if (e.code == 'invalid-phone-number') {
          Get.snackbar("Error", "The mobile number is not valid",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: kWarning,
              colorText: kWhite);
        } else if (e.code == 'too-many-requests') {
          Get.snackbar(
              "Error", "Too many requests from this Device. Try Again Later",
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
        loginController.isVerifying.value = false;

        Get.bottomSheet(
            backgroundColor: Get.isDarkMode ? kBlueShade : kWhite,
            elevation: 0,
            OtpBottomSheet());
        loginController.isOtpSent.value = true;
        _verificationId = verificationId;
        _resendToken = resendToken;
        loginController.startResendOtpTimer();
      },
      forceResendingToken: _resendToken,
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  Future<void> resendOtp(String phoneNumber) async {
    loginController.resendOTP.value = false;
    auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        log(e.toString());
        showSnackBar("Error", "Something Went Wrong", kWarning);
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
        loginController.isOtpSent.value = true;

        loginController.startResendOtpTimer();
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> verifyOtp(String otp) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: otp);

    // Sign the user in (or link) with the credential
    await auth.signInWithCredential(credential);
  }
}
