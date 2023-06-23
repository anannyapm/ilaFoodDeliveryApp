import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/utils/constants/constants.dart';
import 'package:lottie/lottie.dart';

import '../../../controller/auth_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //final AuthController authcontroller = Get.put(AuthController()); //DI

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Center(
            child: Image.asset(
              'assets/images/logo.png',
            ),
          ),
          Positioned(
              bottom: size.height *0.86,
              left: size.width *0.8,
              child: Lottie.asset('assets/animations/anim1.json',height: 100),),
          Positioned(
              top: size.height * 0.7,
              right: size.width * 0.4,
              child: Lottie.asset('assets/animations/anim1.json',height: 300)),
          
         
        ]),
        /* Align(
              alignment: Alignment.bottomCenter,
          child: Lottie.asset(
            'assets/animations/food.json',
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
        ), */
      ),
    );
  }
}
