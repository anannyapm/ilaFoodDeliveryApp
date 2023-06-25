import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/homecontroller.dart';
import 'package:ila/app/view/pages/categories/pages/categorypage.dart';
import 'package:ila/app/view/pages/restaurants/pages/restaurantpage.dart';
import 'package:ila/app/view/shared/widgets/customtext.dart';
import 'package:ila/app/view/shared/widgets/emptywidet.dart';
import 'package:ila/app/view/shared/widgets/itemcard.dart';
import 'package:ila/app/view/shared/widgets/restaurant_card.dart';

import '../../../../controller/auth_controller.dart';
import '../../../../utils/constants/constants.dart';
import '../../restaurants/pages/viewrestaurant.dart';
import '../widgets/carouselcard.dart';
import '../widgets/headerwidget.dart';
import '../widgets/searchwidget.dart';
import '../widgets/sectiontitle.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final AuthController authController = Get.put(AuthController());
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
                HeaderWidget(authController: authController),
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
                                        onTap: () {});
                                  },
                                );
                    })),
                kHeightBox20,
                Obx(() => homeController.isCarouselLoading.value?const Center(child: CircularProgressIndicator(),): const CarouselCard()),
                kHeightBox20,
                kHeightBox10,
                SectionTitleWidget(
                  title: "Restaurants Near You",
                  function: () => Get.to(() => RestaurantPage()),
                ),
                kHeightBox10,
                Obx(
                  () {
                    return homeController.isResLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : homeController.nearbyRestaurants.isEmpty
                            ? const EmptyWidget()
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    homeController.nearbyRestaurants.length,
                                itemBuilder: (context, index) {
                                  final resItem =
                                      homeController.nearbyRestaurants[index];
                                  return RestaurantCard(
                                    restaurant: resItem,

                                    onTap: () {
                                      
                                      Get.to(() => ViewRestaurantPage(
                                          restaurant: resItem));
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
