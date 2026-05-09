import 'package:flutter/material.dart';

import '../core/app_export.dart';
import './custom_image_view.dart';

/// CustomAppBar - A reusable app bar component with support for leading icon,
/// main title, and optional subtitle text.
///
/// @param title - Main title text displayed prominently
/// @param subtitle - Optional secondary title text (supports different languages)
/// @param leadingIcon - Path to the leading icon (back button)
/// @param onLeadingPressed - Callback function when leading icon is pressed
/// @param titleColor - Color for the main title text
/// @param subtitleColor - Color for the subtitle text
/// @param backgroundColor - Background color of the app bar
/// @param leadingBackgroundColor - Background color of the leading icon button
/// @param leadingBorderColor - Border color of the leading icon button
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.leadingIcon,
    this.onLeadingPressed,
    this.titleColor,
    this.subtitleColor,
    this.backgroundColor,
    this.leadingBackgroundColor,
    this.leadingBorderColor,
  });

  /// Main title text displayed in the app bar
  final String title;

  /// Optional subtitle text for additional information
  final String? subtitle;

  /// Path to the leading icon image
  final String? leadingIcon;

  /// Callback function triggered when leading icon is pressed
  final VoidCallback? onLeadingPressed;

  /// Color for the main title text
  final Color? titleColor;

  /// Color for the subtitle text
  final Color? subtitleColor;

  /// Background color of the app bar
  final Color? backgroundColor;

  /// Background color of the leading icon button
  final Color? leadingBackgroundColor;

  /// Border color of the leading icon button
  final Color? leadingBorderColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? appTheme.transparentCustom,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: _buildLeadingIcon(context),
      title: _buildTitleSection(),
      titleSpacing: 72.h,
    );
  }

  /// Builds the leading icon button with custom styling
  Widget? _buildLeadingIcon(BuildContext context) {
    if (leadingIcon == null) return null;

    return Container(
      margin: EdgeInsets.only(top: 6.h, left: 16.h),
      child: IconButton(
        onPressed: onLeadingPressed ?? () => Navigator.of(context).pop(),
        icon: Container(
          width: 32.h,
          height: 32.h,
          padding: EdgeInsets.all(8.h),
          decoration: BoxDecoration(
            color: leadingBackgroundColor ?? Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(16.h),
            border: Border.all(
              color: leadingBorderColor ?? Color(0x755E7575),
              width: 1.h,
            ),
          ),
          child: CustomImageView(
            imagePath: leadingIcon!,
            height: 16.h,
            width: 16.h,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  /// Builds the title section with main title and optional subtitle
  Widget _buildTitleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyleHelper.instance.display36BoldPlusJakartaSans.copyWith(
            color: titleColor ?? Color(0xFF52905F),
            height: 1.28,
          ),
        ),
        if (subtitle != null) ...[
          Container(
            margin: EdgeInsets.only(left: 28.h),
            child: Text(
              subtitle!,
              style: TextStyleHelper.instance.display36BoldInter.copyWith(
                color: subtitleColor ?? Color(0xFF529160),
                height: 1.22,
              ),
            ),
          ),
        ],
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(subtitle != null ? 145.h : 99.h);
}
