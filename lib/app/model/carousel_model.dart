import 'package:cloud_firestore/cloud_firestore.dart';

class CarouselModel {
  String? carId;
  String? title;
  String? imageUrl;

  CarouselModel({required this.title, required this.imageUrl});

  CarouselModel.fromSnapshot(DocumentSnapshot data) {
    carId = data.id;
    title = data["title"];
    imageUrl = data["imageUrl"];
  }
  Map<String, dynamic> toSnapshot() {
    return {
      "title": title,
      "imageUrl": imageUrl,
     
    };
  }
}
