import 'package:auth_with_phone_number/features/auth_feature/data/data_source/remote/api_signup.dart';
import 'package:dio/dio.dart';

import '../../../../core/resources/data_state.dart';

class SignUpRepository {
  ApiSignUp apiSignUp = ApiSignUp();

  Future<DataState> fetchSmsData(String phoneNumber, String code) async {
    try {
      Response response = await apiSignUp.sendSmsCode(phoneNumber, code);

      if (response.statusCode == 200) {
        return DataSuccess(response.data);
      } else {
        return DataFailed(response.data);
      }
    } catch (e) {
      return DataFailed('لطفا اتصال اینترنت خود را بررسی کنید');
    }
  }
}
