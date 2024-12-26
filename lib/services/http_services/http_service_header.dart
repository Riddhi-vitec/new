import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:template_flutter_mvvm_repo_bloc/di/di.dart';

import '../../app_configuration/app_environments.dart';
import '../../common/resources/enum.dart';
import '../share_preferences_services/authentication_data.dart';

AuthenticationData _sharedPreferenceServices = instance<AuthenticationData>();

// set header for http
String deviceName = "",
    deviceOsVersion = "",
    deviceOs = "",
    deviceLanguage = "en",
    deviceRegion = "";

Future<Map<String, String>> setHeader(bool isTokenRequired,
    {bool? isStripeTokenRequired, bool isMultipart = false}) async {
  Map<String, String>? headers;
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();


  if (Platform.isIOS) {
    IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
    deviceName = iosDeviceInfo.name;
    deviceOsVersion = iosDeviceInfo.systemVersion;
    deviceOs = OS.ios.toString();
  } else if (Platform.isAndroid) {
    AndroidDeviceInfo androidDeviceInfo =
        await deviceInfo.androidInfo; // unique ID on Android
    deviceName = "${androidDeviceInfo.brand} ${androidDeviceInfo.model}";
    deviceOsVersion = androidDeviceInfo.version.release;
    deviceOs = OS.android.toString();
  }

  final localeStr = Platform.localeName;
  deviceLanguage = localeStr.split("_")[0];
  deviceRegion = localeStr.split("_")[0];


  if (isTokenRequired) {
    String? userToken = await _sharedPreferenceServices.getUserAuthToken();
    if (userToken == null) {
      headers = {
        KeyManager.device_language : deviceLanguage,
       KeyManager.content_type: isMultipart
            ? KeyManager.multipart_data
            : KeyManager.application_json,
      };
    } else {
      headers = {
        KeyManager.device_language : deviceLanguage,
        KeyManager.content_type: isMultipart
            ? KeyManager.multipart_data
            : KeyManager.application_json,
        KeyManager.authorization: 'Bearer $userToken',
      };
    }

  } else if (isStripeTokenRequired!) {
    String authToken = 'Bearer ${AppEnvironments.stripePublishableKey}';
    debugPrint("authToken: $authToken");
    headers = {
      KeyManager.device_language : deviceLanguage,
      KeyManager.content_type: KeyManager.url_encoded,
      KeyManager.authorization: authToken,
    };

  } else {
    headers = {
      KeyManager.content_type:
          isMultipart ? KeyManager.multipart_data : KeyManager.application_json,
      KeyManager.device_name_header: deviceName,
      KeyManager.device_os_version_header: deviceOsVersion,
      KeyManager.device_os_header: deviceOs,
      KeyManager.device_language: deviceLanguage,
      KeyManager.device_region_header: deviceRegion,
    };
  }
  debugPrint("Headers: $headers");
  debugPrint("isTokenRequired: $isTokenRequired");
  debugPrint("isStripeTokenRequired: $isStripeTokenRequired");
  debugPrint("isMultipart: $isMultipart");
  return headers;
}

class KeyManager {
  static const String content_type = "Content-Type";
  static const String application_json = "application/json";
  static const String multipart_data = "multipart/form-data";
  static const String url_encoded = "application/x-www-form-urlencoded";
  static const String authorization = "Authorization";
  static const String bearer = "token";
  static const String device_name_header = "x-device-name";
  static const String device_os_version_header = "x-os-version";
  static const String device_os_header = "x-os";
  static const String device_language = "default_language";
  static const String device_region_header = "x-device-region";

}
