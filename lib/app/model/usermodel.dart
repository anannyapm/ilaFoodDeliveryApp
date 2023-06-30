import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ila/app/model/cart_model.dart';

class UserModel {
  String? userId;
  String? name;
  String? email;
  bool? activeStatus;
  String? phoneNumber;
  List<dynamic>? location;
  List<dynamic>? address;
  List<dynamic>? favoriteList;
  List<CartItemModel>? userCart;
  List<dynamic>? completeAddress;
  

  UserModel({
    this.userId,
    this.name,
    this.email,
    this.activeStatus = true,
    this.address,
    this.favoriteList,
    this.userCart,
    this.phoneNumber,
    this.location,
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
    userCart = _convertCartItems(data["userCart"]);
    favoriteList = data["favoriteList"];
    completeAddress = data["completeAddress"];
  }

  List<CartItemModel> _convertCartItems(List cartFomDb){
    List<CartItemModel> result = [];
    if(cartFomDb.isNotEmpty){
      for (var element in cartFomDb) {
      result.add(CartItemModel.fromMap(element));
    }
    }
    return result;
  }

  List cartItemsToJson() => userCart!.map((item) => item.toJson()).toList();

  Map<String, dynamic> toSnapshot() {
    return {
      "deliveryAddress": address,
      "completeAddress": completeAddress,
      "name": name,
      "email": email,
      "activeStatus": activeStatus,
      "phoneNumber": phoneNumber,
      "location": location,
      "userCart":cartItemsToJson(),
      "favoriteList":favoriteList
    };
  }
}
