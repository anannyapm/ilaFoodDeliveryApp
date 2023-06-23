import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/auth_controller.dart';
import 'package:ila/app/controller/homecontroller.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/utils/constants/constants.dart';
import 'package:ila/app/view/shared/widgets/customtext.dart';
import 'package:ila/app/view/shared/widgets/customtextformfield.dart';

import '../../../shared/widgets/borderedbox.dart';

class AddressSheet extends StatelessWidget {
  AddressSheet({super.key});

  final AuthController authController = Get.put(AuthController());
  final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kHeightBox10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(
                  text: "My Addresses",
                  size: 20,
                ),
                IconButton(
                    onPressed: () => Get.back(), icon: const Icon(Icons.close))
              ],
            ),
            kHeightBox20,
            ListView.builder(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: authController.userModel.address!.length,
                itemBuilder: (context, index) {
                  TextEditingController addressController =
                      TextEditingController(
                          text: authController.userModel.address![index]!);
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Obx(() => CustomTextFormField(
                            readonly: homeController.isEditMode.value,
                            textColor: kBlueShade,
                            maxline: 2,
                            hint: "",
                            label: "",
                            textcontroller: addressController,
                            function: () {})),
                      ),
                      Row(
                        children: [
                          Obx(() => IconButton(
                              onPressed: () {
                                homeController.changeEditMode();
                                //handle submiting data to db when done pressed
                              },
                              icon: Icon(homeController.isEditMode.value
                                  ? Icons.edit_note
                                  : Icons.done))),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.delete_outlined)),
                        ],
                      )
                    ],
                  );
                }),
            kHeightBox20,
            Center(
              child: BorderedButton(text: CustomText(text:"ADD NEW ADDRESS",color: kBlueShade,size: 14,weight: FontWeight.bold, ),color: kGreen,function: (){},),
            
            ),
            kHeightBox20
          ],
        ),
      ),
    );
  }
}


