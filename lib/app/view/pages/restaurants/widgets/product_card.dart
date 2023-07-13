import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/cart_controller.dart';
import 'package:ila/app/model/product_model.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/view/shared/widgets/custom_text.dart';

import '../pages/product_page.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  ProductCard({
    super.key,
    required this.product,
  });

  final CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => ProductPage(product: product)),
      child: Container(
        height: 280,
        //width: 120,
        margin: const EdgeInsets.only(top: 10),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          surfaceTintColor: Get.isDarkMode ? kGrey.withOpacity(0.6) : kWhite,
          color: Get.isDarkMode ? kGrey.withOpacity(0.6) : kWhite,
          elevation: 4,
          child: Column(
            children: [
              Expanded(
                child: Container(
                    // height: 80,
                    width: 140,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Get.isDarkMode
                              ? kWhite.withOpacity(0.1)
                              : kGrey.withOpacity(0.7),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset:
                              const Offset(0, 3), // changes the shadow position
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.fromLTRB(5, 12, 5, 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FadeInImage(
                        fadeInDuration: const Duration(milliseconds: 300),
                        placeholder:
                            const AssetImage('assets/images/placeholder.jpg'),
                        image: NetworkImage(product.image!),
                        imageErrorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                          'assets/images/placeholder.jpg',
                          fit: BoxFit.cover,
                        ),
                        fit: BoxFit.cover,
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      overflow: TextOverflow.ellipsis,
                      text: product.name!,
                      size: 15,
                      weight: FontWeight.bold,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "₹${product.price}",
                          size: 14,
                          color: Get.isDarkMode ? kWhite : kBlueShade,
                        ),
                        Obx(() => IconButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(kOrange)),
                            onPressed: () {
                              bool isAdded =
                                  cartController.isItemAlreadyAdded(product);

                              if (isAdded) {
                                cartController.removeCartItem(product.docId!);
                              } else {
                                cartController.addProductToCart(product, 1);
                              }
                              isAdded = !isAdded;
                            },
                            icon: Icon(
                              cartController.isItemAlreadyAdded(product)
                                  ? Icons.remove
                                  : Icons.add,
                              color: kWhite,
                            )))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
