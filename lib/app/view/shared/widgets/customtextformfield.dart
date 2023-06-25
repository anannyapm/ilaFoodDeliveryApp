import 'dart:developer';

import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hint;
  final String label;
  final bool obscure;
  final TextEditingController textcontroller;
  final TextInputType type;
  final VoidCallback function;
  final Color textColor;
  final bool readonly;
  final int maxline;
  const CustomTextFormField({
    super.key,
    required this.hint,
    required this.label,
    this.obscure = false,
    required this.textcontroller,
    this.type = TextInputType.text,
    required this.function,
    this.textColor = Colors.grey,
    this.readonly = false,
    this.maxline = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readonly,
      maxLines: maxline,
      controller: textcontroller,
      obscureText: obscure,
      keyboardType: type,
      onChanged: (value) {
        function;
      },
      decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          hintText: hint,
          labelText: label,
          labelStyle: TextStyle(color: textColor),
          floatingLabelStyle: const TextStyle(
              color: Colors.green, fontWeight: FontWeight.w600)),
      validator: (value) {
        if (value == null || value.isEmpty || value.trim().isEmpty) {
          return '$label cannot be Empty!';
        } else {
          if (type == TextInputType.phone) {
            if (value.trim().length < 9) {
              log(value.trim().length.toString());
              return 'Please enter a valid mobile number';
            } else {
              return null;
            }
          }
          if (type == TextInputType.emailAddress) {
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                .hasMatch(value.trim())) {
              return 'Please enter a valid $label!!';
            } else {
              return null;
            }
          } else if (type == TextInputType.visiblePassword) {
            if (value.trim().length < 8) {
              return 'Please enter a valid $label!';
            } else {
              return null;
            }
          } else {
            return null;
          }
        }
      },
    );
  }
}
