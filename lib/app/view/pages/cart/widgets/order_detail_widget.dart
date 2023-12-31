import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/home_controller.dart';
import 'package:ila/app/model/cart_model.dart';

import '../../../../controller/cart_controller.dart';
import '../../../../utils/constants/color_constants.dart';
import '../../../../utils/constants/constants.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_text.dart';
import '../../search/pages/search_page.dart';

class OrderDetailWidget extends StatelessWidget {
  OrderDetailWidget({
    super.key,
  });

  final CartController cartController = Get.put(CartController());
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => cartController.totalCount == 0
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CustomText(
                  text: "Your Cart is Empty :(",
                  size: 18,
                ),
                kHeightBox20,
                const Image(
                  image: AssetImage(
                    "assets/images/emptycart.png",
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
                        function: () => Get.off(() => SearchPage()),
                        color: kOrange,
                        padding: 0))
              ],
            ),
          )
        : ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cartController.totalCount,
            itemBuilder: (context, index) {
              CartItemModel item = cartController.cartList[index];
              bool isProdAvailable =
                  homeController.checkIfProductExist(item.productId!);
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
                        ),
                        width: 70,
                        height: 70,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: FadeInImage(
                            fadeInDuration: const Duration(milliseconds: 300),
                            placeholder: const AssetImage(
                                'assets/images/placeholder.jpg'),
                            image: NetworkImage(item.image!),
                            imageErrorBuilder: (context, error, stackTrace) =>
                                Image.asset(
                              'assets/images/placeholder.jpg',
                              fit: BoxFit.cover,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: item.name!.toUpperCase(),
                                          size: 16,
                                          overflow: TextOverflow.ellipsis,
                                          weight: FontWeight.bold,
                                          lines: 2,
                                        ),
                                      ],
                                    ),
                                    InkWell(
                                        //padding: EdgeInsets.zero,
                                        onTap: () {
                                          cartController
                                              .removeCartItem(item.productId!);
                                        },
                                        child: Icon(
                                          Icons.close,
                                          color: Get.isDarkMode
                                              ? kWhite
                                              : kGreylight,
                                          size: 22,
                                        ))
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: CustomText(
                                    text: "₹${item.price! * item.quantity!}",
                                    size: 18,
                                    weight: FontWeight.bold,
                                  ),
                                ),
                                // Obx(() =>
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        cartController
                                            .decreaseQuantity(item.productId!);
                                      },
                                      child: CircleAvatar(
                                        radius: 12,
                                        backgroundColor: Get.isDarkMode
                                            ? kWhite
                                            : kGrey.withOpacity(0.3),
                                        child: Icon(
                                          Icons.remove,
                                          size: 15,
                                          color: kBlack,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8),
                                      child: //Obx(
                                          //() =>
                                          CustomText(
                                        text: item.quantity.toString(),
                                        size: 18,
                                        color: Get.isDarkMode ? kWhite : kBlack,
                                        weight: FontWeight.bold,
                                      ),
                                    ),
                                    //),
                                    InkWell(
                                      onTap: () {
                                        cartController
                                            .increaseQuantity(item.productId!);
                                      },
                                      child: CircleAvatar(
                                        radius: 12,
                                        backgroundColor: Get.isDarkMode
                                            ? kWhite
                                            : kGrey.withOpacity(0.3),
                                        child: Icon(
                                          Icons.add,
                                          size: 15,
                                          color: kBlack,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            !isProdAvailable
                                ?  Center(
                                  child: CustomText(
                                    align: TextAlign.center,
                                      text:
                                          "Item Not Available.Please Remove from Cart",size: 12,color: kWarning,weight: FontWeight.bold,),
                                )
                                : Container(),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(
              color: kGreylight.withOpacity(0.2),
            ),
          ));
  }
}
