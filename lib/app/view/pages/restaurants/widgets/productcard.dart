import 'package:flutter/material.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/view/shared/widgets/customtext.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final VoidCallback onTap;

  const ProductCard({super.key, 
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height:260,
        width: 145,
        margin: const EdgeInsets.only(right: 5, top: 10),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                          offset: const Offset(0, 3), // changes the shadow position
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
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
                      text: title,
                      size: 15,
                      weight: FontWeight.bold,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        
                        CustomText(
                          text: "₹$price",
                          size: 14,
                          color: kBlueShade,
                        ),
                        IconButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(kOrange)),
                          onPressed: () {},
                          icon: Icon(
                            Icons.add,
                            color: kWhite,
                          ))
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
