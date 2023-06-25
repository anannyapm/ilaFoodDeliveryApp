import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/auth_controller.dart';
import 'package:ila/app/controller/login_controller.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/view/shared/widgets/customtext.dart';

void showChangeAddressBottomSheet() {
  AuthController authController = Get.put(AuthController());
  LoginController loginController = Get.put(LoginController());

  Get.bottomSheet(
    Container(
      margin: const EdgeInsets.all(15),
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            text: "Change Address",
            size: 18,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: authController.userModel.address!.length,
              itemBuilder: (context, index) {
                // Replace with your actual address
                bool isSelected =
                    loginController.primaryAddressIndex.value == index;

                return ListTile(
                  title: Text(authController.userModel.address![index]),
                  trailing: isSelected ? const Icon(Icons.check) : null,
                  onTap: () {
                    loginController.primaryAddressIndex.value = index;
                    Get.back();
                  },
                );
              },
            ),
          ),
        ],
      ),
    ),
    backgroundColor: kWhite,
  );
}
