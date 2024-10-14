import 'package:flutter/material.dart';
import 'package:leave_management/core/resources/app_colors.dart';
import 'package:leave_management/core/resources/app_fonts.dart';

class SnackBarHelper {
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: AppTextStyle.ubuntuRegular.copyWith(color: AppColors.whiteColor),
        ),
      ),
    );
  }
}
