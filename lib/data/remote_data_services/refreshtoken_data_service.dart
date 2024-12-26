import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:template_flutter_mvvm_repo_bloc/data/repository/authentication_repository.dart';

import '../../device_variables.dart';
import '../../di/di.dart';
import '../../imports/common.dart';
import '../../imports/services.dart';

class RefreshTokenDataService {
  static Future refreshToken() async {
    AuthenticationData sharedPreferenceServices =
        instance<AuthenticationData>();
    String baseUrl = '${UrlPrefixes.baseUrl}${UrlSuffixes.refreshToken}';
    String deviceToken = await DeviceVariables.deviceToken();
    String refreshToken =
        await sharedPreferenceServices.getUserRefreshToken() ?? '';
    var data = json.encode({
      "refreshToken": refreshToken,
      "deviceType": DeviceVariables.deviceType,
      "deviceToken": deviceToken
    });


    final response = await HttpServices.postMethod(baseUrl,
        data: data, header: await setHeader(true));

    return response;
  }
}
