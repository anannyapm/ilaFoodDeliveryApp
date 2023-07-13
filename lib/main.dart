import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:ila/app/controller/cart_controller.dart';
import 'package:ila/app/controller/home_controller.dart';
import 'package:ila/app/controller/order_controller.dart';
import 'package:ila/app/controller/notification_controller.dart';
import 'package:ila/app/controller/user_controller.dart';
import 'package:ila/app/utils/constants/app_detail.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/utils/constants/controllers.dart';
import 'package:ila/app/view/pages/splash/splash_screen.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'app/controller/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Remove this method to stop OneSignal Debugging
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.setAppId("1b46573c-99fb-4700-865a-5e1fbe851a01");

// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    log("Accepted permission: $accepted");
  });

  //authcontroller will be avilable to our app from everywhere
  await Firebase.initializeApp().then(
    (value) {
      Get.put(AuthController());
      Get.put(UserController());
      Get.put(CartController());
      Get.put(OrderController());
      Get.put(HomeController());
      Get.put(NotificationController());
    },
  );
  //Get.put(UserController());
  // await notificationController.initNotifications();
  await notificationController.initializeOneSignal();

  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  AppDetails.appVersion = packageInfo.version;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Ila App',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: kGreen,
        scaffoldBackgroundColor: kBlack,
        tabBarTheme: TabBarTheme(dividerColor: kOrange)
      ),
    
      
      theme: ThemeData(
       
        fontFamily: GoogleFonts.sen().fontFamily,
        scaffoldBackgroundColor: kWhite,
        colorScheme: ColorScheme.fromSeed(seedColor: kGreen),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
