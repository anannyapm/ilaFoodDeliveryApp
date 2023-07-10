import 'package:cloud_firestore/cloud_firestore.dart';

class RestuarantModel {
  String? docId;
  String? tagline;
  int? deliveryfee;
  String? deliverytime;
  String? description;
  String? image;
  bool? isOpen;
  bool? isRecommended;
  GeoPoint? location;
  String? address;
  String? name;
  num? rating;


  RestuarantModel({
    this.docId,
    required this.tagline,
    required this.deliveryfee,
    required this.deliverytime,
    required this.description,
    required this.image,

    required this.isOpen,
    required this.isRecommended,
    required this.location,
    required this.name,
    this.address,
    required this.rating,
 
  });

  RestuarantModel.fromSnapshot(DocumentSnapshot data) {
    docId = data.id;
    tagline = data["tagline"];
    deliveryfee = data["deliveryfee"];
    deliverytime = data["deliverytime"];
    description = data["description"];
    image = data["image"];

    isOpen = data["isOpen"];
    isRecommended = data["isRecommended"];
    location = data["location"];
    address = data["address"];
    name = data["name"];
    rating = data["rating"];
    
  }
  Map<String, dynamic> toSnapshot() {
    return {
      "tagline":tagline,
      "address": address,
      "deliveryfee": deliveryfee,
      "deliverytime": deliverytime,
      "description": description,
      "image": image,

      "isOpen": isOpen,
      "isRecommended": isRecommended,
      "location": location,
      "name": name,
      "rating": rating,
    
    };
  }

}
