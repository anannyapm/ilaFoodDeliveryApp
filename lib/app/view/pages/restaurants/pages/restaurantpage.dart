import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/homecontroller.dart';
import 'package:ila/app/utils/constants/constants.dart';
import 'package:ila/app/view/pages/restaurants/pages/viewrestaurant.dart';
import 'package:ila/app/view/shared/widgets/customtext.dart';
import 'package:ila/app/view/shared/widgets/emptywidet.dart';

import '../../../../utils/constants/color_constants.dart';
import '../../../shared/widgets/restaurant_card.dart';

class RestaurantPage extends StatelessWidget {
  

  const RestaurantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              kHeightBox10,
              Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            kGreylight.withOpacity(0.4))),
                    icon: const Icon(
                      Icons.keyboard_arrow_left,
                      size: 30,
                    ),
                  ),
                  kWidthBox15,
                  const CustomText(
                    text: "Restaurants",
                    size: 20,
                  )
                ],
              ),
              kHeightBox20,
              Expanded(
                child: GetBuilder<HomeController>(
                  init: HomeController(),
                  builder: (controller) {
                    return controller.isResLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        :controller.restaurants.isEmpty?const EmptyWidget()
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: controller.restaurants.length,
                            itemBuilder: (context, index) {
                              final resItem = controller.restaurants[index];
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
