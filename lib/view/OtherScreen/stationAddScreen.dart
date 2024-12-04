import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valet_parking_admin/controller/crudOperationContoller.dart';
import 'package:valet_parking_admin/controller/widgetController.dart';
import 'package:valet_parking_admin/utils/constants/color_constants.dart';
import 'package:valet_parking_admin/utils/functions/validations.dart';
import 'package:valet_parking_admin/utils/styles/String_styles.dart';
import 'package:valet_parking_admin/utils/styles/animation_styles.dart';
import 'package:valet_parking_admin/widgets/buttonWidget.dart';
import 'package:valet_parking_admin/widgets/textfeildWidget.dart';

class Stationaddscreen extends StatefulWidget {
  const Stationaddscreen(
      {super.key,
      this.stationName,
      this.numberOfSlots,
      this.location,
      this.price,
      this.Image,
      required this.isEdit});

  final String? stationName;
  final String? numberOfSlots;
  final String? location;
  final String? price;
  final String? Image;
  final bool isEdit;

  @override
  State<Stationaddscreen> createState() => _StationaddscreenState();
}

class _StationaddscreenState extends State<Stationaddscreen> {
  @override
  Widget build(BuildContext context) {
    final stationNameController = TextEditingController();
    final numberOfSlotsController = TextEditingController();
    final locationCorrdinates = TextEditingController();
    final pricePerHourController = TextEditingController();
    final imageUrlController = TextEditingController();
    final codeController = TextEditingController();
    final key = GlobalKey<FormState>();
    final proWatch = context.watch<Crudoperationcontoller>();

    return Scaffold(
      backgroundColor: ColorConstants.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Add Station',
          style: StringStyles.headingStyle(),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: key,
          child: ListView(
            children: [
              SizedBox(height: 20),
              TextfeildWidget(
                validation: (p0) => Validations.validateName(p0),
                controller: stationNameController,
                keyboardType: TextInputType.name,
                label: 'Enter station name',
                wantHeading: true,
                heading: 'Station name',
              ),
              SizedBox(height: 20),
              TextfeildWidget(
                validation: (p0) => Validations.slotsValidation(p0),
                controller: numberOfSlotsController,
                label: 'Number of slots available',
                wantHeading: true,
                heading: 'Number of slots',
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              TextfeildWidget(
                validation: (p0) => Validations.locationValidation(p0),
                controller: locationCorrdinates,
                label: 'Enter station location',
                wantHeading: true,
                heading: 'Location Coordinates',
              ),
              SizedBox(height: 20),
              TextfeildWidget(
                controller: pricePerHourController,
                label: 'Price',
                validation: (p0) => Validations.priceValidation(p0),
                keyboardType: TextInputType.number,
                wantHeading: true,
                heading: 'Price Per Hour',
              ),
              SizedBox(height: 20),
              TextfeildWidget(
                controller: imageUrlController,
                label: 'Image URL',
                validation: (p0) => Validations.priceValidation(p0),
                keyboardType: TextInputType.text,
                wantHeading: true,
                heading: 'Image',
              ),
              SizedBox(height: 20),
              TextfeildWidget(
                  keyboardType: TextInputType.number,
                  heading: 'Create a code for your station',
                  wantHeading: true,
                  controller: codeController,
                  label: 'Code'),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: proWatch.isLoading
                        ? AnimationStyles.loadingIndicator()
                        : ButtonWidget(
                            label: 'Add',
                            onTap: () {
                              if (key.currentState!.validate()) {
                                context.read<Crudoperationcontoller>().addData(
                                    code: int.parse(codeController.text),
                                    context: context,
                                    stationName: stationNameController.text,
                                    price: pricePerHourController.text,
                                    numberOfSlots: numberOfSlotsController.text,
                                    location: locationCorrdinates.text);

                                stationNameController.clear();
                                pricePerHourController.clear();
                                locationCorrdinates.clear();
                                numberOfSlotsController.clear();
                                imageUrlController.clear();
                                codeController.clear();
                              }
                            },
                            width: 250),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
