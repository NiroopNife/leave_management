import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management/core/resources/app_colors.dart';
import 'package:leave_management/core/resources/app_fonts.dart';

class SliderButton extends StatefulWidget {
  final String buttonText;
  final Future<void> Function(ActionSliderController) action;

  const SliderButton({
    super.key,
    required this.buttonText,
    required this.action,
  });

  @override
  State<SliderButton> createState() => _SliderButtonState();
}

class _SliderButtonState extends State<SliderButton> {
  late ActionSliderController _controller;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _controller = ActionSliderController();
  }

  @override
  void dispose() {
    _isDisposed = true;
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ActionSlider.standard(
      loadingIcon: SizedBox(
        child: Center(
          child: SizedBox(
            child: CircularProgressIndicator(
                strokeWidth: 2.0.w, color: Colors.white),
          ),
        ),
      ),
      successIcon: const SizedBox(
        child: Center(
          child: Icon(
            Icons.check_rounded,
            color: Colors.white,
          ),
        ),
      ),
      icon: const SizedBox(
        child: Center(
          child: Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
          ),
        ),
      ),
      sliderBehavior: SliderBehavior.stretch,
      backgroundColor: Colors.white,
      toggleColor: AppColors.gradientMiddleColor,
      action: (controller) async {
        if (_isDisposed) return;
        try {
          controller.loading();
          await Future.delayed(const Duration(seconds: 1));
          await widget.action(controller);
          if (!_isDisposed) {
            controller.success();
            controller.reset();
          }
        } catch (e) {
          if (!_isDisposed) {
            controller.reset();
          }
        }
      },
      child: Text(
        widget.buttonText,
        style: AppTextStyle.ubuntuMedium,
      ),
    );
  }
}
