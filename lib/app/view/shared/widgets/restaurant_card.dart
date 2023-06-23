import 'package:flutter/material.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/utils/constants/constants.dart';
import 'package:ila/app/view/shared/widgets/customtext.dart';

class RestaurantCard extends StatelessWidget {
  final String imageUrl;
  final String rName;
  final String rTag;
  final VoidCallback onTap;
  final String deliveryCharge;
  final String deliveryTime;
  final num rate;
  final bool isFav;

  const RestaurantCard({
    super.key,
    required this.imageUrl,
    required this.onTap,
    required this.rName,
    required this.rTag,
    required this.deliveryCharge,
    required this.deliveryTime,
    required this.rate,
    required this.isFav,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 145,
      height: 260,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        surfaceTintColor: kWhite,
        color: kWhite,
        elevation: 4,
        child: GestureDetector(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      )),
                ),
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: kBlack.withOpacity(0.2)),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: IconButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(kWhite)),
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite,
                          color: isFav == true ? kGreen : kGreyDark,
                        )),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 30,
                        width: 65,
                        decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.star_rounded,
                                color: kOrange,
                              ),
                              kWidthBox10,
                              CustomText(
                                text: rate.toString(),
                                weight: FontWeight.bold,
                                size: 16,
                              )
                            ],
                          ),
                        ),
                      )),
                )
              ]),
              kHeightBox10,
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12),
                child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      overflow: TextOverflow.ellipsis,
                      text: rName,
                      size: 18,
                      weight: FontWeight.bold,
                    ),
                    CustomText(
                      text: rTag,
                      size: 14,
                      color: kBlueShade,
                    ),
                    kHeightBox10,
                    Row(
                      
                      children: [
                        Row(
                          
                          children: [
                            Icon(
                              Icons.delivery_dining,
                              color: kGreen,
                              size: 25,
                            ),
                            kWidthBox15,
                            CustomText(
                              text: deliveryCharge == '0'
                                  ? "Free Delivery"
                                  : "Charge - ₹$deliveryCharge",
                              size: 16,
                            ),
                          ],
                        ),
                        kWidthBox20,
                        Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: kGreen,
                          size: 22,
                        ),
                        kWidthBox15,

                        CustomText(
                          text: deliveryTime,
                          size: 16,
                        ),
                      ],
                    ),
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
