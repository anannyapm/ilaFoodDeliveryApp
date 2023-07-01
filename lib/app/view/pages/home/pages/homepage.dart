import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/home_controller.dart';
import 'package:ila/app/view/pages/categories/pages/categorypage.dart';
import 'package:ila/app/view/pages/restaurants/pages/restaurant_page.dart';
import 'package:ila/app/view/shared/widgets/custom_text.dart';
import 'package:ila/app/view/shared/widgets/empty_widet.dart';
import 'package:ila/app/view/shared/widgets/item_card.dart';
import 'package:ila/app/view/shared/widgets/restaurant_card.dart';

import '../../../../controller/user_controller.dart';
import '../../../../model/restaurant_model.dart';
import '../../../../utils/constants/constants.dart';
import '../../restaurants/pages/view_restaurant.dart';
import '../../search/pages/search_page.dart';
import '../widgets/carouselcard.dart';
import '../widgets/headerwidget.dart';
import '../widgets/searchwidget.dart';
import '../widgets/sectiontitle.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final UserController userController = Get.put(UserController());
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderWidget(userController: userController),
                kHeightBox20,
                const SearchWidget(),
                kHeightBox20,
                SectionTitleWidget(
                  title: "Categories",
                  function: () => Get.to(() => const CategoryPage()),
                ),
                SizedBox(
                    height: 190,
                    child: Obx(() {
                      return homeController.isCategLoading.value == true
                          ? const Center(child: CircularProgressIndicator())
                          : homeController.categories.isEmpty
                              ? const Center(
                                  child:
                                      CustomText(text: "No Categories Found"),
                                )
                              : ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: homeController.categories.length,
                                  itemBuilder: (context, index) {
                                    final item =
                                        homeController.categories[index];
                                    return ItemCard(
                                        imageUrl: item.imageUrl!,
                                        title: item.name!,
                                        price: item.price!,
                                        onTap: () {
                                          Get.to(() => SearchPage(
                                                categoryName: item.name!,
                                              ));
                                        });
                                  },
                                );
                    })),
                kHeightBox20,
                Obx(() => homeController.isCarouselLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : const CarouselCard()),
                kHeightBox20,
                kHeightBox10,
                SectionTitleWidget(
                  title: homeController.nearbyRestaurants.isEmpty
                      ? "Top Restaurants"
                      : "Restaurants Near You",
                  function: () => Get.to(() => RestaurantPage()),
                ),
                kHeightBox10,
                Obx(
                  () {
                    RxList<RestuarantModel> listReferenceList =
                        homeController.nearbyRestaurants.isEmpty
                            ? homeController.topRestaurants
                            : homeController.nearbyRestaurants;
                    return homeController.isResLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : listReferenceList.isEmpty?const EmptyWidget(): ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: listReferenceList.length,
                            itemBuilder: (context, index) {
                              final resItem =
                                  listReferenceList[index];
                              return RestaurantCard(
                                restaurant: resItem,

                                onTap: () {
                                  Get.to(() =>
                                      ViewRestaurantPage(restaurant: resItem));
                                },

                                // isFav: resItem.isFavorite!
                              );
                            },
                          );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
