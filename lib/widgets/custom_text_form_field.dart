import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management/core/resources/app_colors.dart';
import 'package:leave_management/core/resources/app_fonts.dart';

class CustomTextField extends StatelessWidget {
  final int gapBetweenWidget;
  final String hintText;
  final IconData prefixIcon;
  final TextEditingController controller;
  final String? errorText;
  final TextInputType inputType;
  final bool enabled;
  final FocusNode? focusNode;
  final bool hasError;

  const CustomTextField({
    this.gapBetweenWidget = 10,
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    this.errorText,
    required this.inputType,
    this.enabled = true,
    this.focusNode,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: gapBetweenWidget.h),
      child: TextFormField(
        focusNode: focusNode,
        enabled: enabled,
        controller: controller,
        style: AppTextStyle.ubuntuMedium,
        inputFormatters: [LengthLimitingTextInputFormatter(10)],
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: hintText,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelStyle: AppTextStyle.ubuntuRegular.copyWith(color: Colors.grey),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.transparentColor),
            borderRadius: BorderRadius.circular(16),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.transparentColor),
            borderRadius: BorderRadius.circular(16),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.transparentColor),
            borderRadius: BorderRadius.circular(16),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.errorTextColor),
            borderRadius: BorderRadius.circular(16),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.transparentColor),
            borderRadius: BorderRadius.circular(16),
          ),
          prefixIcon: Icon(prefixIcon, color: Colors.black54),
          filled: true,
          fillColor: AppColors.gradientMiddleColor.withOpacity(.2),
          errorText: errorText == null || errorText!.isEmpty ? null : errorText,
        ),
      ),
    );
  }
}
