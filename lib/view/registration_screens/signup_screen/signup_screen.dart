import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valet_parking_admin/controller/registration_controller.dart';
import 'package:valet_parking_admin/utils/constants/color_constants.dart';
import 'package:valet_parking_admin/utils/functions/validations.dart';
import 'package:valet_parking_admin/utils/styles/String_styles.dart';
import 'package:valet_parking_admin/utils/styles/animation_styles.dart';
import 'package:valet_parking_admin/widgets/buttonWidget.dart';
import 'package:valet_parking_admin/widgets/textfeildWidget.dart';

class SignupScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final proRead = context.read<RegistrationController>();
    final proWatch = context.watch<RegistrationController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Sign Up',
          style: StringStyles.headingStyle(),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Create an Account',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.primaryColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Sign up to get started',
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
                      controller: _nameController,
                      label: 'Name',
                      validation: (value) => Validations.validateName(value),
                    ),
                    const SizedBox(height: 16),
                    TextfeildWidget(
                      controller: _emailController,
                      label: 'Email',
                      validation: (value) => Validations.validateEmail(value),
                    ),
                    const SizedBox(height: 16),
                    TextfeildWidget(
                      controller: _passwordController,
                      wantObscure: true,
                      label: 'Password',
                      validation: (value) =>
                          Validations.validatePassword(value),
                    ),
                    const SizedBox(height: 16),
                    TextfeildWidget(
                      wantObscure: true,
                      controller: _confirmPasswordController,
                      label: 'Confirm Password',
                      validation: (value) {
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    proWatch.isRegLoading
                        ? AnimationStyles.loadingIndicator()
                        : ButtonWidget(
                            width: 200,
                            label: 'Signup',
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                proRead.createUser(
                                  name: _nameController.text,
                                    context: context,
                                    email: _emailController.text,
                                    password: _passwordController.text);
                              }
                            },
                          )
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account? ',
                      style: TextStyle(fontSize: 14)),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: ColorConstants.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
