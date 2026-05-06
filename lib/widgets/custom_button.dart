import 'package:flutter/material.dart';

import '../core/app_export.dart';

/// CustomButton - A flexible button component supporting various styles and configurations
///
/// @param text - The text to display on the button (required)
/// @param onPressed - Callback function when button is pressed (required)
/// @param backgroundColor - Background color of the button (optional, defaults to primary color)
/// @param textColor - Color of the button text (optional, defaults to white)
/// @param borderColor - Color of the button border (optional, no border if null)
/// @param width - Width of the button (optional, defaults to flexible width)
/// @param height - Height of the button (optional, defaults to auto height)
/// @param isDisabled - Whether the button is disabled (optional, defaults to false)
class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.width,
    this.height,
    this.isDisabled = false,
  });

  /// The text to display on the button
  final String text;

  /// Callback function when button is pressed
  final VoidCallback? onPressed;

  /// Background color of the button
  final Color? backgroundColor;

  /// Color of the button text
  final Color? textColor;

  /// Color of the button border
  final Color? borderColor;

  /// Width of the button
  final double? width;

  /// Height of the button
  final double? height;

  /// Whether the button is disabled
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    final effectiveBackgroundColor = backgroundColor ?? Color(0xFF529160);
    final effectiveTextColor = textColor ?? appTheme.whiteCustom;
    final effectiveHeight = height ?? 47.h;

    return SizedBox(
      width: width,
      height: effectiveHeight,
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: effectiveBackgroundColor,
          foregroundColor: effectiveTextColor,
          elevation: 0,
          shadowColor: appTheme.transparentCustom,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.h),
            side: borderColor != null
                ? BorderSide(color: borderColor!, width: 1.h)
                : BorderSide.none,
          ),
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 30.h),
        ),
        child: Text(
          text,
          style: TextStyleHelper.instance.title18MediumPlusJakartaSans,
        ),
      ),
    );
  }
}
