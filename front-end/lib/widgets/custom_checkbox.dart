import 'package:flutter/material.dart';

import '../core/app_export.dart';

/// CustomCheckbox - A reusable checkbox component with customizable text and styling
///
/// Features:
/// - Configurable text content and styling
/// - Customizable checkbox appearance and colors
/// - Support for different text alignments and font styles
/// - Responsive design with SizeUtils
/// - Optional margin and spacing configuration
/// - Callback function for value changes
///
/// @param text - The text to display next to the checkbox
/// @param value - Current checkbox state (checked/unchecked)
/// @param onChanged - Callback function when checkbox state changes
/// @param textStyle - Optional text style for the label
/// @param activeColor - Color when checkbox is checked
/// @param checkColor - Color of the checkmark
/// @param margin - Optional margin around the component
/// @param spacing - Space between checkbox and text
class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox({
    super.key,
    required this.text,
    required this.value,
    required this.onChanged,
    this.textStyle,
    this.activeColor,
    this.checkColor,
    this.margin,
    this.spacing,
  });

  /// Text to display next to the checkbox
  final String text;

  /// Current checkbox state (checked/unchecked)
  final bool value;

  /// Callback function when checkbox state changes
  final ValueChanged<bool?> onChanged;

  /// Optional text style for the label
  final TextStyle? textStyle;

  /// Color when checkbox is checked
  final Color? activeColor;

  /// Color of the checkmark
  final Color? checkColor;

  /// Optional margin around the component
  final EdgeInsetsGeometry? margin;

  /// Space between checkbox and text
  final double? spacing;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.zero,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 20.h,
            width: 20.h,
            child: Checkbox(
              value: value,
              onChanged: onChanged,
              activeColor: activeColor ?? Theme.of(context).primaryColor,
              checkColor: checkColor ?? appTheme.whiteCustom,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
          SizedBox(width: spacing ?? 8.h),
          Expanded(
            child: GestureDetector(
              onTap: () => onChanged(!value),
              child: Text(
                text,
                style: textStyle ?? TextStyleHelper.instance.body14RegularInter,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
