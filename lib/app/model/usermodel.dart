import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? userId;
  String? name;
  String? email;
  bool? activeStatus;
  String? phoneNumber;
  List<dynamic>? location;
  List<dynamic>? address;
  List<dynamic>? favoriteList;
  List<dynamic>? userCart;
  List<dynamic>? completeAddress;
  

  UserModel({
    this.userId,
    this.name,
    this.email,
    this.activeStatus = true,
    this.address,
    this.favoriteList,
    this.userCart,
    required this.phoneNumber,
    required this.location,
    this.completeAddress
  });

  UserModel.fromSnapshot(DocumentSnapshot data) {
    userId = data.id;
    name = data["name"];
    email = data["email"];
    activeStatus = data["activeStatus"];
    address = data["deliveryAddress"];
    phoneNumber = data["phoneNumber"];
    location = data["location"];
    userCart = data["userCart"];
    favoriteList = data["favoriteList"];
    completeAddress = data["completeAddress"];
  }
  Map<String, dynamic> toSnapshot() {
    return {
      "deliveryAddress": address,
      "completeAddress": completeAddress,
      "name": name,
      "email": email,
      "activeStatus": activeStatus,
      "phoneNumber": phoneNumber,
      "location": location,
      "userCart":userCart,
      "favoriteList":favoriteList
    };
  }
}
