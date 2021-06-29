import 'dart:async';
import 'dart:convert';

import 'package:wcloud/common/http/api_provider.dart';
import 'package:meta/meta.dart';
import 'package:wcloud/feature/authentication/resource/user_repository.dart';

class ContactApiProvider {
  ContactApiProvider({@required this.baseUrl, @required this.apiProvider})
      : assert(apiProvider != null);

  final ApiProvider apiProvider;
  UserRepository userRepository = new UserRepository();
  String baseUrl;
  Future<Map<String, dynamic>> contact(int id) async {
    print("G: In contact api provider: $baseUrl");
    baseUrl = await userRepository.fetchDomain();
    try {
      final String data = json.encode({
        "jsonrpc": "2.0",
        "method": "call",
        "id": "123",
        "params": {
          "args": [
            [id],
            [
              "company_type",
              "name",
              "commercial_partner_id",
              "phone",
              "company_name",
              "type",
              "street",
              "street2",
              "city",
              "website",
              "state_id",
              "type",
              "zip",
              "country_id",
              "email",
              "website",
              "title",
              "website",
              "display_name"
            ]
          ],
          "model": "res.partner",
          "method": "read",
          "kwargs": {
            "context": {
              "bin_size": "",
              "lang": "",
              "tz": "",
              "uid": "",
              "allowed_company_ids": "",
              "default_is_company": ""
            }
          }
        }
      });
      String token = await UserRepository().fetchToken();
      return await apiProvider
          .post('https://$baseUrl/web/dataset/call_kw', data, token: token);
    } on Error catch (e) {
      throw Exception('Failed to load post ' + e.toString());
    }
  }
}
