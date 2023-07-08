import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/utils/constants/constants.dart';
import 'package:ila/app/view/pages/restaurants/pages/view_restaurant.dart';
import 'package:ila/app/view/shared/widgets/custom_text.dart';
import 'package:ila/app/view/shared/widgets/empty_widet.dart';

import '../../../../utils/constants/color_constants.dart';
import '../../../../utils/constants/controllers.dart';
import '../../../shared/widgets/restaurant_card.dart';

class RestaurantPage extends StatelessWidget {
  

   const RestaurantPage({super.key});
 // final HomeController homeController=Get.put(HomeController());
  
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
                child: Obx(() 
                {
                    return homeController.isResLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        :homeController.restaurants.isEmpty?const EmptyWidget()
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: homeController.restaurants.length,
                            itemBuilder: (context, index) {
                              final resItem = homeController.restaurants[index];
                              return RestaurantCard(
                                restaurant: resItem,
                                
                                  onTap: () =>Get.to(()=>ViewRestaurantPage(restaurant: resItem)),
                                  
                                  );
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
