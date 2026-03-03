import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/modules/Auth/model/login/response_data_model.dart';
import 'package:movie_app/modules/Auth/network/constants/auth_api_constants.dart';
import 'package:movie_app/modules/Auth/network/constants/auth_end_points.dart';

class AuthApi {
  static Future<String> loginRequest(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${AuthApiConstants.baseURL}${AuthEndPoints.loginEndPoint}'),
        headers: {'content-type': 'application/json'},
        body: jsonEncode({"email": email, "password": password}),
      );
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        jsonDecode(response.body);
        ResponseDataModel responseDataModel = ResponseDataModel.fromJson(data);
        return responseDataModel.data;
      } else {
        jsonDecode(response.body);
        throw Exception(data['message'] ?? "Something went wrong");
      }
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}
