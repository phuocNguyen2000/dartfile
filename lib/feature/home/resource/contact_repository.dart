import 'package:flutter/material.dart';
import 'package:wcloud/common/constant/env.dart';
import 'package:wcloud/common/http/api_provider.dart';
import 'package:wcloud/common/http/response.dart';
import 'package:wcloud/common/util/internet_check.dart';

import 'contact_api_provider.dart';

class ContactRepository {
  ApiProvider apiProvider;
  ContactApiProvider contactApiProvider;
  InternetCheck internetCheck;
  Env env;

  ContactRepository(
      {@required this.env,
      @required this.apiProvider,
      @required this.internetCheck}) {
    contactApiProvider =
        new ContactApiProvider(baseUrl: env.baseUrl, apiProvider: apiProvider);
  }

  Future<DataResponse<String>> contact(int id) async {
    print("G: In contact respository: ${contactApiProvider.baseUrl}");

    final response = await contactApiProvider.contact(id);
    if (response == null) {
      return DataResponse.connectivityError();
    }

    if (response['error'] == null) {
      return DataResponse.success("Success");
    } else {
      print(response['error']);
      return DataResponse.error("Error");
    }
  }
}
