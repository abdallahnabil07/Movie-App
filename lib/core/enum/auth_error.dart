abstract class AuthError {
  String get message;
}

class InvalidCredential extends AuthError {
  @override
  String get message => 'Email or password is incorrect';
}

class WrongPassword extends AuthError {
  @override
  String get message => 'Password is wrong';
}

class TooManyRequest extends AuthError {
  @override
  String get message => 'Too many attempts. Please try again later.';
}

class Unknown extends AuthError {
  @override
  String get message => 'Unknown error';
}

class CustomError extends AuthError {
  final String customMessage;

  CustomError(this.customMessage);

  @override
  String get message => customMessage;
}
