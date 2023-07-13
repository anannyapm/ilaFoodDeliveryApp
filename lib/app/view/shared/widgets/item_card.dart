import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/view/shared/widgets/custom_text.dart';

class ItemCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final VoidCallback onTap;

  const ItemCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 175,
      width: 145,
      margin: const EdgeInsets.only(right: 5, top: 10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        surfaceTintColor:Get.isDarkMode?kGrey.withOpacity(0.6): kWhite,
        color: Get.isDarkMode?kGrey.withOpacity(0.6): kWhite,
        elevation: 4,
        child: InkWell(
          onTap: onTap,
          child: Column(
            children: [
              Container(
                  height: 104,
                  width: 122,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color:Get.isDarkMode?kWhite.withOpacity(0.1): kGrey.withOpacity(0.7),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset:
                            const Offset(0, 3), // changes the shadow position
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                  
                  ),
                  margin: const EdgeInsets.fromLTRB(12, 12, 12, 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: FadeInImage(
                      fadeInDuration: const Duration(milliseconds: 300),
                      placeholder:
                          const AssetImage('assets/images/placeholder.jpg'),
                      image: NetworkImage(imageUrl),
                      imageErrorBuilder: (context, error, stackTrace) =>
                          Image.asset(
                        'assets/images/placeholder.jpg',
                        fit: BoxFit.cover,
                      ),
                      fit: BoxFit.cover,
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      overflow: TextOverflow.ellipsis,
                      text: title,
                      size: 15,
                      weight: FontWeight.bold,
                      
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "Starting At",
                          size: 12,
                          color:Get.isDarkMode?kWhite: kGreyDark,
                        ),
                        CustomText(
                          text: "₹$price",
                          size: 12,
                          color:Get.isDarkMode?kWhite: kBlueShade,
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
