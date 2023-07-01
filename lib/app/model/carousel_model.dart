import 'package:cloud_firestore/cloud_firestore.dart';

class CarouselModel {
  String? carId;
  String? title;
  String? imageUrl;
  List<dynamic>? discounts;

  CarouselModel(
      {required this.title, required this.imageUrl, required this.discounts});

  CarouselModel.fromSnapshot(DocumentSnapshot data) {
    carId = data.id;
    title = data["title"];
    imageUrl = data["imageUrl"];
    discounts = data["discounts"];
  }
  Map<String, dynamic> toSnapshot() {
    return {
      "title": title,
      "imageUrl": imageUrl,
      "discounts":discounts
    };
  }
}
