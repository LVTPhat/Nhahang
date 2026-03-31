import 'package:flutter/material.dart';
import 'package:sora_manager/app/data/services/size.dart';

import '../constant.dart';

InputDecoration buildDecorationTextFormField(
    {required String hintText, required IconData icon}) {
  return InputDecoration(
    contentPadding:
        EdgeInsets.symmetric(vertical: Resize.getSizeBaseOnHeight(10)),
    hintText: hintText,
    hintStyle: TextStyle(color: violet3, fontWeight: FontWeight.w300),
    focusColor: primaryColor,
    prefixIcon: Icon(
      icon,
      color: primaryColor,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(
        color: primaryColor,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: primaryColor),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: secondaryColor),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: secondaryColor),
    ),
  );
}
