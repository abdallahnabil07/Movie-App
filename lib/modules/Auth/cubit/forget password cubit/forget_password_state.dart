abstract class ForgetPasswordState {}

class ForgetPasswordInitial extends ForgetPasswordState {}

class ForgetPasswordLoading extends ForgetPasswordState {}

class ForgetPasswordEmailSent extends ForgetPasswordState {}

class ForgetPasswordError extends ForgetPasswordState {
  final String message;
  ForgetPasswordError(this.message);
}
