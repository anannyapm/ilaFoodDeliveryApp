import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../controller/auth_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final AuthController authcontroller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(children: [
          Center(
            child: Image.asset(
              'assets/images/logo.png',
            ),
          ),
          Positioned(
            bottom: size.height * 0.01,
            child: Lottie.asset('assets/animations/delivery.json', height: 250),
          ),
        ]),
      ),
    );
  }
}
