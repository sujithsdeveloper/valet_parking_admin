import 'package:flutter/material.dart';
import 'package:valet_parking_admin/utils/constants/color_constants.dart';


class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.label,
    required this.onTap,
    required this.width, this.changeColor=false, this.bgColor,
  });
  final String label;
  final double width;
  final Function() onTap;
  final bool changeColor;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
        decoration: BoxDecoration(
            color:changeColor?bgColor: ColorConstants.primaryColor,
            borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
