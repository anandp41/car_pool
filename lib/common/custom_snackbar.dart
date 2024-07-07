import 'package:flutter/material.dart';
import 'package:get/get.dart';

SnackbarController showCustomSnackBar({
  required String message,
  bool isDismissible = true,
  EdgeInsets margin = const EdgeInsets.only(bottom: 20, left: 4, right: 4),
  EdgeInsets padding = const EdgeInsets.all(16),
  double borderRadius = 8,
  double? borderWidth = 1.0,
  String? title,
  Widget? titleText,
  Widget? messageText,
}) {
  return Get.showSnackbar(GetSnackBar(
      title: title,
      titleText: titleText,
      backgroundColor: Colors.white,
      padding: padding,
      margin: margin,
      borderColor: Colors.black,
      borderWidth: borderWidth,
      borderRadius: borderRadius,
      duration: const Duration(seconds: 2),
      message: message,
      messageText: Text(
        message,
        style: const TextStyle(fontFamily: 'Poppins', color: Colors.black),
      ),
      isDismissible: isDismissible));
}
