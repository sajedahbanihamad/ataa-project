import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A helper class for managing text styles in the application
class TextStyleHelper {
  static TextStyleHelper? _instance;

  TextStyleHelper._();

  static TextStyleHelper get instance {
    _instance ??= TextStyleHelper._();
    return _instance!;
  }

  // Display Styles
  // Large text styles typically used for headers and hero elements

  TextStyle get display36BoldPlusJakartaSans => TextStyle(
        fontSize: 36.fSize,
        fontWeight: FontWeight.w700,
        fontFamily: 'Plus Jakarta Sans',
      );

  TextStyle get display36BoldInter => TextStyle(
        fontSize: 36.fSize,
        fontWeight: FontWeight.w700,
        fontFamily: 'Inter',
      );

  // Headline Styles
  // Medium-large text styles for section headers

  TextStyle get headline24BoldPlusJakartaSans => TextStyle(
        fontSize: 24.fSize,
        fontWeight: FontWeight.w700,
        fontFamily: 'Plus Jakarta Sans',
        color: appTheme.black_900,
      );

  // Title Styles
  // Medium text styles for titles and subtitles

  TextStyle get title20RegularRoboto => TextStyle(
        fontSize: 20.fSize,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
      );

  TextStyle get title18MediumPlusJakartaSans => TextStyle(
        fontSize: 18.fSize,
        fontWeight: FontWeight.w500,
        fontFamily: 'Plus Jakarta Sans',
      );

  TextStyle get title16MediumPlusJakartaSans => TextStyle(
        fontSize: 16.fSize,
        fontWeight: FontWeight.w500,
        fontFamily: 'Plus Jakarta Sans',
        color: appTheme.black_900,
      );

  // Body Styles
  // Standard text styles for body content

  TextStyle get body14RegularPlusJakartaSans => TextStyle(
        fontSize: 14.fSize,
        fontWeight: FontWeight.w400,
        fontFamily: 'Plus Jakarta Sans',
        color: appTheme.gray_600,
      );

  TextStyle get body14BoldPlusJakartaSans => TextStyle(
        fontSize: 14.fSize,
        fontWeight: FontWeight.w700,
        fontFamily: 'Plus Jakarta Sans',
        color: appTheme.green_600_01,
      );

  TextStyle get body14RegularInter => TextStyle(
        fontSize: 14.fSize,
        fontWeight: FontWeight.w400,
        fontFamily: 'Inter',
        color: appTheme.gray_600,
      );

  TextStyle get body14SemiBoldPlusJakartaSans => TextStyle(
        fontSize: 14.fSize,
        fontWeight: FontWeight.w600,
        fontFamily: 'Plus Jakarta Sans',
        color: appTheme.green_600_01,
      );
}
