import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  late final Rx<PageController> _pageController =
      Rx(PageController(initialPage: 0));

  PageController get pageController => _pageController.value;

  final RxInt _pageIndex = 0.obs;
  int get pageIndex => _pageIndex.value;

/*   @override
  void onInit() {
    pageController.value = PageController(initialPage: 0);
    super.onInit();
  }
 */
  @override
  void dispose() {
    _pageController.value.dispose();
    super.dispose();
  }

  updatePageController() {
    _pageController.value.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  skipPage() {
    _pageController.value.jumpToPage(3);
  }

  setPageIndex(int index) {
    _pageIndex.value = index;
  }
}
