import 'package:get/get.dart';

class CartController extends GetxController {
  
  RxInt itemCount = 1.obs;
  final List<String> options = [
    'UPI',
    'Credit/Debit/ATM Card',
    'Cash On Delivery'
  ];
  final selectedOption = Rx<String?>(null);

  void setSelectedOption(String option) {
    selectedOption.value = option;
  }

  

  
}
