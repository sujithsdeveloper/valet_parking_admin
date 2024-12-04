import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:valet_parking_admin/utils/constants/color_constants.dart';
import 'package:valet_parking_admin/widgets/customSnackbar.dart';

class Crudoperationcontoller extends ChangeNotifier {
  bool isLoading = false;

  void addData({
    required String stationName,
    required String price,
    required String numberOfSlots,
    required String location,
    required BuildContext context,
  }) async {
    isLoading = true;
    notifyListeners();
    try {
      Map<String, dynamic> stationDatas = {
        'location': location,
        'parking_place': stationName,
        'price_per_hour': price,
        'rating': 4,
        'number_of_slots': numberOfSlots,
      };

      CollectionReference adminStations = FirebaseFirestore.instance
          .collection('admins')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('stations');

      CollectionReference parkingPlaces =
          FirebaseFirestore.instance.collection('parking_place');

      await parkingPlaces.add(stationDatas);
      await adminStations.add(stationDatas);

      log('Data successfully added to Firestore.');
      isLoading = false;
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Station added successfully...'),
        backgroundColor: ColorConstants.primaryColor,
      ));
    } catch (e) {
      log('Failed to add data: $e');
      isLoading = false;
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to add station. Please try again.'),
        backgroundColor: Colors.red,
      ));
    }
  }

  bool isNameUpdating = false;
  Future<void> upDateName(
      {required String name, required BuildContext context}) async {
    isNameUpdating = true;
    notifyListeners();
    final ref = FirebaseFirestore.instance
        .collection('admins')
        .doc(FirebaseAuth.instance.currentUser?.uid);
    await ref.update({'name': name});
    ScaffoldMessenger.of(context)
        .showSnackBar(customSnackbar(title: 'Name Updated succesfully'));
    isNameUpdating = false;
    notifyListeners();
  }

  Future<void> deleteData(data, context) async {
    try {
      await FirebaseFirestore.instance
          .collection('admins')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('stations')
          .doc(data.id)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Parking station deleted successfully.'),
          backgroundColor: ColorConstants.primaryColor,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete parking station: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
