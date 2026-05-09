import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_checkbox.dart';
import '../../../widgets/custom_edit_text.dart';
import '../../../services/token_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool rememberMe = false;
  bool isLoading = false;

  String selectedRole = "Charity";

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse("http://10.0.2.2:7240/api/Auth/login"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final token = data['token'];

        await TokenService.saveToken(token);

        emailController.clear();
        passwordController.clear();
        setState(() => rememberMe = false);

        Navigator.pushReplacementNamed(context, AppRoutes.maindonorScreen);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Login successful!'),
            backgroundColor: appTheme.green_600_01,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['message'] ?? 'Login failed'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Connection error'),
          backgroundColor: Colors.red,
        ),
      );
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              const Color(0xFF529160),
              appTheme.green_100_01,
              appTheme.white_A700,
            ],
            stops: const [0.0, 0.4, 1.0],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 18.h, left: 16.h, right: 16.h),
            child: Column(
              children: [
                Text(
                  "Ataa",
                  style: TextStyleHelper.instance.display36BoldPlusJakartaSans
                      .copyWith(color: appTheme.green_600, height: 1.28),
                ),
                Text(
                  'عطاء',
                  style: TextStyleHelper.instance.display36BoldInter.copyWith(
                    color: appTheme.green_600_01,
                    height: 1.22,
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 90.h, bottom: 60.h),
                  padding: EdgeInsets.all(16.h),
                  decoration: BoxDecoration(
                    color: appTheme.white_A700,
                    borderRadius: BorderRadius.circular(40.h),
                    border: Border.all(color: appTheme.color3F9A9A, width: 1.h),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 18.h),
                        Text(
                          "Welcome to Ataa Login Now!",
                          style: TextStyleHelper
                              .instance.headline24BoldPlusJakartaSans
                              .copyWith(height: 1.29),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildRoleOption("Charity"),
                            _buildRoleOption("Business\nDonor"),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildRoleOption("Individual\nDonor"),
                            _buildRoleOption("Admin"),
                          ],
                        ),
                        CustomEditText(
                          placeholder: "Email",
                          inputType: TextInputType.emailAddress,
                          controller: emailController,
                          validator: _validateEmail,
                          margin: EdgeInsets.only(top: 40.h),
                        ),
                        CustomEditText(
                          placeholder: "Password",
                          inputType: TextInputType.visiblePassword,
                          isPasswordField: true,
                          controller: passwordController,
                          validator: _validatePassword,
                          margin: EdgeInsets.only(top: 8.h),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10.h, right: 2.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomCheckbox(
                                text: 'Remember me',
                                value: rememberMe,
                                onChanged: (value) {
                                  setState(() {
                                    rememberMe = value ?? false;
                                  });
                                },
                                textStyle: TextStyleHelper
                                    .instance.body14RegularPlusJakartaSans,
                              ),
                              GestureDetector(
                                onTap: () => _onForgotPasswordTap(context),
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyleHelper
                                      .instance.body14RegularPlusJakartaSans
                                      .copyWith(
                                    color: appTheme.green_600_01,
                                    height: 1.29,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40.h),
                        isLoading
                            ? const CircularProgressIndicator()
                            : CustomButton(
                                text: 'Login',
                                onPressed: () => _onLoginButtonPressed(context),
                                backgroundColor: appTheme.green_600_01,
                                width: double.infinity,
                                height: 47.h,
                              ),
                        Container(
                          margin: EdgeInsets.only(top: 24.h, bottom: 10.h),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Don't have an account?",
                                  style: TextStyleHelper
                                      .instance.body14RegularPlusJakartaSans
                                      .copyWith(
                                    color: appTheme.gray_600_01,
                                    height: 1.29,
                                  ),
                                ),
                                TextSpan(
                                  text: " sign up",
                                  style: TextStyleHelper
                                      .instance.body14BoldPlusJakartaSans
                                      .copyWith(
                                    height: 1.29,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => _onSignUpTap(context),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleOption(String role) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedRole = role;
        });
      },
      child: SizedBox(
        width: 120.h,
        child: Row(
          children: [
            Icon(
              selectedRole == role
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
              color: Colors.grey,
              size: 18.h,
            ),
            SizedBox(width: 6.h),
            Expanded(
              child: Text(
                role,
                style: TextStyleHelper.instance.body14RegularPlusJakartaSans,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your email';
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your password';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  void _onLoginButtonPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      login();
    }
  }

  void _onForgotPasswordTap(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            const Text('Forgot password functionality will be implemented'),
        backgroundColor: appTheme.green_600_01,
      ),
    );
  }

  void _onSignUpTap(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.registrationScreen);
  }
}
