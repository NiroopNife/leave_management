import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management/core/resources/app_constants.dart';
import 'package:leave_management/core/resources/app_fonts.dart';
import 'package:leave_management/core/resources/app_images.dart';
import 'package:leave_management/core/utils/common_functions.dart';
import 'package:leave_management/features/home/model/leave_model.dart';
import 'package:leave_management/widgets/custom_dialog.dart';

class LeaveDetailsDialog extends StatelessWidget {
  final LeaveModel leave;
  const LeaveDetailsDialog({super.key, required this.leave});

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
        childWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            leaveDetailRow(
                imagePath: AppImages.leaveIcon,
                script:
                    "Details of ${CommonFunctions().formatDate(leave.leaveDate, AppConstants.monthDayYearFormat)} leave"),
            leaveDetailRow(
                imagePath: AppImages.personAlertIcon,
                script: "${leave.userName} applied leave"),
            if (leave.replacementName.isNotEmpty)
              leaveDetailRow(
                  imageWidth: 21.0,
                  imagePath: AppImages.personReplacementIcon,
                  script: "Alternate person is ${leave.replacementName}"),
            leaveDetailRow(
                imageWidth: 21.0,
                imagePath: AppImages.leavePostedIcon,
                script:
                    "Leave posted on :- \n${CommonFunctions().formatDate(leave.appliedLeaveOn, AppConstants.monthDayTimeFormat)}"),
          ],
        ),
        dialogImage: AppImages.leaveDetailsIcon);
  }

  Widget leaveDetailRow(
      {double imageWidth = 20.0,
      required String imagePath,
      required String script}) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(imagePath, width: imageWidth.w),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                script,
                maxLines: 2,
                style: AppTextStyle.ubuntuMedium.copyWith(fontSize: 16.sp),
              ),
            )
          ],
        ),
        SizedBox(height: 12.w)
      ],
    );
  }
}
