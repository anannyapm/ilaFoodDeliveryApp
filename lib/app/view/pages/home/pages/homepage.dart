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
                  function: () => Get.to(()=>const CategoryPage()),
                ),
                SizedBox(
                  height: 190,
                  child: GetBuilder<HomeController>(
                    init: HomeController(),
                    builder: (homecontroller) {
                      return homecontroller.isCategLoading.value == true
                          ? const Center(child: CircularProgressIndicator())
                          : homecontroller.categories.isEmpty
                              ? const Center(
                                  child:
                                      CustomText(text: "No Categories Found"),
                                )
                              : ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: homecontroller.categories.length,
                                  itemBuilder: (context, index) {
                                    final item =
                                        homecontroller.categories[index];
                                    return ItemCard(
                                        imageUrl: item.imageUrl!,
                                        title: item.name!,
                                        price: item.price!,
                                        onTap: () {});
                                  },
                                );
                    },
                  ),
                ),
                kHeightBox20,
                 CarouselCard(),
                kHeightBox20,
                kHeightBox10,
                 SectionTitleWidget(
                  title: "Restaurants Near You",
                  function: () => Get.to(()=>const RestaurantPage()),

                ),
                kHeightBox10,
                GetBuilder<HomeController>(
                  init: HomeController(),
                  builder: (controller) {

                    return controller.isResLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        :controller.nearbyRestaurants.isEmpty?const EmptyWidget():
                         ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.nearbyRestaurants.length,
                            itemBuilder: (context, index) {

                              final resItem = controller.nearbyRestaurants[index];
                              return RestaurantCard(
                                  imageUrl: resItem.image!,
                                 onTap: () =>Get.to(()=>ViewRestaurantPage(restaurant: resItem)),

                                  rName: resItem.name!,
                                  rTag: resItem.tagline!,
                                  deliveryCharge:
                                      resItem.deliveryfee.toString(),
                                  deliveryTime: resItem.deliverytime!,
                                  rate: resItem.rating!,
                                  isFav: resItem.isFavorite!);
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
