import 'package:flutter/material.dart';
import 'package:leave_management/core/resources/app_colors.dart';

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;

  const GradientAppBar({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title ?? ""),
      flexibleSpace: Container(
        decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(0);
}
