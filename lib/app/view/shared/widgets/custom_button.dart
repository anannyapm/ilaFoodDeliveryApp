import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  final Widget text;
  final VoidCallback function;
  final Color color;
  final double padding;
  const CustomButton({
    super.key,
    required this.text,
    required this.function,
    required this.color, required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: function,
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            backgroundColor: color,
            padding: EdgeInsets.all(padding),
            elevation: 0),
        child: text);
  }
}
