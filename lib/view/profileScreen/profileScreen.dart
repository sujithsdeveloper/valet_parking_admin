import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:valet_parking_admin/utils/functions/routesFun.dart';
import 'package:valet_parking_admin/view/profileScreen/EditProfilescreen.dart';
import 'package:valet_parking_admin/view/profileScreen/profileTile.dart';
import 'package:valet_parking_admin/view/registration_screens/login_screen/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    if (currentUser == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Profile'),
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: Colors.black,
        ),
        body: const Center(
          child: Text(
            'User not logged in',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
      );
    }

    final userDoc =
        FirebaseFirestore.instance.collection('admins').doc(currentUser!.uid);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Center(
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 50,
                child: Icon(
                  Icons.person,
                  size: 40,
                ),
              ),
            ),
            const SizedBox(height: 10),
            StreamBuilder<DocumentSnapshot>(
              stream: userDoc.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Column(
                      children: [
                        Container(
                          height: 20,
                          width: 150,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 20,
                          width: 200,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return const Text(
                    'Error fetching user data',
                    style: TextStyle(color: Colors.red),
                  );
                }
                if (snapshot.hasData &&
                    snapshot.data != null &&
                    snapshot.data!.exists) {
                  final userData = snapshot.data!;
                  final userName = userData.get('name') ?? 'Name not set';
                  final userEmail = userData.get('email') ?? 'Email not set';

                  return Column(
                    children: [
                      Text(
                        userName,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        userEmail,
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ],
                  );
                }
                return const Text('No user data available');
              },
            ),
            const SizedBox(height: 20),
            ProfileOptionTile(
              leadingIcon: Icons.edit,
              title: 'Edit Profile',
              onTap: () {
                Navigator.push(context, createRoute(const EditProfilescreen()));
              },
            ),

            ProfileOptionTile(
              leadingIcon: Icons.logout,
              title: 'Log out',
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Log Out'),
                    content: const Text('Are you sure?'),
                    backgroundColor: Colors.white,
                    elevation: 3,
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                            (route) => false,
                          );
                        },
                        child: const Text(
                          'Yes',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
