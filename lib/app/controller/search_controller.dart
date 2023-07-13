import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/category_model.dart';
import '../model/product_model.dart';
import '../model/restaurant_model.dart';
import 'home_controller.dart';

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

  void setValues() {
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

  void clearSearch() {
    controller.clear();
    isSearchActive.value = false;
    searchResults.clear();
    searchResults.addAll(popularResult);

    myfocusNode.unfocus();
  }

  void searchForKey(String keyword) {
    searchResults.clear();

    List<Map<String, dynamic>> fetchSearchList = [];
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
        fetchSearchList.add({"Restaurant": val});
      }
    }

    final List<ProductModel> matchingProducts = products
        .where((product) =>
            product.name!.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
    if (matchingProducts.isNotEmpty) {
      for (var val in matchingProducts) {
        fetchSearchList.add({"Dish": val});
      }
    }

    final List<ProductModel> matchingProdCategories = products
        .where((product) =>
            product.categoryName!
                .toLowerCase()
                .contains(keyword.toLowerCase()) &&
            !fetchSearchList.contains({"Dish": product}))
        .toList();
    if (matchingProdCategories.isNotEmpty) {
      for (var val in matchingProdCategories) {
        fetchSearchList.add({"Dish": val});
      }
    }
    log("res $fetchSearchList");
    isSearchActive.value = true;
    searchResults.addAll(fetchSearchList);
    log("searchres: $searchResults");
  }

  //filter section

  RxBool filterEnabled = false.obs;

  final Rx<RangeValues> _selectedRange = const RangeValues(0.0, 2000.0).obs;

  RangeValues get selectedRange => _selectedRange.value;
  double minPrice = 0;
  double maxPrice = 2000;

  setRange(RangeValues values) {
    _selectedRange.value = values;
  }

  final RxDouble _selectedRating = 0.0.obs;
  double get selectedRating => _selectedRating.value;

  setRating(double value) {
    _selectedRating.value = value;
  }

  final RxInt _selectedChipIndex = 0.obs;

  int get selectedChipIndex => _selectedChipIndex.value;

  List<String> options = [
    '10-20',
    '20-30',
    '30-40',
  ];
  setSelectedIndex(bool value, int index) {
    _selectedChipIndex.value = value ? index : -1;
  }

  final RxList<Map<String, dynamic>> filterResult =
      <Map<String, dynamic>>[].obs;

  void filterData() {
    filterResult.clear();
    final List<Map<String, dynamic>> filterList = [];

    filterEnabled.value = true;

    for (Map<String, dynamic> data in searchResults) {
      if (data.keys.first == "Dish") {
        bool f1 = false;
        bool f2 = false;
        bool f3 = false;
        for (RestuarantModel res in restaurants) {
          if (res.docId == data.values.first.restaurantId) {
            if (selectedChipIndex == -1) {
              f1 = true;
            } else {
              if (res.deliverytime == options[selectedChipIndex]) {
                f1 = true;
              } else {
                f1 = false;
              }
            }

            if ((selectedRange.start <= data.values.first.price &&
                data.values.first.price <= selectedRange.end)) {
              f2 = true;
            }
            if (res.rating! >= selectedRating) {
              f3 = true;
            }

            if (f1 && f2 && f3) {
              filterList.add(data);
            }
          }
        }
      } else {
        bool f1 = false;

        final res = data.values.first;
        if (selectedChipIndex == -1) {
          f1 = true;
        } else {
          if (res.deliverytime == options[selectedChipIndex]) {
            f1 = true;
          } else {
            f1 = false;
          }
        }
        if (f1 && res.rating! >= selectedRating) {
          filterList.add(data);
        }
      }
    }
    filterResult.addAll(filterList);
  }

  void clearFilter() {
    _selectedRange.value = const RangeValues(0.0, 2000.0);
    _selectedRating.value = 0.0;
    _selectedChipIndex.value = 0;
    filterEnabled.value = false;
  }
}
