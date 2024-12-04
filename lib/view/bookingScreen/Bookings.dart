
import 'package:flutter/material.dart';
import 'package:valet_parking_admin/utils/constants/color_constants.dart';
import 'package:valet_parking_admin/utils/styles/String_styles.dart';

class Bookings extends StatelessWidget {
  const Bookings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.scaffoldBackgroundColor,

      appBar: AppBar(
      backgroundColor: ColorConstants.scaffoldBackgroundColor,

        title: Text(
          'Bookings',
          style: StringStyles.appbarTitleStyle(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('you dont have any bookijng yet')],
        ),
      ),
    );
  }
}
