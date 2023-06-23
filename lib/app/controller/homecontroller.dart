

import 'package:get/get.dart';

import '../model/carousel_model.dart';
import '../model/category_model.dart';
import '../model/product_model.dart';
import '../model/restaurant_model.dart';
import '../services/firebase_services.dart';

class HomeController extends GetxController {
  RxList<RestuarantModel> restaurants = RxList<RestuarantModel>([]);
  RxList<ProductModel> restaurantBasedProducts = RxList<ProductModel>([]);
  RxList<ProductModel> products = RxList<ProductModel>([]);
  RxList<CategoryModel> categories = RxList<CategoryModel>([]);
  RxList<CarouselModel> carousels = RxList<CarouselModel>([]);

  RxBool isCategLoading = false.obs;
  RxBool isResLoading = false.obs;
  RxBool isProdLoading = false.obs;
  RxBool isCarouselLoading = false.obs;

  RxBool isRecommended = false.obs;

  RxInt itemCount = 0.obs;
  RxBool isEditMode = true.obs;


  void changeEditMode() {
    isEditMode.value = !isEditMode.value;
  }

  void toggleRecommended(bool value) {
    isRecommended.value = value;
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

    getAllRestaurants();
    getAllProducts();
  }

  Future<void> getAllCarousel() async {
    isCarouselLoading.value = false;
    final collectionData = await carouselCollectionRef.get();
    carousels.value = collectionData.docs
        .map((querysnap) => CarouselModel.fromSnapshot(querysnap))
        .toList();
    isCarouselLoading.value = true;
  }

  Future<void> getAllCategory() async {
    isCategLoading.value = true;
    final collectionData = await categoryCollectionRef.get();
    categories.value = collectionData.docs
        .map((querysnap) => CategoryModel.fromSnapshot(querysnap))
        .toList();
    isCategLoading.value = false;
  }

  RxList<RestuarantModel> get nearbyRestaurants {
    return restaurants.where((restaurant) => restaurant.isNear!).toList().obs;
  }
  RxList<RestuarantModel> get favouriteRestaurant {
    return restaurants.where((restaurant) => restaurant.isFavorite!).toList().obs;
  }

  String restaurantName(String id) {
    for (var item in restaurants) {
      if (item.docId == id) {
        return item.name!;
      }
    }
    return "";
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

  /* Future<void> getAllProductsFromRestaurant(String? id) async {
    final collectionData =
        await productCollectionRef.where('restaurant_id', isEqualTo: id).get();
    restaurantBasedProducts.value = collectionData.docs
        .map((querysnap) => ProductModel.fromSnapshot(querysnap))
        .toList();
  } */
}
