import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/navigation_controller.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/view/pages/cart/cart_page.dart';
import 'package:ila/app/view/pages/favourite/favourite_page.dart';
import 'package:ila/app/view/pages/orders/order_page.dart';
import 'package:ila/app/view/pages/profile/profile_page.dart';
import 'package:ila/app/view/shared/widgets/custom_text.dart';

import 'homepage.dart';

class NavigationPage extends StatelessWidget {
  NavigationPage({super.key});
  final NavigationController navigationController =
      Get.put(NavigationController());
  final List<Widget> pages = [
    HomePage(),
    FavouritePage(),
    ProfilePage(),
     OrdersPage(),
    CartPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (navigationController.selectedIndex != 0) {
          navigationController.setSelectedIndex(0);
          return false;
        } else {
          return await(Get.dialog(
            AlertDialog(
              surfaceTintColor: kWhite,
              elevation: 0,
            title: CustomText(
              text: "Are you sure you want to Exit app?",
              size: 18,
              color: kBlueShade,
              weight: FontWeight.bold,
            ),
            actions: [
              TextButton(onPressed:()=> Get.back(result: false), child: CustomText(text: "No",color: kBlueShade,size: 14,weight: FontWeight.bold,)),
              TextButton(onPressed:()=> Get.back(result: true), child: CustomText(text: "Yes",color: kWarning,size: 14,weight: FontWeight.bold,))
            ],
          )));
        }
      },
      child: Scaffold(
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            backgroundColor: kWhite,
            showSelectedLabels: false,
            iconSize: 26,
            selectedItemColor: kGreen,
            unselectedItemColor: kGrey,
            elevation: 1,
            currentIndex: navigationController.selectedIndex,
            onTap: (index) => navigationController.setSelectedIndex(index),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                label: 'Favorite',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_outline),
                label: 'Orders',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag_outlined),
                label: 'Cart',
              ),
            ],
          ),
        ),
        body: Obx(() => pages[navigationController.selectedIndex]),
      ),
    );
  }
}
