import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valet_parking_admin/controller/widgetController.dart';
import 'package:valet_parking_admin/utils/constants/color_constants.dart';
import 'package:valet_parking_admin/utils/styles/String_styles.dart';

class TextfeildWidget extends StatelessWidget {
  const TextfeildWidget(
      {super.key,
      required this.controller,
      required this.label,
      this.validation,
      this.wantObscure = false,
      this.keyboardType = TextInputType.text,
      this.heading,
      this.wantHeading = false,
      this.historyController});

  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validation;
  final bool wantObscure;
  final TextInputType keyboardType;
  final wantHeading;
  final String? heading;
  final UndoHistoryController? historyController;

  @override
  Widget build(BuildContext context) {
    final prowatch = context.watch<Widgetcontroller>();
    final proRead = context.read<Widgetcontroller>();
    return wantHeading
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                heading.toString(),
                style: StringStyles.subHeadingStyle(),
              ),
              SizedBox(height: 5),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: keyboardType,
                cursorColor: Colors.black,
                controller: controller,
                obscureText: wantObscure ? prowatch.textIsobscure : false,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorConstants.primaryColor)),
                  suffixIcon: wantObscure
                      ? IconButton(
                          onPressed: () {
                            proRead.isObscure();
                          },
                          icon: prowatch.textIsobscure
                              ? Icon(
                                  Icons.visibility_off,
                                  color: Colors.black,
                                )
                              : Icon(
                                  Icons.visibility,
                                  color: Colors.black,
                                ))
                      : null,
                  labelText: label,
                  labelStyle: TextStyle(color: ColorConstants.primaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: ColorConstants.primaryColor),
                  ),
                ),
                validator: validation,
              )
            ],
          )
        : TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: keyboardType,
            cursorColor: Colors.black,
            controller: controller,
            obscureText: wantObscure ? prowatch.textIsobscure : false,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorConstants.primaryColor)),
              suffixIcon: wantObscure
                  ? IconButton(
                      onPressed: () {
                        proRead.isObscure();
                      },
                      icon: prowatch.textIsobscure
                          ? Icon(
                              Icons.visibility_off,
                              color: Colors.black,
                            )
                          : Icon(
                              Icons.visibility,
                              color: Colors.black,
                            ))
                  : null,
              labelText: label,
              labelStyle: TextStyle(color: ColorConstants.primaryColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: ColorConstants.primaryColor),
              ),
            ),
            validator: validation,
          );
  }
}
