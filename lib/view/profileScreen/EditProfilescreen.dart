import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valet_parking_admin/controller/crudOperationContoller.dart';
import 'package:valet_parking_admin/utils/constants/color_constants.dart';
import 'package:valet_parking_admin/utils/styles/animation_styles.dart';
import 'package:valet_parking_admin/widgets/buttonWidget.dart';
import 'package:valet_parking_admin/widgets/textfeildWidget.dart';

class EditProfilescreen extends StatelessWidget {
  const EditProfilescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final prowatch = context.read<Crudoperationcontoller>();
    final nameController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Edit Profile'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9),
        child: Column(
          children: [
            const SizedBox(
              height: 9,
            ),
            TextfeildWidget(
              controller: nameController,
              label: 'Name',
              heading: 'Edit your name',
              wantHeading: true,
            ),
            const SizedBox(height: 20),
            // context.watch<Datacontroller>().isNameLoading
            //     ? const Center(
            //         child: CircularProgressIndicator(
            //           color: ColorConstants.primaryColor,
            //         ),
            //       )
            //     :
            prowatch.isNameUpdating
                ? AnimationStyles.loadingIndicator()
                : ButtonWidget(
                    label: 'Save Changes',
                    onTap: () {
                      context.read<Crudoperationcontoller>().upDateName(
                          context: context, name: nameController.text);
                      nameController.clear();
                    },
                    width: 200)
          ],
        ),
      ),
    );
  }
}
