import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wcloud/common/constant/env.dart';
import 'package:wcloud/common/http/api_provider.dart';
import 'package:wcloud/common/http/response.dart';
import 'package:wcloud/common/util/internet_check.dart';
import 'package:meta/meta.dart';

import 'domain_api_provider.dart';

class DomainRepository {
  final ApiProvider apiProvider;
  DomainApiProvider domainApiProvider;
  InternetCheck internetCheck;

  DomainRepository({@required this.apiProvider, @required this.internetCheck}) {
    domainApiProvider = DomainApiProvider(apiProvider: apiProvider);
  }

  Future<DataResponse<String>> domain(String domain) async {
    final response = await domainApiProvider.domain(domain);
    if (response == null) {
      return DataResponse.connectivityError();
    }
    if (response['error'] == null) {
      return DataResponse.success(response['server-version']);
    } else {
      return DataResponse.error("Error");
    }
  }

  Future<void> persistDomain(String domain) async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    try {
      await storage.write(key: 'domain', value: domain);
      return true;
    } on Exception catch (e) {
      print('custom exception is been obtained');
    }
    return false;
  }
}
