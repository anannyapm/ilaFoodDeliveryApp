import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/controller/navigationcontroller.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/view/pages/cart/cartpage.dart';
import 'package:ila/app/view/pages/favourite/favouritepage.dart';
import 'package:ila/app/view/pages/orders/orderpage.dart';
import 'package:ila/app/view/pages/profile/profilepage.dart';

import 'homepage.dart';

class NavigationPage extends StatelessWidget {
  NavigationPage({super.key});
  final NavigationController navigationController =
      Get.put(NavigationController());
  final List<Widget> pages = [
    HomePage(),
    FavouritePage(),
    ProfilePage(),
    const OrdersPage(),
     CartPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
