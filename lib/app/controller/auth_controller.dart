import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/login_controller.dart';
import 'package:ila/app/controller/map_controller.dart';
import 'package:ila/app/model/usermodel.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/utils/constants/controllers.dart';
import 'package:ila/app/view/pages/auth/pages/otp_auth_page.dart';
import 'package:ila/app/view/pages/auth/pages/register_page.dart';
import 'package:ila/app/view/pages/home/pages/navigationpage.dart';
import 'package:ila/app/view/pages/onboarding/pages/onboard_screen.dart';
import 'package:ila/app/view/shared/pages/account_disable_page.dart';
import 'package:ila/app/view/shared/widgets/show_snackbar.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
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

  RxBool isUserAdding = false.obs;
  RxBool isLoading = false.obs;
  RxBool isVerifying = false.obs;

  @override
  void onInit() {
    super.onInit();
    userCollectionRef = firebaseFirestore.collection("users");
  }

  @override
  void onReady() {
    super.onReady();
    initialScreen();

    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
  }

  String? deviceKey = "";
  var serverKey =
      "AAAAkdAjUMs:APA91bHF0G4nK69zeXiwOCNrC1-YBdHRl-Y-F_DMGgJ4MAljq_Iwt5fhAZT_4zQPvNpwGFyiZQhogxpsS8bPs0m3dHKQZS1jTbbISOPaUqm9ASqwZ-n3IeNlgHXKRye2SFxPb1VUWHye";

  Future<void> getDeviceKey() async {
    try {
      final status = await OneSignal.shared.getDeviceState();
      final tokenId = status?.userId;
      log(tokenId.toString());
      deviceKey = tokenId ?? "";
    } catch (e) {
      log("could not get the key");
    }
    if (deviceKey!.isNotEmpty) {
      log(deviceKey!);
    }
  }

  Future initialScreen() async {
    await Future.delayed(const Duration(seconds: 5));
    await getDeviceKey();
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
        if (userController.userModel.activeStatus == true) {
          await fetchAllData();

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
    isVerifying.value = true;
    String phoneNumber = loginController.selectedCode +
        loginController.textEditingController.text.trim();
    await authService.verifyPhone(phoneNumber);
    isVerifying.value = false;
  }

  Future<void> fetchAllData() async {
    await userController.reloadUserData();
    homeController.getAllCarousel();

    homeController.getAllCategory();

    homeController.initializeRestaurants();

    homeController.getAllProducts();
    await userController.getUserAddress();

    await cartController.getCartList();
    await cartController.calculateDiscount();

    await orderController.getAllOrders();
    orderController.getOngoingOrders();
    orderController.getOrderHistory();
    if (cartController.cartList.isNotEmpty) {
      await cartController.setCurrentRestaurant();
    }
    cartController.getTotalPrice();
  }

  Future<void> verifyOTP() async {
    try {
      if (loginController.otpCode.text.length < 6) {
        showSnackBar("Error", "Please enter the 6 digit code", kWarning);
        return;
      }
      isLoading.value = true;
      await authService.verifyOtp(loginController.otpCode.text);

      final checkUserExist = await checkIfUserExist();

      isLoading.value = false;
      loginController.otpCode.clear();

      if (checkUserExist == false) {
        Get.off(() => RegisterPage());
      } else {
        log("${userController.userModel.name} ");
        if (userController.userModel.activeStatus == false) {
          await auth.signOut();

          Get.offAll(() => const DisbledPage());
        } else {
          SharedPreferences prefs = await SharedPreferences.getInstance();

          prefs.setBool('USER_LOGGED', true);

          await fetchAllData();

          Get.offAll(() => NavigationPage());
        }
      }
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      log(e.toString());

      if (e.code == "invalid-verification-code") {
        showSnackBar("Error", "Invalid OTP/Verification Code", kWarning);
      } else {
        showSnackBar("Error", "Something Went Wrong!", kWarning);
      }
    } catch (e) {
      isLoading.value = false;

      log(e.toString());
      showSnackBar("Error", "Something Went Wrong!", kWarning);
    }
  }

  Future<void> resendOtp() async {
    String phoneNumber = loginController.selectedCode +
        loginController.textEditingController.text.trim();

    await authService.resendOtp(phoneNumber);
  }

  Future<bool> checkIfUserExist() async {
    DocumentSnapshot snapshot =
        await userCollectionRef.doc(firebaseUser.value!.uid).get();
    if (snapshot.exists) {
      userController.setUser(UserModel.fromSnapshot(snapshot));
      await changeDeviceKey(deviceKey, userController.userModel.userId);

      log("User Exist");

      return true;
    } else {
      log("User Do Not Exist");

      return false;
    }
  }

  Future<void> addUserToFirebase() async {
    isUserAdding.value = true;
    String phoneNumber = firebaseUser.value!.phoneNumber!;
    await userController.setUser(UserModel(
        phoneNumber: phoneNumber,
        location: [GeoPoint(mapController.lat, mapController.long)],
        address: [mapController.locationAddress],
        completeAddress: [mapController.completeAddress],
        name: loginController.name,
        email: loginController.email,
        userCart: List.empty(growable: true),
        favoriteList: List.empty(growable: true),
        discounts: cartController.selectedDiscount.value,
        deviceKey: deviceKey,
        receiveNotification: true));

    await userCollectionRef
        .doc(firebaseUser.value!.uid)
        .set(userController.userModel.toSnapshot());
    userController.userModel.userId = firebaseUser.value!.uid;
    isUserAdding.value = false;

    log(userController.userModel.userId!);

    await fetchAllData();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('USER_LOGGED', true);

    prefs.setBool('DARK_THEME', false);
    mapController.clearfields();
  }

  Future<void> changeDeviceKey(String? deviceKey, String? userID) async {
    final userDocRef = userCollectionRef.doc(userID);
    final userSnapshot = await userDocRef.get();

    if (userSnapshot.exists) {
      final userDeviceKey = userSnapshot['deviceKey'];
      if (userDeviceKey != deviceKey) {
        await userDocRef.update({'deviceKey': deviceKey});
        userController.userModel.deviceKey = deviceKey;
      }
    }
  }

  Future<void> logout() async {
    await auth.signOut();
    Get.offAll(() => const OtpAuthPage());
  }
}
