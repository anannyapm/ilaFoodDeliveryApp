import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/auth_controller.dart';
import 'package:ila/app/controller/login_controller.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/utils/constants/constants.dart';
import 'package:ila/app/view/shared/widgets/customtext.dart';
import 'package:ila/app/view/shared/widgets/customtextformfield.dart';
import 'package:ionicons/ionicons.dart';

class AddressSheet extends StatelessWidget {
  AddressSheet({super.key});
  final LoginController loginController = Get.put(LoginController());
  final AuthController authController = Get.put(AuthController());

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
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.close))
              ],
            ),
            kHeightBox20,
            ListView.builder(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
                itemCount: authController.userModel.address!.length,
                itemBuilder: (context, index) {
                  TextEditingController addressController =
      TextEditingController(text: authController.userModel.address![index]!);
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                            readonly: authController.isEditMode.value,
                            textColor: kBlueShade,
                            maxline: 2,
                            hint: "",
                            label: "",
                            textcontroller: addressController,
                            function: () {}),
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {}, icon: const Icon(Icons.edit_note)),
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
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: kGreen),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: Colors.transparent,
                      padding: const EdgeInsets.all(15),
                      elevation: 0),
                  child: Text(
                    "ADD NEW ADDRESS",
                    style: TextStyle(
                        color: kBlueShade,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            kHeightBox20
          ],
        ),
      ),
    );
  }
}
