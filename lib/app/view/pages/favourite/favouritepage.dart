import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/view/shared/widgets/emptywidet.dart';
import 'package:ila/app/view/shared/widgets/filterdialog.dart';

import '../../../controller/auth_controller.dart';
import '../../../controller/homecontroller.dart';
import '../../../utils/constants/constants.dart';
import '../../shared/widgets/customtext.dart';
import '../../shared/widgets/restaurant_card.dart';
import '../restaurants/pages/viewrestaurant.dart';

class FavouritePage extends StatelessWidget {
  FavouritePage({super.key});
  final AuthController authController = Get.put(AuthController());
  //final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                kHeightBox10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: CustomText(
                        text: "Favorites",
                        size: 24,
                      ),
                    ),
                    IconButton(
                        onPressed: () => getFilterdialog(),
                        icon: const Icon(Icons.tune))
                  ],
                ),
                kHeightBox20,
                GetBuilder<HomeController>(
                  init: HomeController(),
                  builder: (homeController) {
                    return homeController.favRestaurants.isEmpty
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
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
