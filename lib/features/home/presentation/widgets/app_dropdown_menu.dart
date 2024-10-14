import 'package:flutter/material.dart';
import 'package:leave_management/core/resources/app_colors.dart';
import 'package:leave_management/core/resources/app_fonts.dart';

class AppDropdownMenu extends StatelessWidget {

  final double width;
  final String hintText;
  final List<DropdownMenuEntry> dropdownMenuEntries;
  final DropdownMenuEntry? selectedEntry;
  final void Function(dynamic) onSelected;
  final TextEditingController searchController;

  const AppDropdownMenu({
    super.key,
    required this.width,
    required this.hintText,
    required this.dropdownMenuEntries,
    this.selectedEntry,
    required this.onSelected,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      width: width,
      controller: searchController,
      hintText: hintText,
      textStyle: AppTextStyle.ubuntuMedium,
      requestFocusOnTap: true,
      enableFilter: true,
      menuStyle: MenuStyle(
        backgroundColor: WidgetStateProperty.all<Color>(AppColors.whiteColor),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.kGrayColor.shade400,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.kGrayColor.shade400,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.kGrayColor.shade200,
            width: 1.0,
          ),
        ),
        hintStyle: AppTextStyle.ubuntuRegular.copyWith(
          color: AppColors.kGrayColor.shade500,
        ),
      ),
      onSelected: onSelected,
      dropdownMenuEntries: dropdownMenuEntries,
    );
  }
}
