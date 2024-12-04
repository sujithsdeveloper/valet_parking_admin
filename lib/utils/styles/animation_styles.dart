import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:valet_parking_admin/utils/constants/assetsConstants.dart';


class AnimationStyles {
  static Widget loadingIndicator() {
    return Center(
        child: Lottie.asset(height: 80, Animationconstants.splashAnimation));
  }
}
