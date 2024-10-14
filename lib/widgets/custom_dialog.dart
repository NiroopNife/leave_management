import 'package:flutter/material.dart';
import 'package:leave_management/core/resources/app_colors.dart';
import 'package:leave_management/core/resources/app_values.dart';

class CustomDialog extends StatelessWidget {

  final Widget childWidget;
  final String dialogImage;

  const CustomDialog({super.key, required this.childWidget, required this.dialogImage});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppValues.padding),
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: EdgeInsets.only(top: AppValues.avatarRadius),
            padding: EdgeInsets.only(
              left: AppValues.padding,
              top: AppValues.avatarRadius + AppValues.padding,
              bottom: AppValues.padding,
              right: AppValues.padding,
            ),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(AppValues.padding),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 10.0),
                )
              ],
            ),
            child: childWidget,
          ),
          Positioned(
            left: AppValues.padding,
            right: AppValues.padding,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: AppValues.avatarRadius,
              child: Image.asset(
                dialogImage,
              ),
            ),
          )
        ],
      ),
    );
  }
}