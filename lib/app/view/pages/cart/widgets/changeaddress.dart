import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/home_controller.dart';
import 'package:ila/app/controller/user_controller.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/view/shared/widgets/custom_text.dart';
import 'package:ila/app/view/shared/widgets/show_snackbar.dart';

void showChangeAddressBottomSheet() {
  UserController userController = Get.put(UserController());
  HomeController homeController = Get.put(HomeController());

  Get.bottomSheet(
  
    Container(
      margin: const EdgeInsets.all(15),
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: CustomText(
              text: "Change Address",
              size: 20,
              weight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: userController.userModel.address!.length,
              itemBuilder: (context, index) {
                bool isSelected =
                    homeController.primaryAddressIndex.value == index;
                
                return ListTile(
                  selected: isSelected,
                  selectedTileColor: kOffBlue,
                  title: CustomText(
                    text: userController.userModel.address![index],
                    weight: isSelected ? FontWeight.bold : null,
                  ),
                  trailing: isSelected ? const Icon(Icons.check) : null,
                  onTap: () {
                    
                    homeController.changePrimaryAddress(index);
                    Get.back();
                    showSnackBar("Done", "Changed Address", kGreen);
                
                  },
                );
              },
            ),
          ),
        ],
      ),
    ),
    backgroundColor:Get.isDarkMode?kGreyDark.withOpacity(0.8): kWhite,
    isScrollControlled: true
  );
}
