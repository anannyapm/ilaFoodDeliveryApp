import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/home_controller.dart';
import 'package:ila/app/utils/constants/constants.dart';
import 'package:ila/app/view/pages/search/pages/search_page.dart';
import 'package:ila/app/view/shared/widgets/custom_text.dart';
import 'package:ila/app/view/shared/widgets/item_card.dart';

import '../../../../utils/constants/color_constants.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              kHeightBox10,
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
                    text: "Categories",
                    size: 20,
                  )
                ],
              ),
              kHeightBox20,
              Expanded(
                child: GetBuilder<HomeController>(
                  init: HomeController(),
                  builder: (controller) {
                    return GridView.builder(
                      itemCount: controller.categories.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        final item = controller.categories[index];
                        return ItemCard(
                            imageUrl: item.imageUrl!,
                            title: item.name!,
                            price: item.price!,
                            onTap: () {
                              Get.to(() => SearchPage(
                                    categoryName: item.name!,
                                  ));
                            });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
