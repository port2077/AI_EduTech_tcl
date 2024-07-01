extension PasswordValidator on String {
  String get passwordError {
    bool hasUppercase = contains(RegExp(r'[A-Z]'));
    bool hasLowercase = contains(RegExp(r'[a-z]'));
    bool hasDigits = contains(RegExp(r'[0-9]'));
    bool hasSpecialCharacters = contains(RegExp(r'[!@#$&*~]'));

    if (hasUppercase && hasLowercase && hasDigits && hasSpecialCharacters) {
      return 'success';
    } else {
      return 'error';
    }
  }
}
