import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/view/pages/search/pages/search_page.dart';
import 'package:ila/app/view/shared/widgets/custom_text.dart';

import '../../../../utils/constants/color_constants.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => SearchPage()),
      child: ListTile(
       
        title:CustomText(text:  "Search dishes,restaurants",color: kGrey,) ,
        leading: Icon(
          Icons.search_outlined,
          color: kGreylight,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        tileColor:Get.isDarkMode?kGreylight.withOpacity(0.6): kGreylight.withOpacity(0.2),
      ),
    );
  }
}
