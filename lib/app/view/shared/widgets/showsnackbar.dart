import 'package:get/get.dart';

import '../../../utils/constants/color_constants.dart';

showSnackBar(bool isfav){
  return Get.snackbar("Done", isfav?"Added to Favorites":"Removed from Favorites",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor:isfav? kGreen:kWarning,
        colorText: kWhite);
}