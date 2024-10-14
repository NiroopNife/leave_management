class AuthState {
  String? employeeNumberError;
  String? phoneNumberError;
  final bool showPhoneNumberError;
  final bool isExtraWidgetVisible;
  final bool showEmployeeNumberError;
  final bool isRegistered;

  AuthState({
    this.employeeNumberError,
    this.phoneNumberError,
    this.showPhoneNumberError = false,
    this.isExtraWidgetVisible = false,
    this.showEmployeeNumberError = false,
    this.isRegistered = false,
  });

  AuthState copyWith({
    String? employeeNumberError,
    String? phoneNumberError,
    bool? showPhoneNumberError,
    bool? isExtraWidgetVisible,
    bool? showEmployeeNumberError,
    bool? isRegistered,
  }) {
    return AuthState(
      employeeNumberError: employeeNumberError ?? this.employeeNumberError,
      phoneNumberError: phoneNumberError ?? this.phoneNumberError,
      showPhoneNumberError: showPhoneNumberError ?? this.showPhoneNumberError,
      isExtraWidgetVisible: isExtraWidgetVisible ?? this.isExtraWidgetVisible,
      showEmployeeNumberError: showEmployeeNumberError ?? this.showEmployeeNumberError,
      isRegistered: isRegistered ?? this.isRegistered,
    );
  }
}
