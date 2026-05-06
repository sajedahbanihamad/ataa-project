import 'package:flutter/material.dart';

import '../core/app_export.dart';
import './custom_image_view.dart';

/// CustomEditText - A reusable text input field component with support for email,
/// password, and other input types. Provides built-in validation, password visibility
/// toggle, and consistent styling across the application.
///
/// @param placeholder - Hint text displayed in the input field
/// @param inputType - Keyboard type for the input (email, password, text, etc.)
/// @param isPasswordField - Whether this is a password field with visibility toggle
/// @param validator - Function to validate the input value
/// @param controller - Text editing controller for the input field
/// @param margin - External spacing around the input field
/// @param onChanged - Callback function when text changes
/// @param enabled - Whether the input field is enabled for editing
class CustomEditText extends StatefulWidget {
  const CustomEditText({
    super.key,
    this.placeholder,
    this.inputType = TextInputType.text,
    this.isPasswordField = false,
    this.validator,
    this.controller,
    this.margin,
    this.onChanged,
    this.enabled = true,
  });

  /// Hint text displayed when the input field is empty
  final String? placeholder;

  /// Keyboard type for the input field
  final TextInputType inputType;

  /// Whether this is a password field with visibility toggle
  final bool isPasswordField;

  /// Function to validate the input value
  final String? Function(String?)? validator;

  /// Text editing controller for the input field
  final TextEditingController? controller;

  /// External spacing around the input field
  final EdgeInsetsGeometry? margin;

  /// Callback function triggered when text changes
  final Function(String)? onChanged;

  /// Whether the input field is enabled for editing
  final bool enabled;

  @override
  State<CustomEditText> createState() => _CustomEditTextState();
}

class _CustomEditTextState extends State<CustomEditText> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin ?? EdgeInsets.zero,
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.inputType,
        obscureText: widget.isPasswordField ? !_isPasswordVisible : false,
        enabled: widget.enabled,
        validator: widget.validator,
        onChanged: widget.onChanged,
        style: TextStyleHelper.instance.body14RegularPlusJakartaSans.copyWith(
          height: 1.29,
        ),
        decoration: InputDecoration(
          hintText: widget.placeholder ?? "Enter text",
          hintStyle: TextStyleHelper.instance.body14RegularPlusJakartaSans
              .copyWith(height: 1.29),
          contentPadding: widget.isPasswordField
              ? EdgeInsets.only(
                  top: 12.h,
                  right: 36.h,
                  bottom: 12.h,
                  left: 12.h,
                )
              : EdgeInsets.only(
                  top: 14.h,
                  right: 16.h,
                  bottom: 14.h,
                  left: 16.h,
                ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.h),
            borderSide: BorderSide(color: appTheme.blue_gray_100, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.h),
            borderSide: BorderSide(color: appTheme.blue_gray_100, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.h),
            borderSide: BorderSide(color: appTheme.blue_gray_100, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.h),
            borderSide: BorderSide(color: appTheme.redCustom, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.h),
            borderSide: BorderSide(color: appTheme.redCustom, width: 1),
          ),
          suffixIcon: widget.isPasswordField
              ? IconButton(
                  icon: CustomImageView(
                    imagePath: _isPasswordVisible
                        ? ImageConstant.imgMdieye
                        : ImageConstant.imgMdieyeoffoutline,
                    height: 24.h,
                    width: 24.h,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
