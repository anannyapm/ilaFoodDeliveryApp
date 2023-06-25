import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/view/pages/splash/splashscreen.dart';

import 'app/controller/auth_controller.dart';
import 'app/controller/homecontroller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //authcontroller will be avilable to our app from everywhere
  await Firebase.initializeApp().then(
    (value) => Get.put(AuthController()),
  );
  //Get.put(HomeController());

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
      theme: ThemeData(
        fontFamily: GoogleFonts.sen().fontFamily,
        scaffoldBackgroundColor: kWhite,
        colorScheme: ColorScheme.fromSeed(seedColor: kGreen),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
