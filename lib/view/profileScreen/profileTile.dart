
import 'package:flutter/material.dart';
import 'package:valet_parking_admin/utils/constants/color_constants.dart';

class ProfileOptionTile extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final Function()? onTap;

  const ProfileOptionTile({
    key,
    required this.leadingIcon,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9),
      child: ListTile(
        leading: Icon(
          leadingIcon,
          color: ColorConstants.primaryColor,
        ),
        title: Text(title),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 15,
        ),
        onTap: onTap,
      ),
    );
  }
}
