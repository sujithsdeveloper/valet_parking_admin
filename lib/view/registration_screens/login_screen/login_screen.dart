import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valet_parking_admin/controller/registration_controller.dart';
import 'package:valet_parking_admin/utils/constants/assetsConstants.dart';
import 'package:valet_parking_admin/utils/constants/color_constants.dart';
import 'package:valet_parking_admin/utils/functions/validations.dart';
import 'package:valet_parking_admin/utils/styles/String_styles.dart';
import 'package:valet_parking_admin/utils/styles/animation_styles.dart';
import 'package:valet_parking_admin/view/registration_screens/forgot_password_screen/forgot_password_screen.dart';
import 'package:valet_parking_admin/view/registration_screens/signup_screen/signup_screen.dart';
import 'package:valet_parking_admin/widgets/buttonWidget.dart';
import 'package:valet_parking_admin/widgets/textfeildWidget.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final proRead = context.read<RegistrationController>();
    final proWatch = context.watch<RegistrationController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Login',
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
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.primaryColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Please login to your account',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextfeildWidget(
                      wantObscure: false,
                      controller: _emailController,
                      label: 'Email',
                      validation: (p0) => Validations.validateEmail(p0),
                    ),
                    const SizedBox(height: 16),
                    TextfeildWidget(
                      controller: _passwordController,
                      wantObscure: true,
                      label: 'Password',
                      validation: (p0) => Validations.validatePassword(p0),
                    ),
                    const SizedBox(height: 24),
                    proWatch.isLoginLoading
                        ? AnimationStyles.loadingIndicator()
                        : ButtonWidget(
                            width: 200,
                            label: 'Login',
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                proRead.login(
                                  context: context,
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                              }
                            },
                          )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ForgotPasswordScreen(),
                    ),
                  );
                },
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: ColorConstants.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                        height: 20,
                        image: AssetImage(ImageConstants.googleImage)),
                    const SizedBox(width: 9),
                    const Text('Sign in with Google'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don’t have an account?',
                      style: TextStyle(fontSize: 14)),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignupScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Create one',
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
