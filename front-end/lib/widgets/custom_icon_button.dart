import 'package:flutter/material.dart';

import '../core/app_export.dart';
import './custom_image_view.dart';

/// A customizable icon button widget with configurable styling options.
///
/// This widget provides a flexible icon button implementation with support for:
/// - Custom SVG/PNG icons via CustomImageView
/// - Configurable background colors and border styling
/// - Adjustable padding, margin, and dimensions
/// - Rounded corners with customizable border radius
/// - Tap callback functionality
///
/// @param iconPath - Path to the icon asset (SVG/PNG)
/// @param onPressed - Callback function when button is pressed
/// @param width - Width of the button
/// @param height - Height of the button
/// @param backgroundColor - Background color of the button
/// @param borderColor - Border color of the button
/// @param borderWidth - Width of the border
/// @param borderRadius - Radius for rounded corners
/// @param padding - Internal padding of the button
/// @param margin - External margin of the button
/// @param iconSize - Size of the icon inside the button
class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.iconPath,
    this.onPressed,
    this.width,
    this.height,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.padding,
    this.margin,
    this.iconSize,
  });

  /// Path to the icon asset (SVG/PNG)
  final String iconPath;

  /// Callback function when button is pressed
  final VoidCallback? onPressed;

  /// Width of the button
  final double? width;

  /// Height of the button
  final double? height;

  /// Background color of the button
  final Color? backgroundColor;

  /// Border color of the button
  final Color? borderColor;

  /// Width of the border
  final double? borderWidth;

  /// Radius for rounded corners
  final double? borderRadius;

  /// Internal padding of the button
  final EdgeInsets? padding;

  /// External margin of the button
  final EdgeInsets? margin;

  /// Size of the icon inside the button
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 32.h,
      height: height ?? 32.h,
      margin: margin ?? EdgeInsets.only(top: 6.h),
      decoration: BoxDecoration(
        color: backgroundColor ?? appTheme.whiteCustom,
        border: Border.all(
          color: borderColor ?? Color(0x755E7575),
          width: borderWidth ?? 1.h,
        ),
        borderRadius: BorderRadius.circular(borderRadius ?? 16.h),
      ),
      child: IconButton(
        onPressed: onPressed,
        padding: padding ?? EdgeInsets.all(8.h),
        constraints: BoxConstraints(),
        icon: CustomImageView(
          imagePath: iconPath,
          width: iconSize ?? 16.h,
          height: iconSize ?? 16.h,
        ),
      ),
    );
  }
}
