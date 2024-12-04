import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:valet_parking_admin/utils/constants/color_constants.dart';
import 'package:valet_parking_admin/utils/styles/String_styles.dart';

class Stationdetailscreen extends StatelessWidget {
  const Stationdetailscreen(
      {super.key,
      required this.label,
      required this.location,
      required this.rating,
      required this.url});
  final String label;
  final String location;
  final String rating;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          label,
          style: StringStyles.appbarTitleStyle(),
        ),
      ),
      body: Column(
        children: [
          // CarouselSlider.builder(
          //     itemCount: 3,
          //     itemBuilder: (context, index, realIndex) => Padding(
          //           padding: const EdgeInsets.symmetric(horizontal: 9),
          //           child: Container(
          //             width: 400,
          //             decoration: BoxDecoration(
          //                 color: Colors.grey,
          //                 borderRadius: BorderRadius.circular(20)),
          //           ),

          //         ),
          //     options: CarouselOptions(
          //       autoPlay: true,
          //     )),

          Image(image: NetworkImage(url)),
          Text(
            label,
            style: StringStyles.headingStyle(),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.location_on_outlined,
                color: Colors.black,
              ),
              SizedBox(
                width: 5,
              ),
              Text(location),
            ],
          ),
          AnimatedRatingStars(
              readOnly: true,
              initialRating: double.parse(rating),
              onChanged: (p0) => () {},
              customFilledIcon: Icons.star,
              customHalfFilledIcon: Icons.star_half_outlined,
              customEmptyIcon: Icons.star_border),
        ],
      ),
    );
  }
}
