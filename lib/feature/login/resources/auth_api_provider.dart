import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:wcloud/common/http/api_provider.dart';
import 'package:meta/meta.dart';

class AuthApiProvider {
  AuthApiProvider({@required this.baseUrl, @required this.apiProvider})
      : assert(apiProvider != null);

  final String baseUrl;

  ApiProvider apiProvider;

  Future<Map<String, dynamic>> getDb(String email, String password) async {
    try {
      final String data = json.encode({
        "jsonrpc": "2.0",
        "method": "call",
        "params": {"login": email, "password": password, "context": {}},
        "id": "1234"
      });
      return await apiProvider.post('https://$baseUrl/web/database/list', data);
    } on Error catch (e) {
      throw Exception('Failed to load post ' + e.toString());
    }
  }

  Future<Map<String, dynamic>> signIn(
      String email, String password, String database) async {
    try {
      final String data = json.encode({
        "jsonrpc": "2.0",
        "method": "call",
        "params": {
          "db": database,
          "login": email,
          "password": password,
          "context": {}
        },
        "id": "1234"
      });
      return await apiProvider.post(
          'https://$baseUrl/web/session/authenticate', data);
    } on Error catch (e) {
      throw Exception('Failed to load post ' + e.toString());
    }
  }

  Future<Map<String, dynamic>> signUp(
      String email, String password, String name) async {
    try {
      final String data =
          json.encode({'name': name, 'email': email, 'password': password});
      return await apiProvider.post('$baseUrl/signup', data);
    } on Error catch (e) {
      throw Exception('Failed to load post ' + e.toString());
    }
  }
}
