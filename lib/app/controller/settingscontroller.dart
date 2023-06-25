import 'package:get/get.dart';

class SettingsController extends GetxController {
  final RxBool _isNotificationEnabled = false.obs;

  bool get isNotificationEnabled => _isNotificationEnabled.value;

  void setNotificationEnabled(bool value) {
    _isNotificationEnabled.value = value;
  }
}
