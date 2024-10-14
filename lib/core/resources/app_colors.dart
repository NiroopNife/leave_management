import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color kPrimaryColor = Color(0xFF2470C7);
  static const Color errorTextColor = Color(0xFFF16063);
  static const Color errorShadeColor = Color(0x80D99393);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color textColor = Color(0xFF36454F);
  static const Color textWhiteColor = Color(0xFFFAF9F6);
  static const Color gradientLightColor = Color(0xFF3D93E3);
  static const Color gradientMiddleColor = Color(0xFF2f8eec);
  static const Color gradientDarkColor = Color(0xFF2D3194);
  static const Color transparentColor = Colors.transparent;

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [gradientLightColor, gradientDarkColor],
  );

  static const MaterialColor kGrayColor = MaterialColor(
    0xFF212121,
    {
      900: Color(0xFF212121),
      800: Color(0xFF424242),
      700: Color(0xFF616161),
      600: Color(0xFF757575),
      500: Color(0xFF9E9E9E),
      400: Color(0xFFBDBDBD),
      300: Color(0xFFE0E0E0),
      200: Color(0xFFEEEEEE),
      100: Color(0xFFF5F5F5),
      50: Color(0xFFFAFAFA),
    },
  );
}
