import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/auth_controller.dart';
import 'package:ila/app/controller/login_controller.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/utils/constants/constants.dart';
import 'package:ila/app/view/shared/widgets/custom_text.dart';
import 'package:ila/app/view/shared/widgets/custom_textformfield.dart';
import 'package:ila/app/view/shared/widgets/show_snackbar.dart';

import '../../../../controller/user_controller.dart';
import '../../../shared/widgets/custom_button.dart';

class UserEditSheet extends StatelessWidget {
  UserEditSheet({super.key});
  final formKey4 = GlobalKey<FormState>();

  final LoginController loginController = Get.put(LoginController());
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController =
        TextEditingController(text: userController.userModel.name!);
    TextEditingController emailController =
        TextEditingController(text: userController.userModel.email!);
    TextEditingController phoneController =
        TextEditingController(text: userController.userModel.phoneNumber!);
    return SingleChildScrollView(
      child: GetBuilder<AuthController>(
        init: AuthController(),
        builder: (controller) {
          return Container(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: formKey4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kHeightBox10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(
                        text: "My Profile",
                        size: 20,
                      ),
                      IconButton(
                          onPressed: () => Get.back(),
                          icon: const Icon(Icons.close))
                    ],
                  ),
                  kHeightBox20,
                  CustomTextFormField(
                    textColor: kBlueShade,
                    hint: "",
                    label: "Name",
                    textcontroller: nameController,
                    
                  ),
                  CustomTextFormField(
                      readonly: true,
                      textColor: kBlueShade,
                      hint: "",
                      label: "Phone Number",
                      textcontroller: phoneController,
                      ontap: () {
                        showSnackBar(
                            "Pss!", "This field can't be edited", kWarning);
                      }),
                  CustomTextFormField(
                    textColor: kBlueShade,
                    hint: "",
                    label: "Email",
                    textcontroller: emailController,
                    type: TextInputType.emailAddress
                  ),
                  kHeightBox20,
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                        padding: 15,
                        text: CustomText(
                          text: "DONE",
                          color: kWhite,
                          size: 18,
                          weight: FontWeight.bold,
                        ),
                        function: () async {
                          if(formKey4.currentState!.validate()){
                             bool output = await userController.updateUserData(
                              nameController.text.trim(),
                              emailController.text.trim());
                          log(output.toString());
                          if (output == true) {
                            Get.back();
                            nameController.clear();
                            emailController.clear();
                            return showSnackBar(
                                "Done", "Profile Updated!", kGreen);
                          } else {
                            Get.back();
            
                            return showSnackBar(
                                "OOPS", "Something went wrong!", kWarning);
                          }
                          }
                         
                        },
                        color: kGreen),
                  ),
                  kHeightBox20
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
