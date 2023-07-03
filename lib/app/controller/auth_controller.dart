import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/login_controller.dart';
import 'package:ila/app/controller/map_controller.dart';
import 'package:ila/app/controller/user_controller.dart';
import 'package:ila/app/model/usermodel.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/utils/constants/controllers.dart';
import 'package:ila/app/view/pages/auth/pages/otp_auth_page.dart';
import 'package:ila/app/view/pages/auth/pages/register_page.dart';
import 'package:ila/app/view/pages/home/pages/navigationpage.dart';
import 'package:ila/app/view/pages/onboarding/pages/onboard_screen.dart';
import 'package:ila/app/view/shared/pages/account_disable_page.dart';
import 'package:ila/app/view/shared/widgets/show_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth_service.dart';
import '../services/firebase_services.dart';

class AuthController extends GetxController {
  LoginController loginController = Get.put(LoginController());
  MapController mapController = Get.put(MapController());
  UserController userController = Get.put(UserController());

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

  String? deviceKey = "";
  var serverKey =
      "AAAAkdAjUMs:APA91bHF0G4nK69zeXiwOCNrC1-YBdHRl-Y-F_DMGgJ4MAljq_Iwt5fhAZT_4zQPvNpwGFyiZQhogxpsS8bPs0m3dHKQZS1jTbbISOPaUqm9ASqwZ-n3IeNlgHXKRye2SFxPb1VUWHye";

  getDeviceKey() async {
    try {
      deviceKey = await FirebaseMessaging.instance.getToken();
    } catch (e) {
      log("could not get the key");
    }
    if (deviceKey!.isNotEmpty) {
      log(deviceKey!);
    }
  }

  Future initialScreen() async {
    await Future.delayed(const Duration(seconds: 5));
    getDeviceKey();
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
    homeController.getAllCarousel();

    homeController.getAllCategory();

    homeController.initializeRestaurants();

    homeController.getAllProducts();
    await userController.getUserAddress();
    log(userController.userModel.toString());
    cartController.getCartList();
    cartController.getTotalPrice();
    log("cart");
    await orderController.getAllOrders();
    orderController.getOngoingOrders();
    orderController.getOrderHistory();
    if (cartController.cartList.isNotEmpty) {
      await cartController.setCurrentRestaurant();
    }
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
    userController.setUser(UserModel(
        phoneNumber: phoneNumber,
        location: [GeoPoint(mapController.lat, mapController.long)],
        address: [mapController.locationAddress],
        completeAddress: [mapController.completeAddress],
        name: loginController.name,
        email: loginController.email,
        userCart: List.empty(),
        favoriteList: List.empty(),
        discounts: cartController.selectedDiscount.value));

    await userCollectionRef
        .doc(firebaseUser.value!.uid)
        .set(userController.userModel.toSnapshot());
    isUserAdding.value = false;

    mapController.clearfields();

    await fetchAllData();
    //log("${userModel.name} ${userModel.phoneNumber} ${userModel.location}");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('USER_LOGGED', true);
  }

  Future<void> logout() async {
    await auth.signOut();
    Get.offAll(() => const OtpAuthPage());
  }
}
