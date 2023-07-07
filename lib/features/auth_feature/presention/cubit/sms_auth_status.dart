abstract class SmsAuthStatus {}

class SmsAuthInitial extends SmsAuthStatus {}

class SmsAuthLoading extends SmsAuthStatus {}

class SmsAuthCompleted extends SmsAuthStatus {
  final String message;

  SmsAuthCompleted(this.message);
}

class SmsAuthError extends SmsAuthStatus {
  final String message;

  SmsAuthError(this.message);
}
