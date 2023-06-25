import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/category_model.dart';
import '../model/product_model.dart';
import '../model/restaurant_model.dart';
import 'homecontroller.dart';

class SearchFilterController extends GetxController {
  final HomeController homeController = Get.put(HomeController());
  TextEditingController controller = TextEditingController();
  FocusNode myfocusNode = FocusNode();

  List<RestuarantModel> restaurants = [];
  List<ProductModel> products = [];
  List<CategoryModel> categories = [];

  RxBool isSearchActive = false.obs;

  @override
  void onInit() {
    super.onInit();
    setValues();
    setPopularList();
    myfocusNode = FocusNode();
    controller.addListener(searchListner);
  }

  @override
  void dispose() {
    controller.removeListener(searchListner);
    controller.dispose();
    myfocusNode.dispose();
    super.dispose();
  }

  void searchListner() {
    searchForKey(controller.text.trim());
  }

  setValues() {
    restaurants = homeController.restaurants;
    products = homeController.products;
    categories = homeController.categories;
  }

  final RxList<Map<String, dynamic>> searchResults =
      <Map<String, dynamic>>[].obs;

  final List<Map<String, dynamic>> popularResult = [];

  void setPopularList() {
    for (int i = 0; i < restaurants.length / 2; i++) {
      popularResult.add({"Restaurant": restaurants[i]});
    }
    for (int i = 0; i < products.length / 2; i++) {
      popularResult.add({"Dish": products[i]});
    }
    searchResults.addAll(popularResult);
    log(popularResult.toString());
  }

  void searchForKey(String keyword) {
    searchResults.clear();

    List<Map<String, dynamic>> filteredResult = [];
    if (keyword.isEmpty) {
      isSearchActive.value = false;
      searchResults.addAll(popularResult);
      return;
    }

    final List<RestuarantModel> matchingRestaurants = restaurants
        .where((restaurant) =>
            restaurant.name!.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
    if (matchingRestaurants.isNotEmpty) {
      for (var val in matchingRestaurants) {
        filteredResult.add({"Restaurant": val});
      }
    }

    final List<ProductModel> matchingProducts = products
        .where((product) =>
            product.name!.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
    if (matchingProducts.isNotEmpty) {
      for (var val in matchingProducts) {
        filteredResult.add({"Dish": val});
      }
    }

    final List<ProductModel> matchingProdCategories = products
        .where((product) =>
            product.categoryName!
                .toLowerCase()
                .contains(keyword.toLowerCase()) &&
            !filteredResult.contains({"Dish": product}))
        .toList();
    if (matchingProdCategories.isNotEmpty) {
      for (var val in matchingProdCategories) {
        filteredResult.add({"Dish": val});
      }
    }
    log("res $filteredResult");
    isSearchActive.value = true;
    searchResults.addAll(filteredResult);
    log("searchres: $searchResults");
  }
}
