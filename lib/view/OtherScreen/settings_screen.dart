import 'package:flutter/material.dart';
import 'package:valet_parking_admin/utils/constants/color_constants.dart';
import 'package:valet_parking_admin/utils/data/appDatas.dart';


class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          label,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemCount: AppDatas.settingsData.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(
                AppDatas.settingsData[index]['icon'],
                color: ColorConstants.primaryColor,
              ),
              title: Text(AppDatas.settingsData[index]['title']),
              onTap: AppDatas.settingsData[index]['onTap'],
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
        ),
      ),
    );
  }
}
