import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management/core/resources/app_colors.dart';
import 'package:leave_management/core/resources/app_fonts.dart';
import 'package:leave_management/core/resources/app_images.dart';
import 'package:leave_management/core/utils/responsive_utils.dart';
import 'package:leave_management/features/home/model/leave_model.dart';

class LeaveItem extends StatelessWidget {
  final LeaveModel leave;
  final VoidCallback onDelete;

  const LeaveItem({
    super.key,
    required this.leave,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isLandscape = ResponsiveUtils.isLandscape(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Image.asset(
                  AppImages.replacementIcon,
                  width: isLandscape ? 22.w : 50.w,
                ),
                SizedBox(width: 12.0.r),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${leave.userName} has applied Leave",
                        style: AppTextStyle.ubuntuMedium,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      if (leave.replacementName.isNotEmpty)
                        Text(
                          "Alternate Person is ${leave.replacementName}",
                          style: AppTextStyle.ubuntuBold,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onDelete,
            icon: Icon(
              Icons.delete,
              color: AppColors.kGrayColor.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
