class Validators{
  static isValidEmail(String email){
    final regularExpression = RegExp('^[');
    return regularExpression.hasMatch(email);
  }

  static isValidPassword(String password)=> password.length >=3;
}