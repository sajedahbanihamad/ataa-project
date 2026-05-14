import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class AppNavigationScreen extends StatelessWidget {
  const AppNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Column(
                    children: [
                      _buildScreenTitle(
                        context,
                        screenTitle: "login",
                        onTapScreenTitle: () =>
                            onTapScreenTitle(context, AppRoutes.loginScreen),
                      ),
                      _buildScreenTitle(
                        context,
                        screenTitle: "signup",
                        onTapScreenTitle: () => onTapScreenTitle(
                          context,
                          AppRoutes.registrationScreen,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScreenTitle(
    BuildContext context, {
    required String screenTitle,
    Function? onTapScreenTitle,
  }) {
    return GestureDetector(
      onTap: () => onTapScreenTitle?.call(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        decoration: const BoxDecoration(color: Color(0xFFFFFFFF)),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  screenTitle,
                  textAlign: TextAlign.center,
                  style: TextStyleHelper.instance.title20RegularRoboto
                      .copyWith(color: const Color(0xFF000000)),
                ),
                const Icon(Icons.arrow_forward, color: Color(0xFF343330)),
              ],
            ),
            SizedBox(height: 10.h),
            Divider(
                height: 1.h, thickness: 1.h, color: const Color(0xFFD2D2D2)),
          ],
        ),
      ),
    );
  }

  void onTapScreenTitle(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  void onTapBottomSheetTitle(BuildContext context, Widget className) {
    showModalBottomSheet(
      context: context,
      builder: (context) => className,
      isScrollControlled: true,
      backgroundColor: appTheme.transparentCustom,
    );
  }

  void onTapDialogTitle(BuildContext context, Widget className) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: className,
        backgroundColor: appTheme.transparentCustom,
        insetPadding: EdgeInsets.zero,
      ),
    );
  }
}
