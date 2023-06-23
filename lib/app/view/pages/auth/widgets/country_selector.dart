import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/login_controller.dart';
import 'package:ila/app/utils/constants/color_constants.dart';

class CountryCodeWidget extends StatelessWidget {
   CountryCodeWidget({super.key});

  final LoginController loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DropdownButton<String>(
       isExpanded: true,
       elevation: 3,
       dropdownColor: kWhite,
       autofocus: true,
        focusColor: kGreylight,
        value:loginController.selectedCode,
        hint: const Text('Select a Country Code'),
        onChanged: (String? newValue) {
         loginController.setSelectedCountry(newValue!);
        },
        items:loginController.filteredCountryCodes.map<DropdownMenuItem<String>>(
          (String code) {
            final name =loginController.getCountryName(code);
            return DropdownMenuItem<String>(
              value: code,
              child: Text('$code ($name)'),
            );
          },
        ).toList(),
      ),
    );
  }
}
