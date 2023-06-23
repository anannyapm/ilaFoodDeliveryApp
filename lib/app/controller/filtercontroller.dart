import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  final Rx<RangeValues> _selectedRange = const RangeValues(0.0, 500.0).obs;

  RangeValues get selectedRange => _selectedRange.value;
  double minPrice = 0;
  double maxPrice = 2000;

  setRange(RangeValues values) {
    _selectedRange.value = values;
  }

  final RxDouble _selectedRating = 0.0.obs;
  double get selectedRating => _selectedRating.value;

  setRating(double value) {
    _selectedRating.value = value;
  }

  final RxInt _selectedChipIndex = 0.obs;

  int get selectedChipIndex => _selectedChipIndex.value;

  List<String> options = [
    '10-20',
    '20-30',
    '30-40',
  ];
  setSelectedIndex(bool value,int index){
    _selectedChipIndex.value = value ? index : -1;
  }
}
