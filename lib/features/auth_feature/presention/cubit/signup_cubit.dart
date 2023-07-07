import 'package:auth_with_phone_number/core/resources/data_state.dart';
import 'package:auth_with_phone_number/features/auth_feature/data/repository/signup_repository.dart';
import 'package:auth_with_phone_number/features/auth_feature/presention/cubit/page_view_status.dart';
import 'package:auth_with_phone_number/features/auth_feature/presention/cubit/sms_auth_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpRepository signUpRepository = SignUpRepository();
  SignUpCubit()
      : super(SignUpState(
            pageViewStatus: PageViewInitial(),
            smsAuthStatus: SmsAuthInitial()));

  void changeButtonText(String text) =>
      emit(state.copyWith(newPageViewStatus: PageViewCompleted(text)));

  Future<void> callSmsAuth(String phoneNumber, String code) async {
    emit(state.copyWith(newSmsAuthStatus: SmsAuthLoading()));

    DataState dataState =
        await signUpRepository.fetchSmsData(phoneNumber, code);

    if (dataState is DataSuccess) {
      emit(state.copyWith(newSmsAuthStatus: SmsAuthCompleted(dataState.data)));
    }

    if (dataState is DataFailed) {
      emit(
          state.copyWith(newSmsAuthStatus: SmsAuthCompleted(dataState.error!)));
    }
  }
}
