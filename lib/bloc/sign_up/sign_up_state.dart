class SignUpState{
  final bool isValidEmail;
  final bool isValidPassword;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  bool get isValidEmailAndPassword => isValidEmail && isValidPassword;

  SignUpState({
    required this.isValidEmail,
    required this.isValidPassword,
    required this.isSubmitting,
    required this.isSuccess, required this.isFailure
  });
  factory SignUpState.initial(){
    return SignUpState(isValidEmail: true,
        isValidPassword: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: false);
  }
  factory SignUpState.loading(){
    return SignUpState(isValidEmail: true,
        isValidPassword: true,
        isSubmitting: true,
        isSuccess: false,
        isFailure: false);
  }

  factory SignUpState.failure(){
    return SignUpState(isValidEmail: true,
        isValidPassword: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: true);
  }

  factory SignUpState.success(){
    return SignUpState(isValidEmail: true,
        isValidPassword: true,
        isSubmitting: false,
        isSuccess: true,
        isFailure: false);
  }

  SignUpState update(
  { bool? isValidEmail,
    bool? isValidPassword,
    bool? isSubmitting,
    bool? isSuccess,
     bool? isFailure,}
      )
  => SignUpState (
    isValidEmail:  isValidEmail?? this.isValidEmail,
    isValidPassword: isValidPassword ?? this.isValidPassword,
    isSubmitting: isSubmitting?? this.isSubmitting,
    isSuccess: isSuccess ?? this.isSuccess,
    isFailure: isFailure ?? this.isFailure,
  );
}