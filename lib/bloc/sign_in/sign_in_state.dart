class SignInState {
  final bool isValidEmail;
  final bool isValidPassword;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final bool showPassword;

  SignInState(
      {required this.isValidEmail,
      required this.isValidPassword,
      required this.isSubmitting,
      required this.isSuccess,
      required this.isFailure,
      required this.showPassword});
  factory SignInState.initial() {
    return SignInState(
        isValidEmail: true,
        isValidPassword: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
        showPassword: false);
  }
  factory SignInState.loading() {
    return SignInState(
        isValidEmail: true,
        isValidPassword: true,
        isSubmitting: true,
        isSuccess: false,
        isFailure: false,
        showPassword: false);
  }

  factory SignInState.failure() {
    return SignInState(
        isValidEmail: true,
        isValidPassword: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: true,
        showPassword: false);
  }

  factory SignInState.success() {
    return SignInState(
        isValidEmail: true,
        isValidPassword: true,
        isSubmitting: false,
        isSuccess: true,
        isFailure: false,
        showPassword: false);
  }

  SignInState update(
          {bool? isValidEmail,
          bool? isValidPassword,
          bool? isSubmitting,
          bool? isSuccess,
          bool? isFailure,
          bool? showPassword}) =>
      SignInState(
          isValidEmail: isValidEmail ?? this.isValidEmail,
          isValidPassword: isValidPassword ?? this.isValidPassword,
          isSubmitting: isSubmitting ?? this.isSubmitting,
          isSuccess: isSuccess ?? this.isSuccess,
          isFailure: isFailure ?? this.isFailure,
          showPassword: showPassword ?? this.showPassword);
}
