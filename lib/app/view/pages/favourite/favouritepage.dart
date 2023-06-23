import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/view/shared/widgets/filterdialog.dart';

import '../../../controller/auth_controller.dart';
import '../../../controller/homecontroller.dart';
import '../../../utils/constants/color_constants.dart';
import '../../../utils/constants/constants.dart';
import '../../shared/widgets/customtext.dart';
import '../../shared/widgets/emptywidet.dart';
import '../../shared/widgets/restaurant_card.dart';
import '../restaurants/pages/viewrestaurant.dart';

class FavouritePage extends StatelessWidget {
   FavouritePage({super.key});
  final AuthController authController = Get.put(AuthController());


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
                          text: "Favorites",
                          size: 20,
                        )
                      ],
                    ),
                    IconButton(onPressed: ()=>getFilterdialog(), icon: Icon(Icons.tune))
                  ],
                ),
             
                kHeightBox50,
                GetBuilder<HomeController>(
                    init: HomeController(),
                    builder: (controller) {
        
                      return controller.isResLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          :controller.favouriteRestaurant.isEmpty?const EmptyWidget():
                           ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.favouriteRestaurant.length,
                              itemBuilder: (context, index) {
        
                                final resItem = controller.favouriteRestaurant[index];
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