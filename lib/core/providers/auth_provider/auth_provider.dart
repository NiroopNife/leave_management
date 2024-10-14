import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_management/core/providers/auth_provider/auth_state.dart';
import 'package:leave_management/core/resources/app_constants.dart';
import 'package:leave_management/core/utils/validators.dart';

class AuthProvider {
  AuthProvider._();

  static final authProvider =
      StateNotifierProvider<AuthProviderNotifier, AuthState>((ref) {
    return AuthProviderNotifier();
  });
}

class AuthProviderNotifier extends StateNotifier<AuthState> {
  late TextEditingController employeeNumberController;
  late TextEditingController phoneNumberController;
  late FocusNode employeeNumberFocusNode;
  late FocusNode phoneNumberFocusNode;
  late ScrollController scrollController;
  late FocusNode pinFocusNode;

  AuthProviderNotifier() : super(AuthState()) {
    employeeNumberController = TextEditingController();
    phoneNumberController = TextEditingController();
    employeeNumberFocusNode = FocusNode();
    phoneNumberFocusNode = FocusNode();
    scrollController = ScrollController();
    pinFocusNode = FocusNode();

    pinFocusNode.addListener(() {
      if (pinFocusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 300), () {
          scrollController.animateTo(scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut);
        });
      }
    });
  }

  void fetchOTP() async {
    final employeeNumber = employeeNumberController.text.trim();
    final phoneNumber = phoneNumberController.text.trim();

    if (employeeNumber.isEmpty) {
      state = state.copyWith(
          showEmployeeNumberError: true,
          employeeNumberError: AppConstants.emptyEmployeeNumber);
      employeeNumberFocusNode.requestFocus();
      return;
    } else if (!Validators().validateEmployeeNumber(employeeNumber)) {
      state = state.copyWith(
          showEmployeeNumberError: true,
          employeeNumberError: AppConstants.incorrectEmployeeNumber);
      employeeNumberFocusNode.requestFocus();
      return;
    } else {
      state = state.copyWith(employeeNumberError: "");
    }

    if (phoneNumber.isEmpty) {
      state = state.copyWith(
        showPhoneNumberError: true,
        phoneNumberError: AppConstants.emptyPhoneNumber,
      );
      phoneNumberFocusNode.requestFocus();
      return;
    } else if (!Validators().validatePhoneNumber(phoneNumber)) {
      state = state.copyWith(
          showPhoneNumberError: true,
          phoneNumberError: AppConstants.incorrectPhoneNumber);
      phoneNumberFocusNode.requestFocus();
      return;
    }

    await FirebaseAuth.instance.verifyPhoneNumber(
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException exception) {
          state = state.copyWith(
            employeeNumberError: "",
            phoneNumberError: exception.toString(),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          state = state.copyWith(
            employeeNumberError: "",
            phoneNumberError: "",
            isExtraWidgetVisible: !state.isExtraWidgetVisible,
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        phoneNumber: "+91$phoneNumber");

    state = state.copyWith(
      employeeNumberError: "",
      phoneNumberError: "",
      isExtraWidgetVisible: !state.isExtraWidgetVisible,
    );
  }

  void login() {
    state =
        state.copyWith(phoneNumberError: "", isRegistered: !state.isRegistered);
  }

  @override
  void dispose() {
    employeeNumberController.dispose();
    phoneNumberController.dispose();
    employeeNumberFocusNode.dispose();
    phoneNumberFocusNode.dispose();
    scrollController.dispose();
    pinFocusNode.dispose();
    super.dispose();
  }
}
