import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../../imports/common.dart';
import '../../imports/data.dart';
import '../../imports/services.dart';

class UserDataServices {
  static Future getProfile() async {
    String baseUrl = '${UrlPrefixes.baseUrl}${UrlSuffixes.getProfile}';
    final response =
        await HttpServices.getMethod(baseUrl, header: await setHeader(true));
    return response;
  }

  static Future contactUs(
      {required ContactUsRequestModel contactUsRequestModel}) async {
    String baseUrl = '${UrlPrefixes.baseUrl}${UrlSuffixes.contactUs}';
    var data = jsonEncode({
      "userId": contactUsRequestModel.userId, //pass when user login else null
      "fullName": contactUsRequestModel.firstName,
      "email": contactUsRequestModel.email,
      "message": contactUsRequestModel.message,
      "code": contactUsRequestModel.code,
      "number": contactUsRequestModel.number
    });
    final response = await HttpServices.postMethod(baseUrl,
        data: data, header: await setHeader(true));
    return response;
  }

  static Future getCms() async {
    String baseUrl = '${UrlPrefixes.baseUrl}${UrlSuffixes.getCms}';
    final response =
        await HttpServices.getMethod(baseUrl, header: await setHeader(true));
    return response;
  }

  static Future updateProfile(
      {required ProfileUpdateRequestModel profileUpdateRequestModel}) async {
    List<MultipartFile> profileArray = [];
    String baseUrl = '${UrlPrefixes.baseUrl}${UrlSuffixes.updateProfile}';
    final Map<String, String> data = {
      'firstName': profileUpdateRequestModel.firstName,
      'lastName': profileUpdateRequestModel.lastName,
      'birthday': profileUpdateRequestModel.birthday,
      'countryCode': profileUpdateRequestModel.countryCode,
      'mobileNumber': profileUpdateRequestModel.mobileNumber,
      'address': profileUpdateRequestModel.address,
    };
    if (profileUpdateRequestModel.profileImage != null) {
      final multipartFile = await http.MultipartFile.fromPath(
        "profile",
        profileUpdateRequestModel.profileImage!.path,
      );
      profileArray.add(multipartFile);
    }
    final response = await HttpServices.postMultiPartResponse(
        url: baseUrl,
        bodyData: data,
        listFile: profileArray.isNotEmpty ? profileArray : null,
        header: await setHeader(true, isMultipart: true));
    return response;
  }

  static Future changeEmail({required String email}) async {
    String baseUrl ='${UrlPrefixes.baseUrl}${UrlSuffixes.changeEmail}';
    var data = jsonEncode({
      'email': email
    });

    final response = await HttpServices.putMethod(baseUrl, data: data, header: await setHeader(true));
    print('Here baseUrl $baseUrl -- here data $data ');
    print('Here status ${response.statusCode} ${response.body} -- here header ${await setHeader(true)} ');
    return response;
  }
  static Future signOutUser() async {
    String baseUrl = '${UrlPrefixes.baseUrl}${UrlSuffixes.signOut}';
    final response =
        await HttpServices.getMethod(baseUrl, header: await setHeader(true));
    return response;
  }
 static Future deleteAccount() async {
    String baseUrl = '${UrlPrefixes.baseUrl}${UrlSuffixes.deleteAccount}';
    final response = await HttpServices.postMethod(baseUrl, header: await setHeader(true));
    return response;
  }
  static Future deletionVerification({required String otp}) async {
    String baseUrl = '${UrlPrefixes.baseUrl}${UrlSuffixes.deletionVerification}$otp';
    final response = await HttpServices.deleteMethod(baseUrl, header: await setHeader(true));
    return response;
  }

}
