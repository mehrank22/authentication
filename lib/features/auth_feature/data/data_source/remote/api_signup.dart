import 'package:dio/dio.dart';

class ApiSignUp {
  Dio dio = Dio();

  Future<dynamic> sendSmsCode(String phoneNumber, String code) async {
    FormData formData = FormData.fromMap({"phone": phoneNumber, "code": code});

    var response = await dio.post('https://niyateb.ir/zanan/webservic.php',
        data: formData);
    //print(response);
    return response;
  }
}
