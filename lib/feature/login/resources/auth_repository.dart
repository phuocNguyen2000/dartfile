import 'package:wcloud/common/constant/env.dart';
import 'package:wcloud/common/http/api_provider.dart';
import 'package:wcloud/common/http/response.dart';
import 'package:wcloud/common/util/internet_check.dart';
import 'package:meta/meta.dart';
import 'package:wcloud/feature/authentication/resource/user_repository.dart';

import 'auth_api_provider.dart';

class AuthRepository {
  final ApiProvider apiProvider;
  AuthApiProvider authApiProvider;
  InternetCheck internetCheck;
  Env env;

  AuthRepository(
      {@required this.env,
      @required this.apiProvider,
      @required this.internetCheck}) {
    authApiProvider =
        AuthApiProvider(baseUrl: env.baseUrl, apiProvider: apiProvider);
  }

  Future<DataResponse<String>> login(
      String email, String password, String database) async {
    final response = await authApiProvider.signIn(email, password, database);
    if (response == null) {
      return DataResponse.connectivityError();
    }

    if (response["error"] == null) {
      final String token = response["session_id"];
      UserRepository userRepository = new UserRepository();

      userRepository.persistToken(token);
      userRepository.persistDomain(authApiProvider.baseUrl);
      print("Session id: $token");
      return DataResponse.success(token);
    } else {
      return DataResponse.error(response["error"]["data"]["name"]);
    }
  }

  Future<DataResponse<String>> getDb(String email, String password) async {
    final response = await authApiProvider.getDb(email, password);
    if (response == null) {
      return DataResponse.connectivityError();
    }

    if (response["error"] == null) {
      final String db = response["result"][0];

      return DataResponse.success(db);
    } else {
      return DataResponse.error(response["error"]["data"]["name"]);
    }
  }

  Future<Map<String, dynamic>> signUp(
      String email, String password, String name) {
    return authApiProvider.signUp(email, password, name);
  }
}
