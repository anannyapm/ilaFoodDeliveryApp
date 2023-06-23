import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ila/app/controller/login_controller.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/utils/constants/constants.dart';
import 'package:ila/app/view/pages/location/locationpage.dart';

import '../../../shared/widgets/customtext.dart';
import '../../../shared/widgets/customtextformfield.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final LoginController loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: Text(
                    "Skip",
                    style: TextStyle(
                        color: kOrange,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  onPressed: () => Get.to(() => LocationPage()),
                )
              ],
            ),
          ),
          kHeightBox20,
          Form(
            key: loginController.formKey2,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    text: "Welcome Aboard",
                    lines: 3,
                    size: 25,
                    weight: FontWeight.w900,
                    align: TextAlign.left,
                  ),
                  CustomText(
                    text: "Complete your profile to continue",
                    lines: 3,
                    size: 18,
                    color: kGreyDark,
                    weight: FontWeight.w400,
                    align: TextAlign.left,
                  ),
                  kHeightBox20,
                  CustomTextFormField(
                    function: loginController.checkRegField,
                    hint: 'Name',
                    label: "Name",
                    type: TextInputType.text,
                    textcontroller: loginController.nameController,
                  ),
                  kHeightBox20,
                  CustomTextFormField(
                    function: loginController.checkRegField,
                    hint: 'Email',
                    label: "Email",
                    type: TextInputType.emailAddress,
                    textcontroller: loginController.emailController,
                  ),
                  kHeightBox20,
                  kHeightBox20,
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Obx(() => ElevatedButton(
                        onPressed: () async {
                          Get.to(() => LocationPage());
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            backgroundColor:
                                loginController.isButtonEnabled.value
                                    ? kGreen
                                    : kGreen.withOpacity(0.4),
                            padding: const EdgeInsets.all(15),
                            elevation: 0),
                        child: Text(
                          "SUBMIT",
                          style: TextStyle(
                              color: kWhite,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ))),
                  )
                ],
              ),
            ),
          ),
          kHeightBox10,
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                // height: MediaQuery.of(context).size.height * 0.4,
                width: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/food4.png"),
                        fit: BoxFit.fitWidth)),
              ),
            ),
          )
        ],
      )),
    );
  }
}
