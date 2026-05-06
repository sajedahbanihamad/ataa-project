import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_checkbox.dart';
import '../../../widgets/custom_edit_text.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Common
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Charity & Business
  final TextEditingController orgNameController = TextEditingController();
  final TextEditingController contactPersonController = TextEditingController();
  final TextEditingController contactPhoneController = TextEditingController();
  final TextEditingController officeAddressController = TextEditingController();

  // Individual
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String? selectedAccountType;
  bool isAgreedToTerms = false;
  bool isAgreedToDonorConditions = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    orgNameController.dispose();
    contactPersonController.dispose();
    contactPhoneController.dispose();
    officeAddressController.dispose();
    fullNameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.transparentCustom,
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
        child: Column(
          children: [
            CustomAppBar(
              title: "Ataa",
              subtitle: 'عطاء',
              leadingIcon: ImageConstant.imgArrowLeft,
              onLeadingPressed: () => Navigator.pop(context),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 18.h, left: 16.h, right: 16.h),
                child: _buildRegistrationForm(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegistrationForm(BuildContext context) {
    return Container(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            _buildAccountTypeSelection(),

            // ── Individual Donor ──
            if (selectedAccountType == 'individual') ...[
              _buildLabellessField(
                placeholder: 'Enter Your Full Name',
                controller: fullNameController,
                inputType: TextInputType.name,
                validator: (v) => (v == null || v.isEmpty)
                    ? 'Please enter your full name'
                    : null,
                topMargin: 26.h,
              ),
              _buildLabellessField(
                placeholder: 'Enter Your Phone Number',
                controller: phoneController,
                inputType: TextInputType.phone,
                validator: (v) => (v == null || v.isEmpty)
                    ? 'Please enter your phone number'
                    : null,
                topMargin: 8.h,
              ),
              _buildLabellessField(
                placeholder: 'Password',
                controller: passwordController,
                inputType: TextInputType.visiblePassword,
                isPassword: true,
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (v.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
                topMargin: 8.h,
              ),
              _buildIndividualConditionsBanner(),
              _buildDonorConditionsCheckbox(),
              _buildTermsCheckbox(),
            ],

            // ── Charity ──
            if (selectedAccountType == 'charity') ...[
              _buildEmailField(),
              _buildPasswordField(),
              _buildTermsCheckbox(),
              _buildVerificationBanner(
                message:
                    'Please provide the following details to verify your organization and start receiving donations securely on our platform.',
              ),
              _buildLabeledField(
                label: 'Organization Name',
                placeholder: 'e.g., Global Relief Fund',
                controller: orgNameController,
                inputType: TextInputType.text,
              ),
              _buildLabeledField(
                label: 'Contact Person',
                placeholder: 'Enter Full Legal Name',
                controller: contactPersonController,
                inputType: TextInputType.name,
              ),
              _buildLabeledField(
                label: 'Contact Phone',
                placeholder: '+962 *********',
                controller: contactPhoneController,
                inputType: TextInputType.phone,
              ),
              _buildLabeledField(
                label: 'Office Address',
                placeholder: 'Enter physical office location',
                controller: officeAddressController,
                inputType: TextInputType.streetAddress,
              ),
            ],

            // ── Business Donor ──
            if (selectedAccountType == 'business') ...[
              _buildEmailField(),
              _buildPasswordField(),
              _buildTermsCheckbox(),
              _buildVerificationBanner(
                message:
                    'Please provide the following details to verify your organization and start supporting communities securely on our platform.',
              ),
              _buildLabeledField(
                label: 'Business Name',
                placeholder: 'e.g., Global Relief Fund',
                controller: orgNameController,
                inputType: TextInputType.text,
              ),
              _buildLabeledField(
                label: 'Contact Person',
                placeholder: 'Enter Full Legal Name',
                controller: contactPersonController,
                inputType: TextInputType.name,
              ),
              _buildLabeledField(
                label: 'Contact Phone',
                placeholder: '+962 *********',
                controller: contactPhoneController,
                inputType: TextInputType.phone,
              ),
              _buildLabeledField(
                label: 'Office Address',
                placeholder: 'Enter physical office location',
                controller: officeAddressController,
                inputType: TextInputType.streetAddress,
              ),
            ],

            SizedBox(height: 40.h),
            _buildCreateAccountButton(context),
            _buildLoginLink(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: EdgeInsets.only(left: 44.h, top: 16.h),
      child: Text(
        'Create an Account?',
        style: TextStyleHelper.instance.headline24BoldPlusJakartaSans,
      ),
    );
  }

  Widget _buildAccountTypeSelection() {
    final options = [
      {'label': 'Charity', 'value': 'charity'},
      {'label': 'Business\nDonor', 'value': 'business'},
      {'label': 'Individual\nDonor', 'value': 'individual'},
    ];

    return Container(
      margin: EdgeInsets.only(top: 28.h),
      child: Row(
        children: options.map((option) {
          final isSelected = selectedAccountType == option['value'];
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedAccountType = option['value'];
                  orgNameController.clear();
                  contactPersonController.clear();
                  contactPhoneController.clear();
                  officeAddressController.clear();
                  fullNameController.clear();
                  phoneController.clear();
                  isAgreedToDonorConditions = false;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 18.h,
                    height: 18.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? appTheme.black_900
                            : const Color(0xFFBCBCBC),
                        width: 1.5.h,
                      ),
                    ),
                    child: isSelected
                        ? Center(
                            child: Container(
                              width: 9.h,
                              height: 9.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: appTheme.black_900,
                              ),
                            ),
                          )
                        : null,
                  ),
                  SizedBox(width: 6.h),
                  Text(
                    option['label']!,
                    textAlign: TextAlign.center,
                    style: TextStyleHelper.instance.title16MediumPlusJakartaSans
                        .copyWith(
                      fontSize: 13.h,
                      color: isSelected
                          ? appTheme.black_900
                          : const Color(0xFF888888),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildEmailField() {
    return CustomEditText(
      placeholder: 'Email',
      controller: emailController,
      inputType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please enter your email';
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
      margin: EdgeInsets.only(top: 26.h),
    );
  }

  Widget _buildPasswordField() {
    return CustomEditText(
      placeholder: 'Password',
      controller: passwordController,
      inputType: TextInputType.visiblePassword,
      isPasswordField: true,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please enter your password';
        if (value.length < 6) return 'Password must be at least 6 characters';
        return null;
      },
      margin: EdgeInsets.only(top: 8.h),
    );
  }

  Widget _buildLabellessField({
    required String placeholder,
    required TextEditingController controller,
    required TextInputType inputType,
    required String? Function(String?) validator,
    required double topMargin,
    bool isPassword = false,
  }) {
    return CustomEditText(
      placeholder: placeholder,
      controller: controller,
      inputType: inputType,
      isPasswordField: isPassword,
      validator: validator,
      margin: EdgeInsets.only(top: topMargin),
    );
  }

  Widget _buildTermsCheckbox() {
    return CustomCheckbox(
      text: 'I agree to the Terms of Services',
      value: isAgreedToTerms,
      onChanged: (value) {
        setState(() {
          isAgreedToTerms = value ?? false;
        });
      },
      textStyle: TextStyleHelper.instance.body14RegularInter,
      margin: EdgeInsets.only(top: 10.h),
    );
  }

  Widget _buildIndividualConditionsBanner() {
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      padding: EdgeInsets.all(12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(12.h),
        border: Border.all(color: const Color(0xFFFFB74D), width: 1.h),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: const Color(0xFFF57C00),
            size: 20.h,
          ),
          SizedBox(width: 10.h),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Individual Donor Conditions',
                  style: TextStyleHelper.instance.body14RegularPlusJakartaSans
                      .copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFF57C00),
                  ),
                ),
                SizedBox(height: 6.h),
                ...[
                  '1- Donated items must be clean, safe, and in good usable condition.'
                      '2- Food donations must be fresh, hygienically prepared, and properly stored.'
                      '3- Clothes, furniture, and other items must be undamaged and suitable for donation.'
                      '4- The charity has the right to reject any unsafe or unsuitable donations.'
                      '5- The donor is responsible for the accuracy and condition of the donated items.',
                ].map(
                  (condition) => Padding(
                    padding: EdgeInsets.only(bottom: 4.h),
                    child: Text(
                      condition,
                      style: TextStyleHelper
                          .instance.body14RegularPlusJakartaSans
                          .copyWith(
                        fontSize: 12.h,
                        color: const Color(0xFFF57C00),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDonorConditionsCheckbox() {
    return CustomCheckbox(
      text:
          'I agree the donor conditions and understand my responsibility as a contributor.',
      value: isAgreedToDonorConditions,
      onChanged: (value) {
        setState(() {
          isAgreedToDonorConditions = value ?? false;
        });
      },
      textStyle: TextStyleHelper.instance.body14RegularInter,
      margin: EdgeInsets.only(top: 10.h),
    );
  }

  Widget _buildVerificationBanner({required String message}) {
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      padding: EdgeInsets.all(12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(12.h),
        border: Border.all(color: const Color(0xFFFFB74D), width: 1.h),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: const Color(0xFFF57C00),
            size: 20.h,
          ),
          SizedBox(width: 10.h),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Verification Required',
                  style: TextStyleHelper.instance.body14RegularPlusJakartaSans
                      .copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFF57C00),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  message,
                  style: TextStyleHelper.instance.body14RegularPlusJakartaSans
                      .copyWith(
                    fontSize: 12.h,
                    color: const Color(0xFFF57C00),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabeledField({
    required String label,
    required String placeholder,
    required TextEditingController controller,
    required TextInputType inputType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 16.h, bottom: 6.h),
          child: Text(
            label,
            style: TextStyleHelper.instance.body14RegularPlusJakartaSans
                .copyWith(color: appTheme.black_900),
          ),
        ),
        CustomEditText(
          placeholder: placeholder,
          controller: controller,
          inputType: inputType,
          validator: (value) {
            if (value == null || value.isEmpty) return 'Please enter $label';
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildCreateAccountButton(BuildContext context) {
    final bool isEnabled = selectedAccountType != null;

    return CustomButton(
      text: 'Create Account',
      onPressed: isEnabled ? () => _onCreateAccount(context) : null,
      backgroundColor: isEnabled
          ? appTheme.green_600_01
          : appTheme.green_600_01.withOpacity(0.4),
      textColor: appTheme.white_A700,
      borderColor: appTheme.color4A3316,
      height: 47.h,
      width: double.infinity,
    );
  }

  Widget _buildLoginLink(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 24.h, bottom: 10.h),
      width: double.infinity,
      child: GestureDetector(
        onTap: () => _navigateToLogin(context),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Already have an Account? ',
                style: TextStyleHelper.instance.body14RegularPlusJakartaSans
                    .copyWith(color: appTheme.gray_600_01),
              ),
              TextSpan(
                text: 'Login',
                style: TextStyleHelper.instance.body14SemiBoldPlusJakartaSans
                    .copyWith(decoration: TextDecoration.underline),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onCreateAccount(BuildContext context) {
    if (!_validateForm(context)) return;
    setState(() => _clearForm());
    Navigator.of(context).pushReplacementNamed(AppRoutes.loginScreen);
  }

  bool _validateForm(BuildContext context) {
    if (!_formKey.currentState!.validate()) return false;
    if (!isAgreedToTerms) {
      _showSnackBar(context, 'Please agree to the Terms of Services');
      return false;
    }
    if (selectedAccountType == 'individual' && !isAgreedToDonorConditions) {
      _showSnackBar(context, 'Please agree to the donor conditions');
      return false;
    }
    return true;
  }

  void _clearForm() {
    emailController.clear();
    passwordController.clear();
    orgNameController.clear();
    contactPersonController.clear();
    contactPhoneController.clear();
    officeAddressController.clear();
    fullNameController.clear();
    phoneController.clear();
    selectedAccountType = null;
    isAgreedToTerms = false;
    isAgreedToDonorConditions = false;
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(AppRoutes.loginScreen);
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: appTheme.green_600_01,
      ),
    );
  }
}
