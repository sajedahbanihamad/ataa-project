import 'package:flutter/material.dart';

// Figma design reference
const num FIGMA_DESIGN_WIDTH = 375;
const num FIGMA_DESIGN_HEIGHT = 812;

// Responsive Extensions for height, width, font size
extension ResponsiveExtension on num {
  double get w => (this * SizeUtils.width / FIGMA_DESIGN_WIDTH);
  double get h => (this * SizeUtils.height / FIGMA_DESIGN_HEIGHT);
  double get fSize => (this * SizeUtils.width / FIGMA_DESIGN_WIDTH);
}

// Extension to safely handle zero or formatted doubles
extension FormatExtension on double {
  double toDoubleValue({int fractionDigits = 2}) {
    return double.parse(toStringAsFixed(fractionDigits));
  }

  double isNonZero({num defaultValue = 0.0}) {
    return this > 0 ? this : defaultValue.toDouble();
  }
}

// Device types
enum DeviceType { mobile, tablet, desktop }

// Responsive builder typedef
typedef ResponsiveBuild = Widget Function(
  BuildContext context,
  Orientation orientation,
  DeviceType deviceType,
);

// Main Sizer Widget
class Sizer extends StatelessWidget {
  const Sizer({super.key, required this.builder});

  final ResponsiveBuild builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeUtils.setScreenSize(constraints, orientation);
            return builder(context, orientation, SizeUtils.deviceType);
          },
        );
      },
    );
  }
}

// SizeUtils Class
class SizeUtils {
  static late BoxConstraints boxConstraints;
  static late Orientation orientation;
  static late DeviceType deviceType;

  static double width = FIGMA_DESIGN_WIDTH.toDouble();
  static double height = FIGMA_DESIGN_HEIGHT.toDouble();

  static void setScreenSize(BoxConstraints constraints, Orientation currentOrientation) {
    boxConstraints = constraints;
    orientation = currentOrientation;

    if (orientation == Orientation.portrait) {
      width = constraints.maxWidth.isNonZero(defaultValue: FIGMA_DESIGN_WIDTH);
      height = constraints.maxHeight.isNonZero(defaultValue: FIGMA_DESIGN_HEIGHT);
    } else {
      width = constraints.maxHeight.isNonZero(defaultValue: FIGMA_DESIGN_WIDTH);
      height = constraints.maxWidth.isNonZero(defaultValue: FIGMA_DESIGN_HEIGHT);
    }

    // تحديد نوع الجهاز بناء على العرض
    if (width >= 600) {
      deviceType = DeviceType.tablet;
    } else {
      deviceType = DeviceType.mobile;
    }
  }
}
