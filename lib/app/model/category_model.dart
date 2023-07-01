import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String? categId;
  String? name;
  String? imageUrl;
  String? price;

  CategoryModel(
      {required this.price, required this.name, required this.imageUrl});

  CategoryModel.fromSnapshot(DocumentSnapshot data) {
    categId = data.id;
    price = data["price"];
    name = data["title"];
    imageUrl = data["imageUrl"];
  }
  Map<String, dynamic> toSnapshot() {
    return {
      "price":price,
      "title": name,
      "imageUrl": imageUrl,
    };
  }
}
