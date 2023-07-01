import 'dart:developer';
import 'dart:math' as math;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:ila/app/model/carousel_model.dart';
import 'package:ila/app/model/cart_model.dart';
import 'package:ila/app/model/product_model.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/view/shared/widgets/show_snackbar.dart';
import 'package:uuid/uuid.dart';
import '../services/firebase_services.dart';
import '../utils/constants/controllers.dart';

class CartController extends GetxController {
  static CartController instance = Get.find();
  RxList<CartItemModel> cartList = <CartItemModel>[].obs;

  RxDouble scratchCardOpacity = 0.0.obs;

  int get totalCount => cartList.length;
  RxDouble totalItemPrice = 0.0.obs;
  RxDouble totalCartPrice = 0.0.obs;

  RxInt itemCount = 1.obs;
  final List<String> options = [
    'UPI',
    'Credit/Debit/ATM Card',
    'Cash On Delivery'
  ];

  RxNum applyDiscount = RxNum(0);

  RxBool isAdded = false.obs;
  RxBool isCouponApplied = false.obs;

  final selectedOption = Rx<String?>(null);

  @override
  void onInit() {
    //getCartList();
    super.onInit();
  }

  @override
  void onReady() {
    ever(userController.usermodel, (callback) => getCartList);
    super.onReady();
  }

  void setSelectedOption(String option) {
    selectedOption.value = option;
  }

  calculateDiscount() async {
    final userDocRef = userCollectionRef.doc(userController.userModel.userId);
    final userSnap = await userDocRef.get();
    final discount = userSnap.get('discounts');

    if (discount <= 50) {
      applyDiscount.value = discount;
    } else {
      applyDiscount.value = 50;
      /* userDocRef.update({"discounts": discount - applyDiscount}); */ // DO IT AFTER SUBMISSION
    }
  }

  getCartList() async {
    totalItemPrice.value = 0.0;
    cartList.clear();
    if (userController.userModel.userCart!.isNotEmpty) {
      List<CartItemModel> tempList = [];
      for (var cartitem in userController.userModel.userCart!) {
        tempList.add(cartitem);
        totalItemPrice.value += cartitem.price! * cartitem.quantity!;
      }
      await calculateDiscount();

      totalCartPrice.value = totalItemPrice.value + applyDiscount.value;

      cartList.addAll(tempList);
    }
  }

  bool isItemAlreadyAdded(ProductModel product) =>
      cartList.where((item) => item.productId == product.docId).isNotEmpty;

  void addProductToCart(ProductModel product, int quantity) {
    try {
      if (isItemAlreadyAdded(product)) {
        showSnackBar(
            "Check your cart", "${product.name} is already added", kWarning);
      } else {
        String itemId = const Uuid().v1().toString();
        CartItemModel item = CartItemModel(itemId, product.docId, quantity,
            product.image, product.price, product.name);
        cartList.add(item);
        final userDocRef =
            userCollectionRef.doc(userController.userModel.userId);
        log(item.toJson().toString());

        userDocRef.update({
          "userCart": FieldValue.arrayUnion([item.toJson()])
        });
        showSnackBar(
            "Item added", "${product.name} was added to your cart", kGreen);
      }
    } catch (e) {
      showSnackBar("Error", "Cannot add this item", kWarning);
      log(e.toString());
    }
  }

  void removeCartItem(String prodId) {
    final cartitem = cartList.firstWhere((item) => item.productId == prodId);
    try {
      //final name = cartitem.name;
      cartList.removeWhere((element) => element.productId == prodId);
      final userDocRef = userCollectionRef.doc(userController.userModel.userId);
      userDocRef.update({
        "userCart": FieldValue.arrayRemove([cartitem.toJson()])
      });
      //showSnackBar("Item Removed", "Removed $name from cart", kGreyDark);
    } catch (e) {
      showSnackBar("Error", "Cannot remove this item", kWarning);
      log(e.toString());
    }
  }

  void decreaseQuantity(String prodId) {
    CartItemModel item =
        cartList.firstWhere((item) => item.productId == prodId);
    final userDocRef = userCollectionRef.doc(userController.userModel.userId);

    if (item.quantity! > 1) {
      userDocRef.update({
        "userCart": FieldValue.arrayRemove([item.toJson()])
      });
      item.quantity = item.quantity! - 1;

      userDocRef.update({
        "userCart": FieldValue.arrayUnion([item.toJson()])
      });
    }
    getCartList();
  }

  void increaseQuantity(String prodId) {
    CartItemModel item =
        cartList.firstWhere((item) => item.productId == prodId);

    final userDocRef = userCollectionRef.doc(userController.userModel.userId);

    userDocRef.update({
      "userCart": FieldValue.arrayRemove([item.toJson()])
    });
    item.quantity = item.quantity! + 1;

    userDocRef.update({
      "userCart": FieldValue.arrayUnion([item.toJson()])
    });
    getCartList();
  }

  RxNum selectedDiscount = RxNum(0);

  Future<void> fetchAndSelectRandomDiscount(CarouselModel carouselModel) async {
    final List discounts = carouselModel.discounts!;

    if (discounts.isNotEmpty) {
      final int randomIndex = math.Random().nextInt(discounts.length);
      selectedDiscount.value = discounts[randomIndex];
    }
  }

  Future<void> addDiscountToUser(num discountValue) async {
    isCouponApplied.value = true;
    final userDocRef = userCollectionRef.doc(userController.userModel.userId);
    final userSnap = await userDocRef.get();
    final currentDiscount = userSnap.get('discounts');
    userController.userModel.discounts =userController.userModel.discounts! + selectedDiscount.value;
    userDocRef.update({"discounts": currentDiscount + selectedDiscount.value});
  }
}
