import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../model/usermodel.dart';
import '../services/firebase_services.dart';

class UserController extends GetxController {
  UserModel? _usermodel;
  RxList addressList = [].obs;
  RxList latlongList = [].obs;
  RxList completeAddrList = [].obs;
  RxBool isLoading = false.obs;

  UserModel get userModel => _usermodel!;
  Future<void> setUser(user) async {
    _usermodel = user;
    
  }

  Future<void> getUserAddress() async {

    //FIX THE BUG!!!!!!
    isLoading.value = true;
    DocumentReference userDocRef = userCollectionRef.doc(userModel.userId);

     DocumentSnapshot userSnap = await userDocRef.get();

     List<dynamic> location = userSnap.get('deliveryAddress');
     List<dynamic> latlng = userSnap.get('location');
     List<dynamic> compAdd = userSnap.get('completeAddress');

    addressList.clear();
    latlongList.clear();
    completeAddrList.clear();

    List list1 = location.map((element) => element).toList();
    addressList.addAll(list1);
    List list2 = latlng.map((element) => element).toList();
    latlongList.addAll(list2);
    List list3 = compAdd.map((element) => element).toList();
    completeAddrList.addAll(list3);
    isLoading.value = false;

    log(addressList.toString());
    log(latlongList.toString());
    log(completeAddrList.toString());
  }
}
