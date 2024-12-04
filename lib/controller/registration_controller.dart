import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:valet_parking_admin/view/HomeScreen/HomeScreen.dart';
import 'package:valet_parking_admin/widgets/customSnackbar.dart';

class RegistrationController extends ChangeNotifier {
  bool isRegLoading = false;
  bool isLoginLoading = false;
  bool isPasswordLoading = false;

  Future<void> createUser({
    required String email,
    required String password,
    required String name,
    required BuildContext context,
  }) async {
    try {
      isRegLoading = true;
      notifyListeners();
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential != null) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
            customSnackbar(title: 'Registration successful! Please login.'));

        final ref = FirebaseFirestore.instance
            .collection('admins')
            .doc(credential.user!.uid);
        await ref.set({'name': name, 'email': email});
      }
      isRegLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      isRegLoading = false;
      notifyListeners();
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            customSnackbar(title: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(customSnackbar(
            title: 'The account already exists for that email.'));
      }
    } catch (e) {
      isRegLoading = false;
      notifyListeners();
      ScaffoldMessenger.of(context)
          .showSnackBar(customSnackbar(title: e.toString()));
    }
  }

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      isLoginLoading = true;
      notifyListeners();
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Homescreen(),
          ),
        );
      }
      isLoginLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      isLoginLoading = false;
      notifyListeners();
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            customSnackbar(title: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            customSnackbar(title: 'Wrong password provided for that user.'));
      }
    }
  }

  Future<void> resetPassword(
      {required String email, required BuildContext context}) async {
    isPasswordLoading = true;
    notifyListeners();
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

    ScaffoldMessenger.of(context).showSnackBar(
        customSnackbar(title: 'Check your email to reset your password'));
    isPasswordLoading = false;
    notifyListeners();
  }
}
