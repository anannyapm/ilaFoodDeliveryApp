import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/view/shared/widgets/empty_widet.dart';

import '../../../controller/auth_controller.dart';
import '../../../controller/homecontroller.dart';
import '../../../utils/constants/constants.dart';
import '../../shared/widgets/custom_text.dart';
import '../../shared/widgets/restaurant_card.dart';
import '../restaurants/pages/view_restaurant.dart';

class FavouritePage extends StatelessWidget {
  FavouritePage({super.key});
  final AuthController authController = Get.put(AuthController());
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kHeightBox10,
                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: CustomText(
                    text: "My Favorites",
                    size: 24,
                  ),
                ),
                kHeightBox20,
                Obx(() => homeController.favRestaurants.isEmpty
                        ? const EmptyWidget()
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: homeController.favRestaurants.length,
                            itemBuilder: (context, index) {
                              final resItem =
                                  homeController.favRestaurants[index];
                              return RestaurantCard(
                                restaurant: resItem,
                                onTap: () {
                                  Get.to(() =>
                                      ViewRestaurantPage(restaurant: resItem));
                                },
                              );
                            },
                          )),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
