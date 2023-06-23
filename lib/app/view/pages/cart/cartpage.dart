import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/auth_controller.dart';
import 'package:ila/app/controller/cartcontroller.dart';
import 'package:ila/app/controller/login_controller.dart';
import 'package:ila/app/view/pages/cart/widgets/changeaddress.dart';
import 'package:ila/app/view/pages/cart/widgets/ordersummary.dart';

import '../../../utils/constants/color_constants.dart';
import '../../../utils/constants/constants.dart';
import '../../shared/widgets/custombutton.dart';
import '../../shared/widgets/customtext.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});

  final AuthController authController = Get.put(AuthController());
  final LoginController loginController = Get.put(LoginController());

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
                          text: "My Cart Items",
                          size: 20,
                        )
                      ],
                    ),
                  ],
                ),
                kHeightBox20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "DELIVERY ADDRESS",
                          color: kGrey,
                          size: 15,
                        ),
                        Obx(() => CustomText(
                              text: authController.userModel.address![
                                  loginController.primaryAddressIndex.value],
                              color: kGreyDark,
                              size: 16,
                            )),
                      ],
                    ),
                    TextButton(
                        onPressed: () => showChangeAddressBottomSheet(),
                        child: CustomText(
                          text: "CHANGE",
                          color: kOrange,
                          size: 14,
                          weight: FontWeight.bold,
                        ))
                  ],
                ),
                kHeightBox50,
                const OrderDetailWidget(),
                kHeightBox20,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        text: "Price Details",
                        size: 18,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: "Price",
                            color: kGreyDark,
                            size: 16,
                          ),
                          CustomText(
                            text: "₹250.00",
                            color: kGreyDark,
                            size: 16,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: "Discount",
                            color: kGreyDark,
                            size: 16,
                          ),
                          CustomText(
                            text: "₹50.00",
                            color: kGreyDark,
                            size: 16,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: "Delivery Charges",
                            color: kGreyDark,
                            size: 16,
                          ),
                          CustomText(
                            text: "₹50.00",
                            color: kGreyDark,
                            size: 16,
                          ),
                        ],
                      ),
                      kHeightBox20,
                      Row(
                        children: [
                          const Spacer(),
                          CustomText(
                            text: "Total: ",
                            color: kGreyDark,
                            size: 18,
                          ),
                          const CustomText(
                            text: "₹250.00",
                            size: 24,
                            weight: FontWeight.bold,
                          )
                        ],
                      ),
                      kHeightBox20,
                      SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                            padding: 15,
                            text: CustomText(
                              text: "PLACE ORDER",
                              color: kWhite,
                              size: 18,
                              weight: FontWeight.bold,
                            ),
                            function:  () {
                              return showOrderSummarySheet();
                            },
                            color: kGreen)
                       
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OrderDetailWidget extends StatelessWidget {
  const OrderDetailWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) {
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
                      image: const DecorationImage(
                          image: NetworkImage(
                            "https://images.pexels.com/photos/2679501/pexels-photo-2679501.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                          ),
                          fit: BoxFit.cover)),
                  width: 120,
                  height: 120,
                ),
              ),
           
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                  child: CustomText(
                                text: "Order Item Name #1255666",
                                lines: 2,
                                size: 16,
                                overflow: TextOverflow.ellipsis,
                              )),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.remove_circle_outline,
                                    color: kWarning,
                                  ))
                            ],
                          ),
                          const CustomText(
                            text: "₹250.00",
                            size: 16,
                          ),
                          kHeightBox20
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (controller.itemCount.value > 0) {
                                        controller.itemCount.value--;
                                      }
                                    },
                                    child: CircleAvatar(
                                      radius: 12,
                                      backgroundColor: kOrange.withOpacity(0.7),
                                      child: Icon(
                                        Icons.remove,
                                        size: 15,
                                        color: kWhite,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 8, right: 8),
                                    child: Obx(
                                      () => CustomText(
                                        text:
                                            controller.itemCount.value.toString(),
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
                                      backgroundColor: kOrange.withOpacity(0.7),
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
    );
  }
}
