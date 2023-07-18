import 'dart:developer';
import 'dart:math' as math;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:ila/app/model/carousel_model.dart';
import 'package:ila/app/model/cart_model.dart';
import 'package:ila/app/model/order_model.dart';
import 'package:ila/app/model/product_model.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/view/shared/widgets/show_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../services/firebase_services.dart';
import '../utils/constants/controllers.dart';

class CartController extends GetxController {
  static CartController instance = Get.find();

  RxList<CartItemModel> cartList = <CartItemModel>[].obs;

  String activeRestaurantID = "";
  int deliveryCharge = 0;
  RxDouble discountValue = 0.0.obs;

  RxDouble scratchCardOpacity = 0.0.obs;

  int get totalCount => cartList.length;
  RxDouble totalItemPrice = 0.00.obs;
  RxDouble totalCartPrice = 0.00.obs;

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
    orderCollectionRef = firebaseFirestore.collection("orders");

    super.onInit();
  }

  @override
  void onReady() {
    ever(userController.usermodel, (callback) => getCartList);
    ever(userController.usermodel, (callback) => calculateDiscount);

    super.onReady();
  }

  void setSelectedOption(String option) {
    selectedOption.value = option;
  }

  Future<void> calculateDiscount() async {
    final userDocRef = userCollectionRef.doc(userController.userModel.userId);
    final userSnap = await userDocRef.get();
    num discount = userSnap.get('discounts');
    discountValue.value = discount.toDouble();
    log("discount ${discountValue.value}");
  }

  applyDiscountValue() async {
    if (discountValue.value > totalItemPrice.value) {
      applyDiscount.value = totalItemPrice.value;
    } else if (discountValue <= 0.50 * totalItemPrice.value) {
      applyDiscount.value = discountValue.value;
    } else {
      applyDiscount.value = 0.50 * totalItemPrice.value;
    }
  }

  removeDiscountValue() {
    applyDiscount.value = 0;
  }

  getTotalPrice() async {
    totalItemPrice.value = 0;
    for (var cartitem in cartList) {
      totalItemPrice.value += cartitem.price! * cartitem.quantity!;
    }
    //await calculateDiscount();
    log("$totalItemPrice ${applyDiscount.value} $deliveryCharge");
    totalCartPrice.value =
        totalItemPrice.value - applyDiscount.value + deliveryCharge;
  }

  Future<void> getCartList() async {
    try {
    
      cartList.clear();
      if (userController.userModel.userCart!.isNotEmpty) {
        List<CartItemModel> tempList = [];
        for (var cartitem in userController.userModel.userCart!) {
          tempList.add(cartitem);
        }

        cartList.addAll(tempList);
      }
      log("cart$cartList");
    } catch (e) {
      log("cartfecth error $e");
    }
  }

  bool isItemAlreadyAdded(ProductModel product) =>
      cartList.where((item) => item.productId == product.docId).isNotEmpty;

  Future<void> setCurrentRestaurant() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('ACTIVE_RESTAURANT')) {
      String? restId = homeController.products
          .firstWhere((element) => element.docId == cartList[0].productId)
          .restaurantId;
      prefs.setString('ACTIVE_RESTAURANT', restId!);
      activeRestaurantID = prefs.getString('ACTIVE_RESTAURANT')!;
    } else {
      activeRestaurantID = prefs.getString('ACTIVE_RESTAURANT')!;
    }

    deliveryCharge =
        (homeController.getrestaurant(activeRestaurantID)!).deliveryfee;
  }

  Future<bool> addProductToCart(ProductModel product, int quantity) async {
    try {
      dynamic restaurant = homeController.getrestaurant(product.restaurantId!);
      if (restaurant != null) {
        if (!restaurant.isOpen) {
          showSnackBar(
              "OhOh", "Restaurant is closed now. Please try later", kWarning);
          return false;
        }
      }
      if (isItemAlreadyAdded(product)) {
        showSnackBar(
            "Check your cart", "${product.name} is already added", kWarning);
        return false;
      } else {
        //String itemId = const Uuid().v1().toString();
        if (cartList.isEmpty) {
          SharedPreferences prefs = await SharedPreferences.getInstance();

          prefs.setString('ACTIVE_RESTAURANT', product.restaurantId!);
          await setCurrentRestaurant();
        } else {
          if (!(product.restaurantId == activeRestaurantID)) {
            showSnackBar("Oops!", "Please checkout items from last restuarant",
                kWarning);
            return false;
          }
        }

        CartItemModel item = CartItemModel(product.docId, quantity,
            product.image, product.price, product.name);
        cartList.add(item);
        getTotalPrice();

        final userDocRef =
            userCollectionRef.doc(userController.userModel.userId);
        log(item.toJson().toString());

        userController.userModel.userCart!.add(item);

        userDocRef.update({
          "userCart": FieldValue.arrayUnion([item.toJson()])
        });
        showSnackBar(
            "Item added", "${product.name} was added to your cart", kGreen);
      }
      return true;
    } catch (e) {
      showSnackBar("Error", "Cannot add this item", kWarning);
      log(e.toString());
      return false;
    }
  }

  Future<bool> removeCartItem(String prodId) async {
    final cartitem = cartList.firstWhere((item) => item.productId == prodId);
    try {
      //final name = cartitem.name;
      cartList.removeWhere((element) => element.productId == prodId);
      final userDocRef = userCollectionRef.doc(userController.userModel.userId);
      log(userController.userModel.userCart!.toString());
      userController.userModel.userCart!.remove(cartitem);

      await userDocRef.update({
        "userCart": FieldValue.arrayRemove([cartitem.toJson()])
      });
      await getCartList();
      showSnackBar("Item Removed", "Removed from cart", kGreyDark);
      if (cartList.isEmpty) {
        activeRestaurantID = "";
        deliveryCharge = 0;
        applyDiscount.value = 0;
      }
      getTotalPrice();
      return true;
    } catch (e) {
      showSnackBar("Error", "Cannot remove this item", kWarning);
      log(e.toString());
      return false;
    }
  }

  void clearCartData() async {
    final userDocRef = userCollectionRef.doc(userController.userModel.userId);

    try {
      userController.userModel.userCart = [];

      userDocRef.update({"userCart": []});
      getCartList();
      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setString('ACTIVE_RESTAURANT', "");
      activeRestaurantID = "";
      deliveryCharge = 0;
      applyDiscount.value = 0;
      totalCartPrice.value = 0;
      totalItemPrice.value = 0;
    } catch (e) {
      showSnackBar("Error", "Something went wrong", kWarning);
      log(e.toString());
    }
  }

  void decreaseQuantity(String prodId) async {
    /*  CartItemModel item =
        cartList.firstWhere((item) => item.productId == prodId); */
    CartItemModel itemFromModel = userController.userModel.userCart!
        .firstWhere((element) => element.productId == prodId);
    final userDocRef = userCollectionRef.doc(userController.userModel.userId);

    if (itemFromModel.quantity! > 1) {
      await userDocRef.update({
        "userCart": FieldValue.arrayRemove([itemFromModel.toJson()])
      });

      itemFromModel.quantity = itemFromModel.quantity! - 1;

      await userDocRef.update({
        "userCart": FieldValue.arrayUnion([itemFromModel.toJson()])
      });

      getCartList();
      getTotalPrice();
    }
    return;
  }

  void increaseQuantity(String prodId) async {
    CartItemModel itemFromModel = userController.userModel.userCart!
        .firstWhere((element) => element.productId == prodId);
    final userDocRef = userCollectionRef.doc(userController.userModel.userId);

    await userDocRef.update({
      "userCart": FieldValue.arrayRemove([itemFromModel.toJson()])
    });

    itemFromModel.quantity = itemFromModel.quantity! + 1;

    await userDocRef.update({
      "userCart": FieldValue.arrayUnion([itemFromModel.toJson()])
    });

    getCartList();
    getTotalPrice();
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
    userController.userModel.discounts =
        userController.userModel.discounts! + selectedDiscount.value;
    userDocRef.update({"discounts": currentDiscount + selectedDiscount.value});
  }

  Future<void> decrementDiscount(num usedDiscountValue) async {
    final userDocRef = userCollectionRef.doc(userController.userModel.userId);
    final userSnap = await userDocRef.get();
    final currentDiscount = userSnap.get('discounts');
    userController.userModel.discounts =
        userController.userModel.discounts! - usedDiscountValue;
    userDocRef.update({"discounts": currentDiscount - usedDiscountValue});
  }

  Future<void> addToOrders(String? paymentId) async {
    List<dynamic> productIds = [];
    String orderID = const Uuid().v1().toString().substring(0, 8);

    for (CartItemModel item in cartList) {
      productIds.add(item.productId);
    }
    OrderModel orderModel = OrderModel(
        orderId: orderID,
        paymentRefId: paymentId,
        restaurantId: activeRestaurantID,
        customerId: userController.userModel.userId,
        products: cartList,
        deliveryFee: deliveryCharge,
        subTotal: totalItemPrice.value,
        total: totalCartPrice.value,
        orderStatus: "placed",
        // isAccepted: false,
        isRated: false,
        // isDelivered: false,
        createdAt: DateTime.now(),
        // isCancelled: false,
        location: userController
            .userModel.location![homeController.primaryAddressIndex.value],
        address: userController
            .userModel.address![homeController.primaryAddressIndex.value],
        deliveryPersonName: "",
        deliveryPersonPhone: "");
    try {
      await orderCollectionRef.add(orderModel.toSnapshot());
      await decrementDiscount(applyDiscount.value);
      await orderController.getAllOrders();
      orderController.getOngoingOrders();
    } catch (e) {
      log(e.toString());
    }
  }
}
