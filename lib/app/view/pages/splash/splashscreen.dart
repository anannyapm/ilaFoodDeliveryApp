import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/utils/constants/constants.dart';
import 'package:lottie/lottie.dart';

import '../../../controller/auth_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthController authcontroller = Get.put(AuthController()); //DI

  @override
  void initState() {
    super.initState();
  }

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
              bottom: size.height *0.01,
              
              child: Lottie.asset('assets/animations/delivery.json',height: 250),),
            
          
         
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
