import 'dart:convert';

import '../../imports/common.dart';
import '../../imports/services.dart';

class NotificationDataService {
  static Future getNotification() async {
    String baseUrl = '${UrlPrefixes.baseUrl}${UrlSuffixes.getNotification}';
    print(baseUrl);
    print('1');

    final response =
        await HttpServices.getMethod(baseUrl, header: await setHeader(true));

    return response;
  }
  static Future readNotification({required String notificationID}) async {
    String baseUrl = '${UrlPrefixes.baseUrl}${UrlSuffixes.readNotification}$notificationID';


    final response =
    await HttpServices.putMethod(baseUrl, header: await setHeader(true));

    return response;
  }
}
