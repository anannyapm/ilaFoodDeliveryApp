import 'package:get/get.dart';
import 'package:ila/app/model/product_model.dart';

class CartController extends GetxController {
  RxList<ProductModel> cartList = <ProductModel>[].obs;

  int get totalCount => cartList.length;

  RxInt itemCount = 1.obs;
  final List<String> options = [
    'UPI',
    'Credit/Debit/ATM Card',
    'Cash On Delivery'
  ];

  RxBool isAdded = false.obs;


  final selectedOption = Rx<String?>(null);

  void setSelectedOption(String option) {
    selectedOption.value = option;
  }

  void addToCart(ProductModel item) {
    cartList.add(item);
  }

  void removeFromCart(ProductModel item) {
    cartList.removeWhere((element) => element.docId == item.docId);
  }
}
