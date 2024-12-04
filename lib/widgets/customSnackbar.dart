  import 'package:flutter/material.dart';
import 'package:valet_parking_admin/utils/constants/color_constants.dart';


SnackBar customSnackbar({required String title}) {
    return SnackBar(
      backgroundColor: ColorConstants.primaryColor,
      content: Text(title));
  }