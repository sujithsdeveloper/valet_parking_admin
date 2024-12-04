import 'package:flutter/material.dart';
import 'package:valet_parking_admin/utils/constants/color_constants.dart';


class StringStyles {
  static TextStyle subHeadingStyle() {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
    );
  }

  static TextStyle headingStyle() {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 25,
    );
  }

  static TextStyle appbarTitleStyle() {
    return TextStyle(color: Colors.black, fontSize: 20);
  }

  static TextStyle priceStyle() {
    return TextStyle(
        color: ColorConstants.primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 20);
  }
}
