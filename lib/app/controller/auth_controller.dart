import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/login_controller.dart';
import 'package:ila/app/controller/mapcontroller.dart';
import 'package:ila/app/model/usermodel.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/view/pages/auth/pages/otp_auth_page.dart';
import 'package:ila/app/view/pages/auth/pages/registerpage.dart';
import 'package:ila/app/view/pages/home/pages/navigationpage.dart';
import 'package:ila/app/view/pages/onboarding/pages/onboard_screen.dart';
import 'package:ila/app/view/shared/pages/accountdisable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth_service.dart';
import '../services/firebase_services.dart';

class AuthController extends GetxController {
  LoginController loginController = Get.put(LoginController());
  MapController mapController = Get.put(MapController());

  AuthService authService = AuthService();

  //generates an instance
  static AuthController instance = Get.find();

  // It represents the current user's authentication state.
  late Rx<User?> firebaseUser;

  UserModel? _userModel;
  UserModel get userModel => _userModel!;

  RxBool isUserAdding = false.obs;

  

  @override
  void onInit() {
    super.onInit();
    userCollectionRef = firebaseFirestore.collection("users");
  }

  @override
  void onReady() {
    super.onReady();
    initialScreen();
/* 
    By using Rx<User?>, any changes to the current user's authentication state
    will be automatically propagated through the firebaseUser stream, 
    allowing you to reactively handle user authentication changes in your
     application. */

    firebaseUser = Rx<User?>(auth.currentUser);

    //bindstream ==> to make firebaseuser like an observer. It will be now
    //notified when there will be change in user information
    //binding userchange to firebaseuser and firebaseuser will be notified
    firebaseUser.bindStream(auth.userChanges());

    //ever is called everytime firebaseuser changes
    //ever(firebaseUser, initialScreen);
  }

  Future initialScreen() async {
    await Future.delayed(const Duration(seconds: 5));
    if (firebaseUser.value == null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.getBool('USER_LOGGED') == true) {
        Get.offAll(() => const OtpAuthPage());
      } else {
        log("No user logged in. Navigating to Login Page");
        Get.offAll(() => OnBoardingScreenOne());
      }
    } else {
      bool existStatus = await checkIfUserExist(); //check if user in db
      if (existStatus == true) {
        if (userModel.activeStatus == true) {
          Get.offAll(() => NavigationPage());
        } else {
          await auth
              .signOut(); //signout as on otp entering account gets logged in

          Get.offAll(() => const DisbledPage());
        }
      } else {
        Get.offAll(OnBoardingScreenOne());
      }
    }
  }

  Future<void> verifyPhoneNumber() async {
    String phoneNumber = loginController.selectedCode +
        loginController.textEditingController.text.trim();
    await authService.verifyPhone(phoneNumber);
  }

  Future<void> verifyOTP() async {
    try {
      await authService.verifyOtp(loginController.otpCode.text);
      //change it accordingly to go to reg or home after adding user in db
      final checkUserExist = await checkIfUserExist();
      if (checkUserExist == false) {
        Get.off(() => RegisterPage());
      } else {
        log("${userModel.name} ${userModel.phoneNumber} ${userModel.location}");
        if (userModel.activeStatus == false) {
          await auth.signOut();

          Get.offAll(() => const DisbledPage());
        } else {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('USER_LOGGED', true);
          Get.offAll(() => NavigationPage());
        }
      }
    } catch (e) {
      log(e.toString());
      Get.snackbar("Error", "Something Went Wrong",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: kWarning,
          colorText: kWhite);
    }
  }

  Future<bool> checkIfUserExist() async {
    DocumentSnapshot snapshot =
        await userCollectionRef.doc(firebaseUser.value!.uid).get();
    if (snapshot.exists) {
      _userModel = UserModel.fromSnapshot(snapshot);

      log("User Exist");

      return true;
    } else {
      log("User Do Not Exist");

      return false;
    }
  }

  Future<void> addUserToFirebase(
      /* {required GeoPoint location,
      required String address,
      String? name,
      String? email} */
      ) async {
    isUserAdding.value = true;
    String phoneNumber = firebaseUser.value!.phoneNumber!;
    _userModel = UserModel(
        phoneNumber: phoneNumber,
        location: [GeoPoint(mapController.lat, mapController.long)],
        address: [mapController.location],
        name: loginController.name,
        email: loginController.email,
        userCart: List.empty(),
        favoriteList: List.empty());

    await userCollectionRef
        .doc(firebaseUser.value!.uid)
        .set(userModel.toSnapshot());
    isUserAdding.value = false;
    log("${userModel.name} ${userModel.phoneNumber} ${userModel.location}");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('USER_LOGGED', true);
  }

  Future<void> logout() async {
    await auth.signOut();
    Get.offAll(const OtpAuthPage());
  }
}
