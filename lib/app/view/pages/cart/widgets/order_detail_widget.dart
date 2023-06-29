import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/cartcontroller.dart';
import '../../../../utils/constants/color_constants.dart';
import '../../../../utils/constants/constants.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_text.dart';
import '../../search/pages/search_page.dart';

class OrderDetailWidget extends StatelessWidget {
  OrderDetailWidget({
    super.key,
  });

  final CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => cartController.totalCount == 0
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              kHeightBox20,
              const CustomText(
                text: "Your Cart is Empty :(",
                size: 18,
              ),
              kHeightBox20,
              const Image(
                image: NetworkImage(
                  "https://www.iconbunny.com/icons/media/catalog/product/1/0/1067.12-empty-cart-icon-iconbunny.jpg",
                ),
                width: 250,
              ),
              kHeightBox10,
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: CustomButton(
                      text: CustomText(
                        text: "Explore More",
                        color: kWhite,
                        size: 16,
                        weight: FontWeight.bold,
                      ),
                      function: () => Get.to(() => SearchPage()),
                      color: kOrange,
                      padding: 0))
            ],
          )
        : ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cartController.totalCount,
            itemBuilder: (context, index) {
              
              final item = cartController.cartList[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: NetworkImage(item.image!),
                                fit: BoxFit.cover)),
                        width: 80,
                        height: 80,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 8.0, top: 0, bottom: 0),
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      text: item.name!,
                                      size: 16,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    GestureDetector(
                                        //padding: EdgeInsets.zero,
                                        onTap: () {
                                          cartController.removeFromCart(item);
                                        },
                                        child: Icon(
                                          Icons.remove_circle_outline,
                                          color: kWarning,
                                        ))
                                  ],
                                ),
                                CustomText(
                                  text: item.price.toString(),
                                  size: 16,
                                ),
                                kHeightBox10
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Expanded(
                                  child: CustomText(
                                    text: "₹250.00",
                                    size: 20,
                                    weight: FontWeight.bold,
                                  ),
                                ),
                                GetBuilder<CartController>(
                                  init: CartController(),
                                  builder: (controller) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (controller.itemCount.value >
                                                0) {
                                              controller.itemCount.value--;
                                            }
                                          },
                                          child: CircleAvatar(
                                            radius: 12,
                                            backgroundColor:
                                                kOrange.withOpacity(0.7),
                                            child: Icon(
                                              Icons.remove,
                                              size: 15,
                                              color: kWhite,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8),
                                          child: Obx(
                                            () => CustomText(
                                              text: controller.itemCount.value
                                                  .toString(),
                                              size: 18,
                                              color: kBlack,
                                              weight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            controller.itemCount.value++;
                                          },
                                          child: CircleAvatar(
                                            radius: 12,
                                            backgroundColor:
                                                kOrange.withOpacity(0.7),
                                            child: Icon(
                                              Icons.remove,
                                              size: 15,
                                              color: kWhite,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
          ));
  }
}
