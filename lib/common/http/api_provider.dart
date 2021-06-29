import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;
import 'package:wcloud/feature/authentication/resource/user_repository.dart';
import 'package:wcloud/generated/l10n.dart';

import 'custom_exception.dart';

class ApiProvider {
  String session = '';
  String token = '';
  String serverVersion = '';
  void setToken(String token) {
    this.session = session;
  }

  void setSession(String session) {
    this.token = token;
  }

  void setServerVersion(String serverVersion) {
    this.serverVersion = serverVersion;
  }

  Future<Map<String, dynamic>> post(String url, dynamic body,
      {String token = ''}) async {
    dynamic responseJson;
    try {
      final dynamic response =
          await http.post(Uri.encodeFull(url), body: body, headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ',
        'Cookie': 'session_id=' + token
      });
      String cookie =
          response.headers['set-cookie'].toString().split(";").first.toString();
      final String sessionId = cookie.split("session_id=").last.toString();

      responseJson = _response(response);

      responseJson["session_id"] = sessionId;
    } on SocketException {
      throw FetchDataException(S.current.domain_does_not_exist);
    }
    return responseJson;
  }

  Future<dynamic> get(String url, {String token = '', dynamic query}) async {
    dynamic responseJson;
    try {
      final dynamic response = await http.get(Uri.encodeFull(url), headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
        'Authorization': 'Bearer ' + token
      });

      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        final dynamic responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
