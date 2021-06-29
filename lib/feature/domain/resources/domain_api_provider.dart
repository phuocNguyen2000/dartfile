import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:wcloud/common/http/api_provider.dart';
import 'package:meta/meta.dart';

class DomainApiProvider {
  final ApiProvider apiProvider;

  DomainApiProvider({@required this.apiProvider}) : assert(apiProvider != null);

  String getRandomId(int length) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }

  Future<Map<String, dynamic>> domain(String domain) async {
    try {
      final String data = json.encode({
        "jsonrpc": "2.0",
        "method": "call",
        "params": {"context": {}},
        "id": "1234"
      });
      return await apiProvider.post(
          'https://$domain/web/webclient/version_info', data);
    } on Error catch (e) {
      throw Exception('Failed to load post ' + e.toString());
    }
  }
}
