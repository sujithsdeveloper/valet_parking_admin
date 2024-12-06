import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valet_parking_admin/controller/bottomNavController.dart';
import 'package:valet_parking_admin/controller/crudOperationContoller.dart';
import 'package:valet_parking_admin/utils/constants/color_constants.dart';
import 'package:valet_parking_admin/utils/styles/String_styles.dart';
import 'package:valet_parking_admin/utils/styles/animation_styles.dart';
import 'package:valet_parking_admin/view/OtherScreen/stationAddScreen.dart';
import 'package:valet_parking_admin/view/OtherScreen/stationDetailScreen.dart';
import 'package:valet_parking_admin/view/bookingScreen/Bookings.dart';
import 'package:valet_parking_admin/view/profileScreen/profileScreen.dart';
import 'package:valet_parking_admin/widgets/homeDrawer.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    final proRead = context.read<Bottomnavcontroller>();
    final proWatch = context.watch<Bottomnavcontroller>();
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          Home(),
          Bookings(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: WaterDropNavBar(
        waterDropColor: ColorConstants.primaryColor,
        inactiveIconColor: Colors.grey,
        backgroundColor: Colors.white,
        onItemSelected: (index) {
          proRead.onBottomNavTap(index);
          pageController.animateToPage(proWatch.currentIndex,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutQuad);
        },
        selectedIndex: proWatch.currentIndex,
        barItems: [
          BarItem(
            filledIcon: Icons.home_work_rounded,
            outlinedIcon: Icons.home_work_outlined,
          ),
          BarItem(
              filledIcon: Icons.account_balance_wallet,
              outlinedIcon: Icons.account_balance_wallet_outlined),
          BarItem(filledIcon: Icons.person, outlinedIcon: Icons.person_outline)
        ],
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final proRead = context.read<Crudoperationcontoller>();
    final proWatch = context.watch<Crudoperationcontoller>();

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('admins')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('stations')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: AnimationStyles.loadingIndicator());
        } else if (snapshot.hasData && snapshot.data != null) {
          final parkingPlace = snapshot.data!.docs.reversed.toList();

          return Scaffold(
            floatingActionButton: FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Stationaddscreen(
                      isEdit: false,
                    ),
                  ),
                );
              },
              child: Icon(Icons.add),
              backgroundColor: ColorConstants.primaryColor,
            ),
            backgroundColor: ColorConstants.scaffoldBackgroundColor,
            appBar: AppBar(
              centerTitle: true,
              title: Text('Valet Parking'),
              backgroundColor: ColorConstants.scaffoldBackgroundColor,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Badge.count(
                    count: 5,
                    child: Icon(Icons.notifications),
                  ),
                ),
              ],
            ),
            drawer: HomeDrawer(),
            body: parkingPlace.isEmpty
                ? Center(
                    child: Text(
                      'No Parking Stations Available',
                      style: StringStyles.subHeadingStyle(),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 9),
                        child: Text(
                          'Your Parking Stations',
                          style: StringStyles.subHeadingStyle(),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 9, vertical: 9),
                          child: ListView.builder(
                            itemCount: parkingPlace.length,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              final data = parkingPlace[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Stationdetailscreen(
                                        url: data['image'],
                                        location: data['location'],
                                        label: data['parking_place'],
                                        rating: data['rating'].toString(),
                                      ),
                                    ),
                                  );
                                },
                                child: Card(
                                  color: Colors.white,
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data['parking_place'] ??
                                                  'Unknown Place',
                                              style: StringStyles
                                                  .subHeadingStyle(),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              'Location: ${data['location'] ?? 'Not Provided'}',
                                            ),
                                            Text(
                                              'No of Slots Available: ${data['number_of_slots'] ?? '0'}',
                                            ),
                                            Text(
                                              'Price per Hour: ₹${data['price_per_hour'] ?? 'N/A'}',
                                            ),
                                            Text(
                                              'Rating: ${data['rating']?.toString() ?? 'No Rating'}',
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            PopupMenuButton(
                                              color: ColorConstants
                                                  .scaffoldBackgroundColor,
                                              itemBuilder: (context) => [
                                                PopupMenuItem(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            Stationaddscreen(
                                                          Image: data['image'],
                                                          location:
                                                              data['location']
                                                                  .toString(),
                                                          numberOfSlots: data[
                                                                  'number_of_slots']
                                                              .toString(),
                                                          price: data[
                                                                  'price_per_hour']
                                                              .toString(),
                                                          stationName: data[
                                                              'parking_place'],
                                                          code: data['code']
                                                              .toString(),
                                                          isEdit: true,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.edit),
                                                      SizedBox(width: 5),
                                                      Text('Edit'),
                                                    ],
                                                  ),
                                                ),
                                                PopupMenuItem(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          AlertDialog(
                                                        title: Text(
                                                            'This process cannot be reversed'),
                                                        content: Text(
                                                            'Are you sure?'),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child:
                                                                Text('Cancel'),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              proRead
                                                                  .deleteData(
                                                                      data,
                                                                      context);
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text(
                                                              'Delete',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.delete),
                                                      SizedBox(width: 5),
                                                      Text('Delete'),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: Text(
                'No data available',
                style: TextStyle(fontSize: 16),
              ),
            ),
          );
        }
      },
    );
  }
}
