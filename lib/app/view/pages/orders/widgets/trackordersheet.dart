import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/view/pages/orders/widgets/trackwidget.dart';
import 'package:intl/intl.dart';

import '../../../../utils/constants/color_constants.dart';
import '../../../../utils/constants/constants.dart';
import '../../../shared/widgets/customtext.dart';

getTrackOrderSheet() {
  return Get.bottomSheet(
      SizedBox(
        height: 620,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              kHeightBox20,
              Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: ShapeDecoration(
                      image: const DecorationImage(
                        image: NetworkImage(
                            "https://images.pexels.com/photos/604969/pexels-photo-604969.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"),
                        fit: BoxFit.fill,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  kWidthBox15,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        text: "Arabian Hut",
                        size: 16,
                        weight: FontWeight.bold,
                      ),
                      CustomText(
                        text:
                            "Ordered At ${DateFormat('dd  MMM,hh:mm a ').format(DateTime.now())}",
                        color: kGrey,
                        size: 16,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomText(
                            text: '₹580',
                            color: kBlueShade,
                            size: 15,
                            weight: FontWeight.w700,
                          ),
                          kWidthBox15,
                          CustomText(
                            text: "|",
                            size: 22,
                            color: kGrey,
                          ),
                          kWidthBox15,
                          CustomText(
                            text: '03 Items',
                            color: kGreyDark,
                            size: 15,
                            weight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              kHeightBox20,
              const CustomText(
                text: "20 Min",
                size: 30,
                weight: FontWeight.w800,
              ),
              CustomText(
                text: "ESTIMATED DELIVERY TIME",
                size: 14,
                weight: FontWeight.w400,
                color: kGrey,
              ),
              kHeightBox20,
              const TrackWidget(currentStage: 2),
              kHeightBox20,
              const Divider(),
              kHeightBox20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            "https://images.pexels.com/photos/6868618/pexels-photo-6868618.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"),
                      ),
                      kWidthBox15,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "Daniel Chad",
                            color: kBlueShade,
                            size: 20,
                            weight: FontWeight.bold,
                          ),
                          CustomText(
                            text: "Delivery Person",
                            color: kGrey,
                            size: 16,
                          ),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: kBlueShade),
                      child: Icon(
                        Icons.call_outlined,
                        color: kWhite,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      backgroundColor: kWhite,
      isScrollControlled: true);
}
