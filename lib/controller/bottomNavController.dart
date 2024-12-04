import 'package:flutter/material.dart';

class Bottomnavcontroller extends ChangeNotifier{
  int currentIndex=0;
  void onBottomNavTap(int value){
    currentIndex=value;
    notifyListeners();
  }
}