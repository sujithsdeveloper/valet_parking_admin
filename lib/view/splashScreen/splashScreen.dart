import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:valet_parking_admin/utils/constants/color_constants.dart';
import 'package:valet_parking_admin/utils/styles/String_styles.dart';
import 'package:valet_parking_admin/view/HomeScreen/HomeScreen.dart';
import 'package:valet_parking_admin/view/registration_screens/login_screen/login_screen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {

    super.initState();

    if (user != null) {
      Future.delayed(Duration(seconds: 3)).then(
        (value) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Homescreen(),
            )),
      );
    } else {
      Future.delayed(Duration(seconds: 3)).then(
        (value) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'My Parking',
              style: StringStyles.headingStyle(),
            ),
            Text('Admin'),
          ],
        ),
      ),
    );
  }
}
