import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../di/di.dart';
import '../../imports/common.dart';
import '../../imports/data.dart';
import '../../imports/services.dart';

class RefreshTokenRepository{
  static Future<Either<Failure, SignedInUserResponseModel>> refreshToken({required Function callTheCurrentPageApiAgain}) async {
    if (await RepositoryDependencies.httpConnectionInfo.isConnected) {
      dynamic response;
      AuthenticationData authenticationData = instance<AuthenticationData>();
      UserData userData = instance<UserData>();

      try {
        response = await RefreshTokenDataService.refreshToken();
        Map<String, dynamic> responseJson = jsonDecode(response.body);
        SignedInUserResponseModel refreshTokenResponseModel =
        SignedInUserResponseModel.fromJson(responseJson);

        if (response.statusCode == 200) {
          if (refreshTokenResponseModel.status!) {
            await resetUserInfo(authenticationData, refreshTokenResponseModel, userData);
            callTheCurrentPageApiAgain();
            return Right(refreshTokenResponseModel);
          } else {
            return Left(Failure(0, refreshTokenResponseModel.message!, false));
          }
        } else if (response.statusCode == 401) {
          return (Left(AppExceptions.handle(
            isRefreshTokenValid: false,
              int.parse(response.statusCode.toString()),
            message: refreshTokenResponseModel.message!,
            callApiAgain: null
          ).failure));
        } else {
          return Left(Failure(0, refreshTokenResponseModel.message!, false));
        }
      } catch (error) {
        return Left(DataSource.FromBE.getFailure(message: error.toString()));
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure(message: ''));
    }
  }

  static Future<void> resetUserInfo(AuthenticationData authenticationData, SignedInUserResponseModel refreshTokenResponseModel, UserData userData) async {
           await authenticationData.removeUserDataCache();
    await authenticationData.setUserRefreshToken(
        value: refreshTokenResponseModel.data!.refreshToken.toString());
    await authenticationData.setUserAuthToken(
        value: refreshTokenResponseModel.data!.token.toString());
    await authenticationData.hasUserActiveSession(value: true);
    await userData.setUserId(value: refreshTokenResponseModel.data!.id!);
    await userData.setUserInfo(jsonEncodedValue: jsonEncode(refreshTokenResponseModel.data));
  }
}