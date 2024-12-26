import 'dart:convert';
import 'package:template_flutter_mvvm_repo_bloc/imports/data.dart';
import '../../device_variables.dart';
import '../../imports/app_configuration.dart';
import '../../imports/common.dart';
import '../../imports/services.dart';

class AuthenticationDataService {
  static Future signUp({required String email}) async {
    String baseUrl = '${UrlPrefixes.baseUrl}${UrlSuffixes.signUp}';


    var data = json.encode({
      "email": email,
    });

    final response = await HttpServices.postMethod(baseUrl,
        data: data, header: await setHeader(true));

    return response;
  }

  static Future signIn({required SignInRequestModel signInRequestModel}) async {
    String baseUrl = signInRequestModel.isSocial
        ? '${UrlPrefixes.baseUrl}${UrlSuffixes.socialSignIn}'
        : '${UrlPrefixes.baseUrl}${UrlSuffixes.signIn}';
    String deviceToken = await DeviceVariables.deviceToken();

    var data = json.encode({
      "email": signInRequestModel.email,
      if (!signInRequestModel.isSocial) "password": signInRequestModel.password,
      "deviceType": DeviceVariables.deviceType,
      "deviceToken": deviceToken,
      if (signInRequestModel.isSocial) ...{
        "isVerifiedEmail": signInRequestModel.isEmailVerified,
        "socialId": signInRequestModel.socialId,
        "socialType": signInRequestModel.socialType,
      },
    });

    final response = await HttpServices.postMethod(baseUrl,
        data: data, header: await setHeader(true));

    return response;
  }

  static Future verifyOtp({required OtpRequestModel otpRequestModel}) async {
    String baseUrl = '${UrlPrefixes.baseUrl}${UrlSuffixes.otp}';
    var data = jsonEncode({
      "isChangeEmail": otpRequestModel.isChangeEmail,
      //if from register then false, if from change email then true
      "fullName": otpRequestModel.fullName,
      "email": otpRequestModel.email,
      "password": otpRequestModel.password,
      "otp": otpRequestModel.otp,
      "deviceType": otpRequestModel.deviceType,
      "deviceToken": otpRequestModel.deviceToken,
      "isSocialAccountVerification":
          otpRequestModel.isSocialAccountVerification,
      "socialId": otpRequestModel.socialId,
      //isSocialAccountVerification =true then pass value else null
      "socialType": otpRequestModel.socialType,
      //google/apple/facebook   (isSocialAccountVerification =true then pass value else null)
    });

    final response = await HttpServices.postMethod(baseUrl,
        data: data, header: await setHeader(true));
    return response;
  }

  static Future forgotPassword({required String email}) async {
    String baseUrl = '${AppEnvironments.baseUrl}${UrlSuffixes.forgotPassword}';
    var data = jsonEncode({"email": email});

    final response = await HttpServices.postMethod(baseUrl,
        data: data, header: await setHeader(true));
    return response;
  }

  static Future resetPassword(
      {required ResetPasswordRequestModel resetPasswordRequestModel}) async {
    String baseUrl = '${AppEnvironments.baseUrl}${UrlSuffixes.resetPassword}';
    var data = jsonEncode({
      "passwordToken": resetPasswordRequestModel.resetPasswordToken,
      "newPassword": resetPasswordRequestModel.newPassword
    });

    final response = await HttpServices.postMethod(baseUrl,
        data: data, header: await setHeader(true));

    return response;
  }

  static Future signOutUser() async {
    String baseUrl = '${AppEnvironments.baseUrl}${UrlSuffixes.signOut}';
    final response =
        await HttpServices.postMethod(baseUrl, header: await setHeader(true));
    return response;
  }

  static Future changePassword(
      {required ChangePasswordRequestModel changePasswordRequestModel}) async {
    String baseUrl = '${AppEnvironments.baseUrl}${UrlSuffixes.changePassword}';
    var data = jsonEncode({
      "oldPassword": changePasswordRequestModel.oldPassword,
      "password": changePasswordRequestModel.password
    });

    final response = await HttpServices.putMethod(baseUrl,
        data: data, header: await setHeader(true));
    return response;
  }
}
