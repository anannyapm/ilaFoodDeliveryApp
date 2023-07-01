import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String? orderId;
  String? customerId;
  List<dynamic>? productIds;
  num? deliveryFee;
  num? subTotal;
  num? total;
  bool? isAccepted;
  bool? isDelivered;
  DateTime? createdAt;
  bool? isCancelled;

  OrderModel(
      {required this.orderId,
      required this.customerId,
      required this.productIds,
      required this.deliveryFee,
      required this.subTotal,
      required this.total,
      required this.isAccepted,
      required this.isDelivered,
      required this.createdAt,
      required this.isCancelled});

  OrderModel.fromSnapshot(DocumentSnapshot data) {
    orderId = data["orderId"];
    customerId = data["customerId"];
    productIds = data["productIds"];
    deliveryFee = data["deliveryFee"];
    subTotal = data["subTotal"];
    total = data["total"];
    isAccepted = data["isAccepted"];
    isDelivered = data["isDelivered"];
    isCancelled = data["isCancelled"];
    createdAt = data["createdAt"].toDate();
  }
  Map<String, dynamic> toSnapshot() {
    return {
      "orderId":orderId,
      "customerId": customerId,
      "productIds": productIds,
      "deliveryFee": deliveryFee,
      "subTotal": subTotal,
      "total": total,
      "isCancelled":isCancelled,
      "isAccepted": isAccepted,
      "isDelivered": isDelivered,
      "createdAt": createdAt!.millisecondsSinceEpoch
    };
  }

  /* static List<OrderModel> orders = [
    OrderModel(
      isCancelled: false,
        orderId: "152",
        customerId: "cEtEhtcS8e1OvQg12pJi",
        productIds: ['F63uNjELX49yhd5Mx3N9', 'x2VnLD4gRW5fZNT7gqe4'],
        deliveryFee: 20,
        subTotal: 20,
        total: 40,
        isAccepted: false,
        isDelivered: false,
        createdAt: DateTime.now()),
    OrderModel(
      isCancelled: false,
        orderId: "458",
        customerId: "sMbaP1lsyexq9ZmPCI7C",
        productIds: ['x2VnLD4gRW5fZNT7gqe4', 'F63uNjELX49yhd5Mx3N9'],
        deliveryFee: 50,
        subTotal: 150,
        total: 200,
        isAccepted: false,
        isDelivered: false,
        createdAt: DateTime.now()),
  ]; */
}
