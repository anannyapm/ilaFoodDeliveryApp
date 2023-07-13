import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/home_controller.dart';
import 'package:ila/app/utils/constants/constants.dart';
import 'package:ila/app/view/pages/restaurants/pages/product_page.dart';
import 'package:ila/app/view/pages/restaurants/pages/view_restaurant.dart';
import 'package:ila/app/view/shared/widgets/custom_text.dart';
import 'package:ila/app/view/shared/widgets/filter_dialog.dart';

import '../../../../controller/search_controller.dart';
import '../../../../utils/constants/color_constants.dart';
import '../../../shared/widgets/close_widget.dart';
import '../../home/pages/navigationpage.dart';

class SearchPage extends StatelessWidget {
  final String categoryName;
  SearchPage({
    super.key,
    this.categoryName = "",
  });

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final SearchFilterController searchController =
        Get.put(SearchFilterController());
    if (categoryName != "") {
      searchController.controller.text = categoryName;
    }

    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                kHeightBox10,
                Row(
                  children: [
                    CloseWidget(
                        actionfunction: () => Get.offAll(
                              NavigationPage(),
                            )),
                    kWidthBox15,
                    const CustomText(
                      text: "Search",
                      size: 20,
                    )
                  ],
                ),
                kHeightBox20,
                SearchBar(
                  controller: searchController.controller,
                  focusNode: searchController.myfocusNode,
                  onTap: () {
                    searchController.myfocusNode.requestFocus();
                  },
                  hintText: "Search dishes,restaurants",
                  trailing: [
                    IconButton(
                        onPressed: () {
                          searchController.clearSearch();
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
                Obx(
                  () {
                    final RxList<Map<String, dynamic>> activeList =
                        searchController.filterEnabled.value
                            ? searchController.filterResult
                            : searchController.searchResults;
                    return activeList.isEmpty
                        ? const Center(
                            child: CustomText(text: "No Results Found"),
                          )
                        : ListView.separated(
                          shrinkWrap: true,
                         physics: const NeverScrollableScrollPhysics(),
                            itemCount: activeList.length,
                            itemBuilder: (context, index) {
                              final Map searchresult = activeList[index];
                              log(searchresult.toString());
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    if (searchresult.keys.first ==
                                        'Restaurant') {
                                      categoryName.isEmpty
                                          ? Get.to(() => ViewRestaurantPage(
                                              restaurant:
                                                  searchresult.values.first))
                                          : Get.off(() => ViewRestaurantPage(
                                              restaurant:
                                                  searchresult.values.first));
                                    } else if (searchresult.keys.first ==
                                        'Dish') {
                                      categoryName.isEmpty
                                          ? Get.to(() => ProductPage(
                                              product:
                                                  searchresult.values.first))
                                          : Get.off(() => ProductPage(
                                              product:
                                                  searchresult.values.first));
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 80,
                                        width: 80,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                         
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: FadeInImage(
                                            fadeInDuration: const Duration(
                                                milliseconds: 300),
                                            placeholder: const AssetImage(
                                                'assets/images/placeholder.jpg'),
                                            image: NetworkImage(searchresult
                                                .values.first.image!),
                                            imageErrorBuilder:
                                                (context, error, stackTrace) =>
                                                    Image.asset(
                                              'assets/images/placeholder.jpg',
                                              fit: BoxFit.cover,
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
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
                                            color:Get.isDarkMode ? kWhite.withOpacity(0.7): kGreyDark,
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
              ],
            )),
      ),
    ));
  }
}
