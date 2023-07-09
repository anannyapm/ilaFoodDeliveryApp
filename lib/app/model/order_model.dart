import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ila/app/model/cart_model.dart';

class OrderModel {
  String? orderId;
  String? paymentRefId;
  String? customerId;
  String? restaurantId;
  List<CartItemModel>? products;
  num? deliveryFee;
  num? subTotal;
  num? total;
  String? orderStatus;
  bool? isRated;
  DateTime? createdAt;
  GeoPoint? location;
  String? address;
  String? deliveryPersonName;
  String? deliveryPersonPhone;

  OrderModel(
      {required this.orderId,
      required this.isRated,
      required this.restaurantId,
      required this.customerId,
      required this.paymentRefId,
      // required this.productIds,
      required this.products,
      required this.deliveryFee,
      required this.subTotal,
      required this.total,
      required this.orderStatus,
      required this.createdAt,
      required this.address,
      required this.location,
      required this.deliveryPersonName,
      required this.deliveryPersonPhone});

  OrderModel.fromSnapshot(DocumentSnapshot data) {
    orderId = data["orderId"];
    restaurantId = data["restaurantId"];
    paymentRefId = data["paymentRefId"];
    customerId = data["customerId"];
    //productIds = data["productIds"];
    products = _convertCartItems(data["products"]);
    deliveryFee = data["deliveryFee"];
    subTotal = data["subTotal"];
    total = data["total"];
    isRated = data["isRated"];
    orderStatus = data["orderStatus"];
    address = data["address"];
    location = data["location"];
    createdAt = data["createdAt"].toDate();
    deliveryPersonName = data["deliveryPersonName"];
    deliveryPersonPhone = data["deliveryPersonPhone"];
  }

  List<CartItemModel> _convertCartItems(List cartFomDb) {
    List<CartItemModel> result = [];
    if (cartFomDb.isNotEmpty) {
      for (var element in cartFomDb) {
        result.add(CartItemModel.fromMap(element));
      }
    }
    return result;
  }

  List cartItemsToJson() => products!.map((item) => item.toJson()).toList();

  Map<String, dynamic> toSnapshot() {
    return {
      "orderId": orderId,
      "paymentRefId":paymentRefId,
      "restaurantId": restaurantId,
      "customerId": customerId,
      "products": cartItemsToJson(),
      "deliveryFee": deliveryFee,
      "subTotal": subTotal,
      "total": total,
      "isRated": isRated,
      "orderStatus": orderStatus,
      "address": address,
      "location": location,
      "createdAt": Timestamp.fromDate(createdAt!),
      "deliveryPersonName": deliveryPersonName,
      "deliveryPersonPhone": deliveryPersonPhone
    };
  }
}
