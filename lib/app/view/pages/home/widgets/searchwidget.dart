import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/view/pages/search/pages/searchpage.dart';
import 'package:ila/app/view/shared/widgets/customtext.dart';

import '../../../../utils/constants/color_constants.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => SearchPage()),
      child: ListTile(
       
        title:CustomText(text:  "Search dishes,restaurants",color: kGrey,) ,
        leading: Icon(
          Icons.search_outlined,
          color: kGreylight,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        tileColor: kGreylight.withOpacity(0.2),
      ),
    );
  }
}
