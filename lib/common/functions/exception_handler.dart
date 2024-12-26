import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:template_flutter_mvvm_repo_bloc/data/repository/authentication_repository.dart';
import 'package:template_flutter_mvvm_repo_bloc/data/repository/refresh_token_repository.dart';

import '../../di/di.dart';
import '../../imports/common.dart';
import '../../imports/services.dart';
import '../../root_app.dart';




enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECEIVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  FromBE
}

class ResponseCode {


  // local status code
  static const int DEFAULT = -1;
  static const int CONNECT_TIMEOUT = -2;
  static const int CANCEL = -3;
  static const int RECEIVE_TIMEOUT = -4;
  static const int SEND_TIMEOUT = -5;
  static const int CACHE_ERROR = -6;
  static const int NO_INTERNET_CONNECTION = -7;
}

class ResponseMessage {
  static const String NO_INTERNET_CONNECTION = "No Internet connection";
}

class Failure {
  int code; // 200 or 400
  bool status; // 200 or 400
  String message; // error or success

  Failure(this.code, this.message, this.status);
}

extension DataSourceExtension on DataSource {
  Failure getFailure({ int? responseCode, required String message}) {
    switch (this) {
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION.trim(), false);
      case DataSource.FromBE:
        return Failure( responseCode ?? ResponseCode.DEFAULT, message, false);
      default:
        return Failure(ResponseCode.DEFAULT, message, false);
    }
  }
}

class AppExceptions implements Exception {
  late Failure failure;
  final AuthenticationData _authenticationData = instance<AuthenticationData>();

  AppExceptions.handle(int error, {required String message, required bool isRefreshTokenValid, required Function? callApiAgain})    {
    if (error == 401) {
      //if your backup token is valid then call refresh api to update user-info to stay logged in.
      if(isRefreshTokenValid) {
        RefreshTokenRepository.refreshToken(callTheCurrentPageApiAgain: callApiAgain!);
      }else{
        _authenticationData.removeUserDataCache();
        Navigator.pushNamedAndRemoveUntil(
          navigatorKey.currentContext!,
          RouteName.routeSignIn,
              (Route<dynamic> route) => false,
        );
      }
    }
    failure = DataSource.FromBE.getFailure(responseCode: error, message: message);
  }
}

class ApiInternalStatus {
  static const int SUCCESS = 0;
  static const int FAILURE = 1;
}
