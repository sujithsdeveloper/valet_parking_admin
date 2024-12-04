import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valet_parking_admin/controller/bottomNavController.dart';
import 'package:valet_parking_admin/controller/crudOperationContoller.dart';
import 'package:valet_parking_admin/controller/registration_controller.dart';
import 'package:valet_parking_admin/controller/widgetController.dart';
import 'package:valet_parking_admin/firebase_options.dart';
import 'package:valet_parking_admin/view/HomeScreen/HomeScreen.dart';
import 'package:valet_parking_admin/view/splashScreen/splashScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Bottomnavcontroller(),
        ),
        ChangeNotifierProvider(
          create: (context) => RegistrationController(),
        ),
        ChangeNotifierProvider(create: (context) => Widgetcontroller()),
        ChangeNotifierProvider(create: (context) => Crudoperationcontoller())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Splashscreen(),
      ),
    );
  }
}
