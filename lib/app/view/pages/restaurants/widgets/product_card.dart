import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:ila/app/controller/cart_controller.dart';
import 'package:ila/app/model/product_model.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/view/shared/widgets/custom_text.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onTap;

  ProductCard({
    super.key,
    required this.onTap,
    required this.product,
  });

  final CartController cartController = Get.find();
  //final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 260,
        width: 145,
        margin: const EdgeInsets.only(right: 5, top: 10),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          surfaceTintColor: kWhite,
          color: kWhite,
          elevation: 4,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  height: 104,
                  width: 122,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: kGrey.withOpacity(0.7),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset:
                              const Offset(0, 3), // changes the shadow position
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(product.image!),
                        fit: BoxFit.cover,
                      )),
                  margin: const EdgeInsets.fromLTRB(12, 12, 12, 5),
                ),
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
                          color: kBlueShade,
                        ),
                        Obx(() => IconButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(kOrange)),
                            onPressed: () {
                              bool isAdded =
                                  cartController.isItemAlreadyAdded(product);
                              //cartController.cartList.where((cartitem) => cartitem.productId==product.docId);

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