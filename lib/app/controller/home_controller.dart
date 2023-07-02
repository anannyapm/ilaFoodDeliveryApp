import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/user_controller.dart';

import '../model/carousel_model.dart';
import '../model/category_model.dart';
import '../model/product_model.dart';
import '../model/restaurant_model.dart';
import '../services/firebase_services.dart';

class HomeController extends GetxController {
  static HomeController instance = Get.find();

  UserController userController = Get.put(UserController());
  //LoginController loginController = Get.put(LoginController());

  RxList<RestuarantModel> restaurants = RxList<RestuarantModel>([]);
  RxList<RestuarantModel> favRestaurants = RxList<RestuarantModel>([]);
  RxList<RestuarantModel> topRestaurants = RxList<RestuarantModel>([]);
  RxList<RestuarantModel> nearbyRestaurants = RxList<RestuarantModel>([]);
  RxList<ProductModel> restaurantBasedProducts = RxList<ProductModel>([]);
  RxList<ProductModel> products = RxList<ProductModel>([]);
  RxList<ProductModel> favProducts = RxList<ProductModel>([]);
  RxList<CategoryModel> categories = RxList<CategoryModel>([]);
  RxList<CarouselModel> carousels = RxList<CarouselModel>([]);

  RxInt primaryAddressIndex = 0.obs;

  RxList<dynamic> favList = RxList([]);

  RxBool isCategLoading = false.obs;
  RxBool isResLoading = false.obs;
  RxBool isProdLoading = false.obs;
  RxBool isCarouselLoading = false.obs;

  RxBool isRecommended = false.obs;

  RxInt itemCount = 0.obs;

  void toggleRecommended(bool value) {
    isRecommended.value = value;
  }

  void changePrimaryAddress(int index) {
    primaryAddressIndex.value = index;
    getNearbyRestaurant();
  }

  @override
  void onInit() {
    super.onInit();
    categoryCollectionRef = firebaseFirestore.collection("categories");
    restaurantCollectionRef = firebaseFirestore.collection("restaurant");
    productCollectionRef = firebaseFirestore.collection("products");
    carouselCollectionRef = firebaseFirestore.collection("carousel");
    getAllCarousel();

    getAllCategory();

    initializeRestaurants();

    getAllProducts();
  }

  void initializeRestaurants() async {
    await getAllRestaurants();
    getNearbyRestaurant();
    getTopRestaurants();
    await getFavfromUserDB();
    getFavouriteRestaurant();
  }

  Future<void> getAllCarousel() async {
    isCarouselLoading.value = true;
    final collectionData = await carouselCollectionRef.get();
    carousels.value = collectionData.docs
        .map((querysnap) => CarouselModel.fromSnapshot(querysnap))
        .toList();
    isCarouselLoading.value = false;
  }

  Future<void> getAllCategory() async {
    isCategLoading.value = true;
    final collectionData = await categoryCollectionRef.get();
    categories.value = collectionData.docs
        .map((querysnap) => CategoryModel.fromSnapshot(querysnap))
        .toList();
    isCategLoading.value = false;
  }

  void getNearbyRestaurant() {
    nearbyRestaurants.clear();
    List<RestuarantModel> nearlist = restaurants.where((restaurant) {
      final distance = Geolocator.distanceBetween(
          restaurant.location!.latitude,
          restaurant.location!.longitude,
          userController
              .userModel.location![primaryAddressIndex.value].latitude,
          userController
              .userModel.location![primaryAddressIndex.value].longitude);
      log((distance / 1000).toString());
      log((distance < 10).toString());
      return distance / 1000 < 10;
    }).toList();
    nearbyRestaurants.addAll(nearlist);
  }

  Future<void> getFavfromUserDB() async {
    final userDocRef = userCollectionRef.doc(userController.userModel.userId);

    final DocumentSnapshot userSnap = await userDocRef.get();

    final List<dynamic> fav = userSnap.get('favoriteList');

    favList = fav.map((element) => element).toList().obs;
    log("favlist:$favList");
  }

  void getTopRestaurants() {
    topRestaurants.clear();
    List<RestuarantModel> topRes =
        restaurants.where((restaurant) => restaurant.rating! > 4.0).toList();
    topRestaurants.addAll(topRes);
  }

  void getFavouriteRestaurant() {
    favRestaurants.clear();
    List<RestuarantModel> favRes = restaurants
        .where((restaurant) => favList.contains(restaurant.docId))
        .toList();
    favRestaurants.addAll(favRes);

    log("Favorite res = $favRestaurants");
  }

  Future<void> updateFavoriteStatus(String? id) async {
   
    if (favList.contains(id)) {
      await removeFromFavorites(id);
    } else {
      await addToFavorites(id);
    }
    log("Operation done $favList");
  }

  Future<void> addToFavorites(String? id) async {
    favList.add(id);
    getFavouriteRestaurant();

    final userDocRef = userCollectionRef.doc(userController.userModel.userId);
    await userDocRef.update({
      'favoriteList': FieldValue.arrayUnion([id])
    });
    log("added");
  }

  Future<void> removeFromFavorites(String? id) async {
    favList.remove(id);
    getFavouriteRestaurant();

    final userDocRef = userCollectionRef.doc(userController.userModel.userId);

    firebaseFirestore.runTransaction((transaction) async {
      final DocumentSnapshot snapshot = await transaction.get(userDocRef);

      if (snapshot.exists) {
        List<String> list = List<String>.from(snapshot.get('favoriteList'));

        list.remove(id);

        transaction.update(userDocRef, {"favoriteList": list});
        log("Deleted");
      }
    });
  }

  dynamic getrestaurant(String id) {
    for (var item in restaurants) {
      if (item.docId == id) {
        return item;
      }
    }
    return null;
  }

  Future<void> getAllRestaurants() async {
    isResLoading.value = true;

    final collectionData = await restaurantCollectionRef.orderBy('name').get();
    restaurants.value = collectionData.docs
        .map((querysnap) => RestuarantModel.fromSnapshot(querysnap))
        .toList();
    isResLoading.value = false;
  }

  Future<void> getAllProducts() async {
    isProdLoading.value = true;
    final collectionData = await productCollectionRef.get();
    products.value = collectionData.docs
        .map((querysnap) => ProductModel.fromSnapshot(querysnap))
        .toList();
    isProdLoading.value = false;
  }

  void getProductFromRestaurant(String? id) {
    if (isRecommended.value == true) {
      restaurantBasedProducts = products
          .where((product) =>
              product.restaurantId == id && product.isRecommended == true)
          .toList()
          .obs;
    } else {
      restaurantBasedProducts =
          products.where((product) => product.restaurantId == id).toList().obs;
    }
  }
}
