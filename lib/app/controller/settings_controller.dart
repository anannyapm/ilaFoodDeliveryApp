import 'package:get/get.dart';

import '../services/firebase_services.dart';
import '../utils/constants/controllers.dart';

class SettingsController extends GetxController {
  final RxBool _isNotificationEnabled = false.obs;


  @override
  void onInit() {
    _isNotificationEnabled.value =
        userController.userModel.receiveNotification!;


    super.onInit();
  }

  bool get isNotificationEnabled => _isNotificationEnabled.value;

  void updateNotificationStatus(bool value) {
    _isNotificationEnabled.value = value;
    final userDocRef = userCollectionRef.doc(userController.userModel.userId);
    userDocRef.update({"receiveNotification": value});
    userController.userModel.receiveNotification = value;
  }

  
}
