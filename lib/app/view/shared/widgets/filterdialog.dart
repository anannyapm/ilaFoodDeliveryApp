import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/filtercontroller.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/utils/constants/constants.dart';
import 'package:ila/app/view/shared/widgets/customtext.dart';

import 'custombutton.dart';

getFilterdialog() {
  FilterController filterController = Get.put(FilterController());

  Get.dialog(AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    surfaceTintColor: kWhite,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CustomText(text: "Filter"),
        IconButton(onPressed: ()=>Get.back(), icon: Icon(Icons.close,size: 22,),style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(kGreylight.withOpacity(0.1))),)
      ],
    ),
    content: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(text: "DELIVERY TIME"),
          Wrap(
            children: List.generate(3, (index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(() => ChoiceChip(
                      label: Text(filterController.options[index]),
                      selected: filterController.selectedChipIndex == index,
                      onSelected: (selected) {
                        filterController.setSelectedIndex(selected, index);
                      },
                    )),
              );
            }),
          ),
          kHeightBox20,
          const CustomText(text: "PRICING"),
          Obx(() => Column(
                children: [
                  RangeSlider(
                    values: filterController.selectedRange,
                    min: filterController.minPrice,
                    max: filterController.maxPrice,
                    divisions: 10,
                    labels: RangeLabels(
                      '₹${filterController.selectedRange.start}',
                      '₹${filterController.selectedRange.end}',
                    ),
                    activeColor: kOrange,
                    inactiveColor: kOrange.withOpacity(0.4),
                    onChanged: (RangeValues values) {
                      filterController.setRange(values);
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(text: '₹${filterController.minPrice}'),
                      CustomText(text: '₹${filterController.maxPrice}'),
                    ],
                  )
                ],
              )),
          kHeightBox20,
          const CustomText(text: "RATING"),
          Center(
            child: RatingBar(
                              itemSize: 35,
                                ratingWidget: RatingWidget(
                                    full: const Icon(Icons.star,
                                        color: Colors.orange),
                                    half: const Icon(
                                      Icons.star_half,
                                      color: Colors.orange,
                                    ),
                                    empty: const Icon(
                                      Icons.star_outline,
                                      color: Colors.orange,
                                    )),
                                onRatingUpdate: (value) {
                                  filterController.setRating(value);
                                  log(filterController.selectedRating.toString());
                                }),
          ),
          kHeightBox20,
          SizedBox(
            width: double.infinity,
            child: CustomButton(
                            padding: 15,
                            text: CustomText(
                              text: "FILTER",
                              color: kWhite,
                              size: 18,
                              weight: FontWeight.bold,
                            ),
                            function:() {
                        
                      },
                            color: kGreen)
           
          ),
        ],
      ),
    ),
  ));
}
