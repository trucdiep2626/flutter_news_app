class SignUpState {
  final bool isValidEmail;
  final bool isValidPassword;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final bool showPassword;

  SignUpState(
      {required this.isValidEmail,
      required this.isValidPassword,
      required this.isSubmitting,
      required this.isSuccess,
      required this.isFailure,
      required this.showPassword});
  factory SignUpState.initial() {
    return SignUpState(
        isValidEmail: true,
        isValidPassword: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
        showPassword: false);
  }
  factory SignUpState.loading() {
    return SignUpState(
        isValidEmail: true,
        isValidPassword: true,
        isSubmitting: true,
        isSuccess: false,
        isFailure: false,
        showPassword: false);
  }

  factory SignUpState.failure() {
    return SignUpState(
        isValidEmail: true,
        isValidPassword: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: true,
        showPassword: false);
  }

  factory SignUpState.success() {
    return SignUpState(
        isValidEmail: true,
        isValidPassword: true,
        isSubmitting: false,
        isSuccess: true,
        isFailure: false,
        showPassword: false);
  }

  SignUpState update(
          {bool? isValidEmail,
          bool? isValidPassword,
          bool? isSubmitting,
          bool? isSuccess,
          bool? isFailure,
          bool? showPassword}) =>
      SignUpState(
          isValidEmail: isValidEmail ?? this.isValidEmail,
          isValidPassword: isValidPassword ?? this.isValidPassword,
          isSubmitting: isSubmitting ?? this.isSubmitting,
          isSuccess: isSuccess ?? this.isSuccess,
          isFailure: isFailure ?? this.isFailure,
          showPassword: showPassword ?? this.showPassword);
}
