import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leave_management/core/providers/auth_provider/auth_provider.dart';
import 'package:leave_management/core/providers/auth_provider/auth_state.dart';
import 'package:leave_management/core/resources/app_colors.dart';
import 'package:leave_management/core/resources/app_constants.dart';
import 'package:leave_management/core/resources/app_fonts.dart';
import 'package:leave_management/core/resources/app_images.dart';
import 'package:leave_management/core/resources/app_values.dart';
import 'package:leave_management/widgets/custom_text_form_field.dart';
import 'package:leave_management/widgets/slider_button.dart';
import 'package:pinput/pinput.dart';

class AuthView extends ConsumerWidget {
  final _phoneNumberKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(AuthProvider.authProvider);
    final authProvider = ref.watch(AuthProvider.authProvider.notifier);

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(70),
                  bottomRight: Radius.circular(70),
                ),
              ),
            ),
            Positioned(
              top: 40.0.h,
              left: 0.0,
              right: 0.0,
              child: Center(child: _titleText(authState)),
            ),
            Center(
              child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(AppValues.padding),
                  ),
                  child: _loginData(context, authState, authProvider)),
            )
          ],
        ),
      ),
    );
  }

  Widget _titleText(AuthState authState) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        AppConstants.loginPageText,
        style: AppTextStyle.ubuntuMedium.copyWith(
          fontSize: 22.sp,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }

  Widget _loginData(BuildContext context, AuthState authState,
      AuthProviderNotifier authProvider) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 25.w,
      ),
      height: authState.isExtraWidgetVisible
          ? MediaQuery.of(context).size.height * 0.6
          : MediaQuery.of(context).size.height * 0.45,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(color: AppColors.kGrayColor.shade50),
      child: Column(
        children: [
          Form(
            key: _phoneNumberKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: Text(
                    authState.isExtraWidgetVisible
                        ? AppConstants.verification
                        : AppConstants.login,
                    style: AppTextStyle.ubuntuBold.copyWith(fontSize: 20.sp),
                  ),
                ),
                CustomTextField(
                  focusNode: authProvider.employeeNumberFocusNode,
                  enabled: !authState.isExtraWidgetVisible,
                  hintText: AppConstants.employeeNumber,
                  prefixIcon: AppImages.personIcon,
                  controller: authProvider.employeeNumberController,
                  inputType: TextInputType.text,
                  errorText: authState.employeeNumberError,
                ),
                CustomTextField(
                  gapBetweenWidget: 20,
                  focusNode: authProvider.phoneNumberFocusNode,
                  enabled: !authState.isExtraWidgetVisible,
                  hintText: AppConstants.phoneNumber,
                  prefixIcon: AppImages.phoneIcon,
                  controller: authProvider.phoneNumberController,
                  inputType: TextInputType.phone,
                  errorText: authState.phoneNumberError,
                ),
                if (!authState.isExtraWidgetVisible)
                  SliderButton(
                    buttonText: AppConstants.getOTP,
                    action: (controller) async {
                      try {
                        authProvider.fetchOTP();
                      } catch (e) {
                        print("Error is $e");
                      }
                    },
                  ),
              ],
            ),
          ),
          if (authState.isExtraWidgetVisible)
            Column(
              children: [
                Pinput(
                  focusNode: authProvider.pinFocusNode,
                  validator: (value) {
                    return value == "1234" ? null : "Pin is Incorrect";
                  },
                  onCompleted: (pin) {},
                  errorBuilder: (errorText, pin) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: Text(
                          errorText ?? "",
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        AppConstants.didntGetCode,
                        style: AppTextStyle.ubuntuRegular,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          AppConstants.resendCode,
                          style: AppTextStyle.ubuntuMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                SliderButton(
                  buttonText: AppConstants.verifyOTP,
                  action: (controller) async {
                    authProvider.login();
                  },
                )
              ],
            ),
        ],
      ),
    );
  }
}
