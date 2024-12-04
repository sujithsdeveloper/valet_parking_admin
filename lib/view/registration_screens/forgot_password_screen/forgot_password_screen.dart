import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valet_parking_admin/controller/registration_controller.dart';
import 'package:valet_parking_admin/utils/constants/color_constants.dart';
import 'package:valet_parking_admin/utils/functions/validations.dart';
import 'package:valet_parking_admin/utils/styles/animation_styles.dart';
import 'package:valet_parking_admin/widgets/buttonWidget.dart';
import 'package:valet_parking_admin/widgets/textfeildWidget.dart';


class ForgotPasswordScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final proWatch = context.watch<RegistrationController>();
    final proRead = context.read<RegistrationController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Forgot Password'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Reset Your Password',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.primaryColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Enter your email address below to receive a password reset link.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextfeildWidget(
                      controller: _emailController,
                      label: 'Email',
                      validation: (p0) => Validations.validateEmail(p0),
                    ),
                    const SizedBox(height: 24),
                    proWatch.isPasswordLoading
                        ? AnimationStyles.loadingIndicator()
                        : ButtonWidget(
                          width: 200,
                            label: 'Rest',
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                proRead.resetPassword(
                                    email: _emailController.text,
                                    context: context);
                              }
                            },
                          )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
