import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/utils/constants/constants.dart';
import 'package:ila/app/view/pages/onboarding/pages/onboard_screen.dart';
import 'package:ila/app/view/shared/widgets/custom_text.dart';

class DisbledPage extends StatelessWidget {
  const DisbledPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(onPressed: ()=>Get.offAll(()=>OnBoardingScreenOne()), icon: Icon(Icons.close,color: kWarning,))
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/error.png'))),
              ),
              CustomText(
                text: "OOPS! Your Access is Denied.",
                weight: FontWeight.bold,
                color: kWarning,
                size: 24,
                align: TextAlign.center,
              ),
              kHeightBox10,
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text:  TextSpan(
                    text: 'If you think this is a mistake, contact our team at ',
                    style: TextStyle(
                      color: kGreyDark,
                      fontSize: 18,
                      
                    ),
                    children: [
                      TextSpan(
                        text: 'customerservices@ila.com',
                        style: TextStyle(
                          color: kGreen,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}
