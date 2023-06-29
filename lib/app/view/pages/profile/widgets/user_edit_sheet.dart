import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/auth_controller.dart';
import 'package:ila/app/controller/login_controller.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/utils/constants/constants.dart';
import 'package:ila/app/view/shared/widgets/custom_text.dart';
import 'package:ila/app/view/shared/widgets/custom_textformfield.dart';

import '../../../../controller/user_controller.dart';
import '../../../shared/widgets/custom_button.dart';

class UserEditSheet extends StatelessWidget {
  UserEditSheet({super.key});
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
                    function: () {}),
                CustomTextFormField(
                    readonly: true,
                    textColor: kBlueShade,
                    hint: "",
                    label: "Phone Number",
                    textcontroller: phoneController,
                    function: () {}),
                CustomTextFormField(
                    textColor: kBlueShade,
                    hint: "",
                    label: "Email",
                    textcontroller: emailController,
                    function: () {}),
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
                      function: () {},
                      color: kGreen),
                ),
                kHeightBox20
              ],
            ),
          );
        },
      ),
    );
  }
}
