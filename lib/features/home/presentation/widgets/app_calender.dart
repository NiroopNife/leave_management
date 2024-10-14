import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management/core/resources/app_colors.dart';
import 'package:leave_management/core/resources/app_fonts.dart';
import 'package:leave_management/core/utils/responsive_utils.dart';
import 'package:leave_management/features/home/model/leave_model.dart';
import 'package:table_calendar/table_calendar.dart';

class AppCalender extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final Map<DateTime, List<LeaveModel>> leaves;
  final List<LeaveModel> selectedLeave;
  final Function(DateTime selectedDay, DateTime focusedDay) onDaySelected;

  AppCalender({
    Key? key,
    required this.focusedDay,
    required this.selectedDay,
    required this.leaves,
    required this.selectedLeave,
    required this.onDaySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLandscape = ResponsiveUtils.isLandscape(context);

    return Container(
      padding: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40.w),
          bottomRight: Radius.circular(40.w),
        ),
        gradient: AppColors.primaryGradient,
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2024, 1, 1),
        lastDay: DateTime.utc(2040, 12, 31),
        focusedDay: focusedDay,
        selectedDayPredicate: (day) => isSameDay(selectedDay, day),
        onDaySelected: onDaySelected,
        eventLoader: (day) => leaves[day] ?? [],
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          leftChevronIcon: const Icon(
            Icons.chevron_left,
            color: AppColors.whiteColor,
          ),
          rightChevronIcon: const Icon(
            Icons.chevron_right,
            color: AppColors.whiteColor,
          ),
          titleTextStyle: AppTextStyle.calenderMonthStyle,
        ),
        onPageChanged: (focusedDay) {
          focusedDay = focusedDay;
        },
        daysOfWeekStyle: DaysOfWeekStyle(
          weekendStyle: AppTextStyle.calenderWeekStyle,
          weekdayStyle: AppTextStyle.calenderWeekStyle,
        ),
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, date, focusedDay) {
            final hasLeaves = leaves[date] != null && leaves[date]!.isNotEmpty;
            return Container(
              margin: EdgeInsets.all(4.0.w),
              decoration: BoxDecoration(
                color:
                    hasLeaves ? AppColors.errorShadeColor : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${date.day}',
                  style: AppTextStyle.calenderDayStyle,
                ),
              ),
            );
          },
          selectedBuilder: (context, date, focusedDay) {
            return Container(
              margin: const EdgeInsets.all(4.0),
              decoration: const BoxDecoration(
                color: AppColors.whiteColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${date.day}',
                  style: AppTextStyle.selectedDayStyle,
                ),
              ),
            );
          },
          todayBuilder: (context, date, focusedDay) {
            return Container(
              margin: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: AppColors.whiteColor.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${date.day}',
                  style: AppTextStyle.calenderDayStyle,
                ),
              ),
            );
          },
        ),
        calendarStyle: CalendarStyle(
          todayTextStyle: AppTextStyle.calenderDayStyle,
          selectedTextStyle: AppTextStyle.selectedDayStyle,
          selectedDecoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          defaultTextStyle: AppTextStyle.calenderDayStyle,
          weekendTextStyle: AppTextStyle.calenderDayStyle,
        ),
        calendarFormat:
            isLandscape ? CalendarFormat.week : CalendarFormat.month,
      ),
    );
  }
}
