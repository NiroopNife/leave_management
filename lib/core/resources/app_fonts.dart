import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_values.dart';

class AppTextStyle {
  AppTextStyle._();

  static const String _FONT_FAMILY = "Ubuntu";

  static TextStyle ubuntuBold = TextStyle(
      fontFamily: _FONT_FAMILY,
      fontWeight: FontWeight.w800,
      fontSize: AppValues.textMediumSize,
      color: AppColors.textColor);

  static TextStyle ubuntuMedium = TextStyle(
      fontFamily: _FONT_FAMILY,
      fontWeight: FontWeight.w600,
      fontSize: AppValues.textMediumSize,
      color: AppColors.textColor);

  static const TextStyle ubuntuRegular = TextStyle(
      fontFamily: _FONT_FAMILY,
      fontWeight: FontWeight.w400,
      color: AppColors.textColor);

  static const TextStyle ubuntuLight = TextStyle(
      fontFamily: _FONT_FAMILY,
      fontWeight: FontWeight.w200,
      color: AppColors.textColor);

  static TextStyle calenderDayStyle = TextStyle(
      fontFamily: _FONT_FAMILY,
      fontWeight: FontWeight.w800,
      fontSize: AppValues.calenderDateSize,
      color: Colors.white);

  static TextStyle calenderWeekStyle = TextStyle(
      fontFamily: _FONT_FAMILY,
      fontWeight: FontWeight.w800,
      fontSize: AppValues.calenderDateSize,
      color: AppColors.textWhiteColor);

  static TextStyle calenderMonthStyle = TextStyle(
      fontFamily: _FONT_FAMILY,
      fontWeight: FontWeight.w800,
      fontSize: AppValues.calenderMonthSize,
      color: Colors.white);

  static TextStyle selectedDayStyle = TextStyle(
      fontFamily: _FONT_FAMILY,
      fontWeight: FontWeight.w800,
      fontSize: AppValues.calenderDateSize,
      color: const Color(0xFF5498D3));

  static const TextStyle errorStyle = TextStyle(
      fontFamily: _FONT_FAMILY,
      fontWeight: FontWeight.w400,
      color: AppColors.errorTextColor);
}
