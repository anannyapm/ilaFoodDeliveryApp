import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/model/order_model.dart';
import 'package:ila/app/services/firebase_services.dart';
import 'package:ila/app/utils/constants/controllers.dart';

class OrderController extends GetxController {
  static OrderController instance = Get.find();

  @override
  void onInit() async {
    orderCollectionRef = firebaseFirestore.collection("orders");
    

    super.onInit();
  }

  final RxMap _tempReview = {}.obs;
  final RxMap _ratingstatusdummy = {}.obs;

  RxBool isOrdersLoading = false.obs;

  RxList<OrderModel> orders = RxList<OrderModel>([]);
  RxList<OrderModel> ongoingOrders = RxList<OrderModel>([]);
  RxList<OrderModel> oldOrders = RxList<OrderModel>([]);

  Map get tempReview => _tempReview;
  Map get ratingStatusDummy => _ratingstatusdummy;
  final TextEditingController reviewTextController = TextEditingController();
  final RxDouble _selectedRating = 0.0.obs;
  double get selectedRating => _selectedRating.value;

  setRating(double value) {
    _selectedRating.value = value;
  }

  addReview(index) {
    _tempReview[index] = reviewTextController.text;
    reviewTextController.clear();
  }

  setratingstatus(index) {
    _ratingstatusdummy[index] = selectedRating;
  }

  Future<void> getAllOrders() async {
    isOrdersLoading.value = true;
    orders.clear();
    List<OrderModel> tempList = [];
    final collectionData = await orderCollectionRef.get();
    tempList = collectionData.docs
        .map((querysnap) => OrderModel.fromSnapshot(querysnap))
        .toList();
    orders.value = tempList
        .where(
            (element) => element.customerId == userController.userModel.userId)
        .toList();

    isOrdersLoading.value = false;
  }

  getOngoingOrders() {
    ongoingOrders.clear();
    List<OrderModel> tempOrders = [];
    for (OrderModel order in orders) {
      if (order.isDelivered == false && order.isCancelled == false) {
        tempOrders.add(order);
      }
    }
    ongoingOrders.addAll(tempOrders);
  }

  onOrderCancel(OrderModel order) async {
    //order.isCancelled = true;
    final snapshotObject = await orderCollectionRef
        .where('orderId', isEqualTo: order.orderId)
        .get();
    await snapshotObject.docs.first.reference.update({"isCancelled": true});
    await getAllOrders();
    getOngoingOrders();
    getOrderHistory();
  }

  getOrderHistory() {
    oldOrders.clear();
    List<OrderModel> tempOrders = [];
    for (OrderModel order in orders) {
      if (order.isDelivered == true || order.isCancelled == true) {
        tempOrders.add(order);
      }
    }
    oldOrders.addAll(tempOrders);
  }
}
