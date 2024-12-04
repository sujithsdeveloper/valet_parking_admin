import 'package:flutter/material.dart';


class AppDatas {
  static const List homeFilterDatas = [
    'Recomended',
    'Truck',
    'Car',
    'Bike',
    'Bicycle'
  ];

  static List screenList = [
   
  ];


  static List<Map<String, dynamic>> settingsData = [
    {
      'title': 'Account Settings',
      'icon': Icons.account_circle,
      'onTap': () {
        print('Account Settings tapped');
      }
    },
    {
      'title': 'Notification Settings',
      'icon': Icons.notifications,
      'onTap': () {
        print('Notification Settings tapped');
      }
    },
    {
      'title': 'Privacy Settings',
      'icon': Icons.lock,
      'onTap': () {
        print('Privacy Settings tapped');
      }
    },
    {
      'title': 'Language Settings',
      'icon': Icons.language,
      'onTap': () {
        print('Language Settings tapped');
      }
    },
    {
      'title': 'Theme Settings',
      'icon': Icons.brightness_6,
      'onTap': () {
        print('Theme Settings tapped');
      }
    },
    {
      'title': 'Log Out',
      'icon': Icons.logout,
      'onTap': () {
        print('Log Out tapped');
      }
    },
  ];
}
