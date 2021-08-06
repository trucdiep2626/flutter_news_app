class Validators {
  static isValidEmail(String email) {
    final regularExpression = RegExp("&=_'-+,<>");
    return email.contains('@') &&
        !regularExpression.hasMatch(email) &&
        !email.startsWith('.') &&
        !email.endsWith('.');
  }

  static isValidPassword(String password) => password.length >= 6;
}
