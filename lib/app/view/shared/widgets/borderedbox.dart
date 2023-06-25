import 'package:flutter/material.dart';

import 'customtext.dart';

class BorderedButton extends StatelessWidget {
  final CustomText text;
  final VoidCallback function;
  final Color color;
  const BorderedButton({
    super.key,
    required this.text,
    required this.color,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: function,
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: color),
              borderRadius: BorderRadius.circular(15),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0),
        child: text);
  }
}
