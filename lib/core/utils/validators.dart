class Validators {
  bool validatePhoneNumber(String phoneNumber) {
    final RegExp phoneNumberRegex = RegExp(r"^[6789]\d{9}$");
    return phoneNumberRegex.hasMatch(phoneNumber);
  }

  bool validateEmployeeNumber(String employeeNumber) {
    final RegExp employeeRegex = RegExp(r"^[A-Za-z0-9]+$");
    return employeeRegex.hasMatch(employeeNumber);
  }

  bool validateName(String name) {
    final RegExp nameRegex = RegExp(r"^[A-Za-z\s]+$");
    return nameRegex.hasMatch(name);
  }
}
