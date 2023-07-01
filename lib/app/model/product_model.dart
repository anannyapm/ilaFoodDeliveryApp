import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? docId;
  String? restaurantId;
  String? description;
  String? image;
  bool? isRecommended;
  String? name;
  num? price;
  String? categoryName;

  ProductModel({
    this.docId,
    required this.restaurantId,
    required this.description,
    required this.image,
    required this.isRecommended,
    required this.price,
    required this.name,
    required this.categoryName
  });

  ProductModel.fromSnapshot(DocumentSnapshot data) {
    docId = data.id;
    restaurantId = data["restaurant_id"];
    description = data["description"];
    image = data["image"];
    categoryName = data["categoryName"];

    isRecommended = data["isRecommended"];
    price = data["price"];
    name = data["name"];
  }
  Map<String, dynamic> toSnapshot() {
    return {
      "description": description,
      "restaurant_id": restaurantId,
      "image": image,
      "categoryName":categoryName,
      "isRecommended": isRecommended,
      "price": price,
      "name": name,
    };
  }
}
