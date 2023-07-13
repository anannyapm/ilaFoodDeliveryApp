import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/model/order_model.dart';
import 'package:ila/app/services/firebase_services.dart';
import 'package:ila/app/utils/constants/controllers.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderController extends GetxController {
  static OrderController instance = Get.find();

  @override
  void onInit() async {
    orderCollectionRef = firebaseFirestore.collection("orders");
    restaurantCollectionRef = firebaseFirestore.collection("restaurant");

    super.onInit();
  }

  final RxMap _tempReview = {}.obs;


  RxBool isOrdersLoading = false.obs;

  RxList<OrderModel> orders = RxList<OrderModel>([]);
  RxList<OrderModel> ongoingOrders = RxList<OrderModel>([]);
  RxList<OrderModel> oldOrders = RxList<OrderModel>([]);

  final TextEditingController reviewTextController = TextEditingController();
  final RxBool ratingStatus = false.obs;

  RxBool hasCallSupport = false.obs;

  addReview(index) {
    _tempReview[index] = reviewTextController.text;
    reviewTextController.clear();
  }

  Future<void> getAllOrders() async {
    isOrdersLoading.value = true;
    orders.clear();
    List<OrderModel> tempList = [];
    final collectionData = await orderCollectionRef.orderBy('createdAt',descending: true).get();
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
      if (order.orderStatus != "delivered" &&
          order.orderStatus != "cancelled") {
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
    await snapshotObject.docs.first.reference
        .update({"orderStatus": "cancelled"});
    await getAllOrders();
    getOngoingOrders();
    getOrderHistory();
  }

  Future<void> addRating(num rating, OrderModel order) async {
    try {
      final restaurantDocRef = restaurantCollectionRef.doc(order.restaurantId);
      final restaurantSnap = await restaurantDocRef.get();
      final currentRate = restaurantSnap.get('rating');
      log(currentRate.toString());

      double newRating =
          double.parse(((currentRate + rating) / 2).toStringAsFixed(1));

      restaurantDocRef.update({'rating': newRating});

      final ordersnapshotObject = await orderCollectionRef
          .where('orderId', isEqualTo: order.orderId)
          .get();
      await ordersnapshotObject.docs.first.reference.update({'isRated': true});
      order.isRated = true;

      await getAllOrders();
      homeController.initializeRestaurants();
      getOrderHistory();
    } catch (e) {
      log(e.toString());
    }
  }

  getOrderHistory() {
    oldOrders.clear();
    List<OrderModel> tempOrders = [];
    for (OrderModel order in orders) {
      if (order.orderStatus == "delivered" ||
          order.orderStatus == "cancelled") {
        tempOrders.add(order);
      }
    }
    oldOrders.addAll(tempOrders);
  }

  Future<void> fetchAllOrderData() async {
    await getAllOrders();
    getOngoingOrders();
    getOrderHistory();
  }

  int getOrderCurrentStatus(OrderModel order) {
    if (order.orderStatus == "placed") {
      return 1;
    } else if (order.orderStatus == "preparing") {
      return 2;
    } else if (order.orderStatus == "outForDelivery") {
      return 3;
    } else if (order.orderStatus == "arrivingSoon") {
      return 4;
    } else {
      return 1;
    }
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    try {
      final Uri launchUri = Uri(
        scheme: 'tel',
        path: phoneNumber,
      );
      await launchUrl(launchUri);
    } catch (e) {
      log(e.toString());
    }
  }
}
