import 'package:flutter/material.dart';

import '../core/app_export.dart';

/// A customizable radio group widget that displays multiple radio options
/// with configurable styling and selection handling.
///
/// @param options List of radio options to display
/// @param selectedValue Currently selected value
/// @param onChanged Callback function when selection changes
/// @param textStyle Optional custom text style for labels
/// @param activeColor Color for selected radio button
/// @param spacing Vertical spacing between radio options
/// @param crossAxisAlignment Alignment of radio items
class CustomRadioGroup<T> extends StatelessWidget {
  const CustomRadioGroup({
    super.key,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
    this.textStyle,
    this.activeColor,
    this.spacing,
    this.crossAxisAlignment,
  });

  /// List of radio options with their display text and values
  final List<CustomRadioOption<T>> options;

  /// Currently selected value in the radio group
  final T? selectedValue;

  /// Callback function triggered when radio selection changes
  final Function(T?) onChanged;

  /// Custom text style for radio labels
  final TextStyle? textStyle;

  /// Color for the active/selected radio button
  final Color? activeColor;

  /// Vertical spacing between radio options
  final double? spacing;

  /// Cross axis alignment for radio items
  final CrossAxisAlignment? crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      children: List.generate(options.length, (index) {
        final option = options[index];
        final isLast = index == options.length - 1;

        return Column(
          children: [
            InkWell(
              onTap: () => onChanged(option.value),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Radio<T>(
                    value: option.value,
                    groupValue: selectedValue,
                    onChanged: onChanged,
                    activeColor: activeColor ?? Color(0xFF000000),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  SizedBox(width: 8.h),
                  Flexible(
                    child: Text(
                      option.text,
                      style: textStyle ??
                          TextStyleHelper.instance.title16MediumPlusJakartaSans
                              .copyWith(height: 1.25),
                      textAlign: option.textAlign ?? TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
            if (!isLast) SizedBox(height: spacing ?? 10.h),
          ],
        );
      }),
    );
  }
}

/// Data model for radio option items
class CustomRadioOption<T> {
  CustomRadioOption({required this.text, required this.value, this.textAlign});

  /// Display text for the radio option
  final String text;

  /// Value associated with this radio option
  final T value;

  /// Text alignment for this specific option
  final TextAlign? textAlign;
}
