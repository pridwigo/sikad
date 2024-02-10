import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../common/constants/env.dart';
import '../models/request/auth_request_model.dart';
import '../models/response/auth_response_model.dart';

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(
      AuthRequestModel requestModel) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    final response = await http.post(
        Uri.parse('${Environments.baseUrl}/api/login'),
        headers: headers,
        body: requestModel.toJson());

    if (response.statusCode == 200) {
      return right(AuthResponseModel.fromJson(response.body));
    } else {
      return left('Server Error');
    }
  }
}
