
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:valet_parking_admin/utils/constants/color_constants.dart';
import 'package:valet_parking_admin/utils/styles/String_styles.dart';
import 'package:valet_parking_admin/utils/styles/animation_styles.dart';

class BookingHistoryScreen extends StatelessWidget {
  const BookingHistoryScreen({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(label, style: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('parking_history')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            final history = snapshot.data?.docs.reversed.toList();

            return ListView.builder(
              itemCount: history?.length ?? 0,
              itemBuilder: (context, index) {
                final doc = history![index];
                return ListTile(
                  leading: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: Colors.grey,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(doc['image']))),
                  ),
                  title: Text(
                    'Parking Name: ${doc['parking_name']}',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                      'Location: ${doc['location']}\nTime: ${doc['time']}'),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '₹${doc['bill']}',
                        style: StringStyles.priceStyle(),
                      ),
                    ],
                  ),
                  isThreeLine: true,
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return AnimationStyles.loadingIndicator();
          }
        },
      ),
    );
  }
}
