import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  final RxMap _tempReview = {}.obs;
  final RxMap _ratingstatusdummy = {}.obs;
  Map get tempReview => _tempReview;
  Map get ratingStatusDummy => _ratingstatusdummy;
  final TextEditingController reviewTextController = TextEditingController();
  final RxDouble _selectedRating = 0.0.obs;
  double get selectedRating => _selectedRating.value;

  setRating(double value) {
    _selectedRating.value = value;
  }

  addReview(index) {
    _tempReview[index] = reviewTextController.text;
    reviewTextController.clear();
  }

  setratingstatus(index) {
    _ratingstatusdummy[index] = selectedRating;
  }
}
