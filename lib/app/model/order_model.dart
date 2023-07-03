import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String? orderId;
  String? customerId;
  String? restaurantId;
  List<dynamic>? productIds;
  num? deliveryFee;
  num? subTotal;
  num? total;
  String? orderStatus;
  //bool? isAccepted;
  bool? isRated;
  //bool? isDelivered;
  DateTime? createdAt;
  //bool? isCancelled;
  GeoPoint? location;
  String? address;
  String? deliveryPersonName;
  String? deliveryPersonPhone;

  OrderModel(
      {required this.orderId,
      required this.isRated,
      required this.restaurantId,
      required this.customerId,
      required this.productIds,
      required this.deliveryFee,
      required this.subTotal,
      required this.total,
      required this.orderStatus,
      // required this.isAccepted,
      //required this.isDelivered,
      required this.createdAt,
      // required this.isCancelled,
      required this.address,
      required this.location,
      required this.deliveryPersonName,
      required this.deliveryPersonPhone});

  OrderModel.fromSnapshot(DocumentSnapshot data) {
    orderId = data["orderId"];
    restaurantId = data["restaurantId"];
    customerId = data["customerId"];
    productIds = data["productIds"];
    deliveryFee = data["deliveryFee"];
    subTotal = data["subTotal"];
    total = data["total"];
    //isAccepted = data["isAccepted"];
    isRated = data["isRated"];
    orderStatus = data["orderStatus"];
    //isDelivered = data["isDelivered"];
    //isCancelled = data["isCancelled"];
    address = data["address"];
    location = data["location"];
    createdAt = data["createdAt"].toDate();
    deliveryPersonName = data["deliveryPersonName"];
    deliveryPersonPhone = data["deliveryPersonPhone"];
  }
  Map<String, dynamic> toSnapshot() {
    return {
      "orderId": orderId,
      "restaurantId": restaurantId,
      "customerId": customerId,
      "productIds": productIds,
      "deliveryFee": deliveryFee,
      "subTotal": subTotal,
      "total": total,
      //"isCancelled": isCancelled,
      "isRated": isRated,
      "orderStatus": orderStatus,
      //"isAccepted": isAccepted,
      //"isDelivered": isDelivered,
      "address": address,
      "location": location,
      "createdAt": Timestamp.fromDate(createdAt!),
      "deliveryPersonName": deliveryPersonName,
      "deliveryPersonPhone": deliveryPersonPhone
    };
  }
}
