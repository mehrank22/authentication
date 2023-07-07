part of 'signup_cubit.dart';

class SignUpState {
  SmsAuthStatus smsAuthStatus;
  PageViewStatus pageViewStatus;

  SignUpState({required this.smsAuthStatus, required this.pageViewStatus});

  SignUpState copyWith(
      {PageViewStatus? newPageViewStatus, SmsAuthStatus? newSmsAuthStatus}) {
    return SignUpState(
        pageViewStatus: newPageViewStatus ?? pageViewStatus,
        smsAuthStatus: newSmsAuthStatus ?? smsAuthStatus);
  }
}
