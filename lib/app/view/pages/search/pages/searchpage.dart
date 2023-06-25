import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/homecontroller.dart';
import 'package:ila/app/utils/constants/constants.dart';
import 'package:ila/app/view/pages/restaurants/pages/productpage.dart';
import 'package:ila/app/view/pages/restaurants/pages/restaurantpage.dart';
import 'package:ila/app/view/pages/restaurants/pages/viewrestaurant.dart';
import 'package:ila/app/view/shared/widgets/customtext.dart';
import 'package:ila/app/view/shared/widgets/filterdialog.dart';

import '../../../../controller/searchcontroller.dart';
import '../../../../utils/constants/color_constants.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final SearchFilterController searchController =
        Get.put(SearchFilterController());
    return Scaffold(
        body: SafeArea(
      child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              kHeightBox20,
              SearchBar(
                controller: searchController.controller,
                focusNode: searchController.myfocusNode,
                onTap: () => searchController.myfocusNode.requestFocus(),
                /* onTap: () => searchController.isSearchActive.value=true,
                onChanged: (value) => searchController.searchForKey(value), */

                hintText: "Search dishes,restaurants",
                trailing: [
                  IconButton(
                      onPressed: () {
                        searchController.controller.clear();
                        searchController.isSearchActive.value = false;
                        searchController.myfocusNode.unfocus();
                      },
                      icon: const Icon(Icons.close))
                ],
                padding: const MaterialStatePropertyAll(
                    EdgeInsets.only(left: 15, right: 15)),
                leading: Icon(
                  Icons.search_outlined,
                  color: kGreylight,
                ),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18))),
                backgroundColor:
                    MaterialStatePropertyAll(kGreylight.withOpacity(0.2)),
                elevation: const MaterialStatePropertyAll(0),
              ),
              kHeightBox10,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() => CustomText(
                        size: 18,
                        weight: FontWeight.bold,
                        text: searchController.isSearchActive.value == false
                            ? "Popular Searches"
                            : "Search Results")),
                    IconButton(
                        onPressed: () {
                          getFilterdialog();
                        },
                        icon: const Icon(Icons.tune)),
                  ],
                ),
              ),
              Expanded(
                child: Obx(
                  () {
                    return searchController.searchResults.isEmpty
                        ? Center(
                            child: CustomText(text: "No Results Found"),
                          )
                        : ListView.separated(
                            itemCount: searchController.searchResults.length,
                            itemBuilder: (context, index) {
                              final Map searchresult =
                                  searchController.searchResults[index];
                              log(searchresult.toString());
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    if (searchresult.keys.first ==
                                        'Restaurant') {
                                      Get.to(()=>ViewRestaurantPage(restaurant: searchresult
                                                  .values.first));
                                    }
                                    else if (searchresult.keys.first ==
                                        'Dish') {
                                      Get.to(()=>ProductPage(product:  searchresult
                                                  .values.first));
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 80,
                                        width: 80,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10.0)),
                                            image: DecorationImage(
                                              image: NetworkImage(searchresult
                                                  .values.first.image),
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                      kWidthBox15,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            text:
                                                searchresult.values.first.name,
                                            weight: FontWeight.bold,
                                            size: 16,
                                          ),
                                          CustomText(
                                            text: searchresult.keys.first,
                                            weight: FontWeight.w500,
                                            color: kGreyDark,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const Divider(),
                          );
                  },
                ),
              ),
            ],
          )),
    ));
  }
}
