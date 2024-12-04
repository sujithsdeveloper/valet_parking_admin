import 'package:flutter/material.dart';
import 'package:valet_parking_admin/utils/constants/color_constants.dart';
import 'package:valet_parking_admin/view/OtherScreen/booking_history_screen.dart';
import 'package:valet_parking_admin/view/OtherScreen/settings_screen.dart';
import 'package:valet_parking_admin/widgets/logout_dialog.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: ColorConstants.primaryColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.local_parking,
                    color: ColorConstants.primaryColor,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 10),
                Text( 
                  'Parking App',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Your parking solution',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading:
                Icon(Icons.account_circle, color: ColorConstants.primaryColor),
            title: const Text('My Account'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.history, color: ColorConstants.primaryColor),
            title: const Text('Booking History'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        BookingHistoryScreen(label: 'Booking History'),
                  ));
            },
          ),
          ListTile(
            leading:
                Icon(Icons.data_saver_off, color: ColorConstants.primaryColor),
            title: const Text('Dashboard'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: ColorConstants.primaryColor),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsScreen(label: 'Settings'),
                  ));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout'),
            onTap: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) => LogoutDialog(),
              );
            },
          ),
        ],
      ),
    );
  }
}
