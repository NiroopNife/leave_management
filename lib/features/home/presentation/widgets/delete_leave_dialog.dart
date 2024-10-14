import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management/core/resources/app_constants.dart';
import 'package:leave_management/core/resources/app_fonts.dart';
import 'package:leave_management/core/resources/app_images.dart';
import 'package:leave_management/widgets/custom_dialog.dart';
import 'package:leave_management/widgets/slider_button.dart';

class DeleteLeaveDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  const DeleteLeaveDialog({required this.onConfirm, super.key});

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
        childWidget: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppConstants.removeLeaveTitle,
              style: AppTextStyle.ubuntuBold,
            ),
            SizedBox(height: 20.h),
            SliderButton(
              buttonText: AppConstants.confirm,
              action: (controller) async {
                onConfirm();
                Navigator.pop(context);
              },
            )
          ],
        ),
        dialogImage: AppImages.leaveDeleteIcon);
  }
}
