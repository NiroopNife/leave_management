import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management/core/resources/app_constants.dart';
import 'package:leave_management/core/resources/app_fonts.dart';
import 'package:leave_management/core/resources/app_images.dart';
import 'package:leave_management/core/utils/common_functions.dart';
import 'package:leave_management/core/utils/responsive_utils.dart';
import 'package:leave_management/core/utils/snackbar_helper.dart';
import 'package:leave_management/features/home/model/leave_model.dart';
import 'package:leave_management/features/home/model/users_model.dart';
import 'package:leave_management/features/home/presentation/widgets/app_dropdown_menu.dart';
import 'package:leave_management/widgets/custom_dialog.dart';
import 'package:leave_management/widgets/slider_button.dart';

class LeaveDialog extends StatefulWidget {
  final DateTime focusedDay;
  final Map<DateTime, List<LeaveModel>> leaves;
  final List<LeaveModel> selectedLeave;
  final Function(String) onLeaveAdded;
  final Function(List<LeaveModel>) onSelectedLeaveChanged;

  LeaveDialog({
    Key? key,
    required this.focusedDay,
    required this.leaves,
    required this.selectedLeave,
    required this.onLeaveAdded,
    required this.onSelectedLeaveChanged,
  }) : super(key: key);

  @override
  State<LeaveDialog> createState() => _LeaveDialogState();
}

class _LeaveDialogState extends State<LeaveDialog> {
  final ValueNotifier<String> _dropdownValueNotifier =
      ValueNotifier<String>('');
  final ValueNotifier<UserModel?> _selectedUserNotifier =
      ValueNotifier<UserModel?>(null);
  final TextEditingController searchUserController = TextEditingController();
  final ValueNotifier<String?> _errorNotifier = ValueNotifier<String?>(null);

  @override
  void dispose() {
    _dropdownValueNotifier.dispose();
    _selectedUserNotifier.dispose();
    _errorNotifier.dispose();
    super.dispose();
  }

  bool _isUserValid(String userName) {
    return users.any((user) => user.name == userName);
  }

  bool _isUserAlreadySelected(String userName) {
    return widget.selectedLeave
        .where((leave) => leave.leaveDate == widget.focusedDay)
        .any((leave) => leave.replacementName == userName);
  }

  bool _hasLeavesForDay() {
    return widget.leaves[widget.focusedDay]?.isNotEmpty ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      childWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "${AppConstants.selectedDay} ${CommonFunctions().formatDate(widget.focusedDay, AppConstants.monthDayYearFormat)}",
            style: AppTextStyle.ubuntuMedium,
          ),
          const SizedBox(height: 10),
          Text(
            AppConstants.dialogTitle,
            style: AppTextStyle.ubuntuMedium,
          ),
          SizedBox(height: 10.h),
          ValueListenableBuilder<String>(
            valueListenable: _dropdownValueNotifier,
            builder: (context, dropdownValue, child) {
              return AppDropdownMenu(
                width: ResponsiveUtils.getScreenWidth(context) * 0.7,
                hintText: AppConstants.selectReplacement,
                dropdownMenuEntries:
                    users.map<DropdownMenuEntry<UserModel>>((UserModel user) {
                  return DropdownMenuEntry(
                    value: user,
                    label: user.name,
                    leadingIcon: const Icon(Icons.person),
                  );
                }).toList(),
                onSelected: (dynamic user) {
                  if (user != null && user is UserModel) {
                    if (_isUserAlreadySelected(user.name)) {
                      _errorNotifier.value =
                          "User already selected for this day.";
                      return;
                    }
                    _errorNotifier.value = null;
                    _selectedUserNotifier.value = user;
                    _dropdownValueNotifier.value = user.name;
                  }
                },
                searchController: searchUserController,
              );
            },
          ),
          SizedBox(height: 10.h),
          ValueListenableBuilder<String?>(
            valueListenable: _errorNotifier,
            builder: (context, errorMessage, child) {
              if (errorMessage != null) {
                return Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red, fontSize: 14.sp),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          SizedBox(height: 20.h),
          Align(
            alignment: Alignment.center,
            child: SliderButton(
              buttonText: AppConstants.confirm,
              action: (controller) async {
                final dropdownValue = _dropdownValueNotifier.value;
                if (_hasLeavesForDay()) {
                  if (dropdownValue.isEmpty ||
                      !_isUserValid(searchUserController.text) ||
                      !_isUserValid(dropdownValue)) {
                    SnackBarHelper.showSnackBar(
                        context, AppConstants.dialogUserError);
                    return;
                  }
                }

                controller.loading();
                await Future.delayed(const Duration(seconds: 1));

                List<LeaveModel> updatedLeaves =
                    List.from(widget.selectedLeave);
                updatedLeaves.add(LeaveModel(
                  userName: 'Person A',
                  replacementName: dropdownValue,
                  leaveDate: widget.focusedDay,
                  appliedLeaveOn: DateTime.now(),
                ));

                widget.onSelectedLeaveChanged(updatedLeaves);

                controller.success();
                await Future.delayed(const Duration(seconds: 1));
                Navigator.pop(context);
                controller.reset();
                widget.onLeaveAdded(dropdownValue);
              },
            ),
          ),
        ],
      ),
      dialogImage: AppImages.calenderLeaveIcon,
    );
  }
}
