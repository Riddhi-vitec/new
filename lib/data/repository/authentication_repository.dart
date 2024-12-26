import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../di/di.dart';
import '../../imports/common.dart';
import '../../imports/data.dart';
import '../../imports/services.dart';

class AuthenticationRepository {
  static Future<Either<Failure, CommonResponseModel>> signUp(
      {required String email}) async {
    if (await RepositoryDependencies.httpConnectionInfo.isConnected) {
      dynamic response;
      try {
        response = await AuthenticationDataService.signUp(email: email);
        Map<String, dynamic> responseJson = jsonDecode(response.body);
        CommonResponseModel signUpResponseModel =
            CommonResponseModel.fromJson(responseJson);

        if (response.statusCode == 200) {
          if (signUpResponseModel.status!) {
            return Right(signUpResponseModel);
          } else {
            return Left(Failure(0, signUpResponseModel.message!, false));
          }
        } else {
          return Left(Failure(0, signUpResponseModel.message!, false));
        }
      } catch (error) {
        return Left(DataSource.FromBE.getFailure(message: error.toString()));
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure(message: ''));
    }
  }

  static Future<Either<Failure, SignedInUserResponseModel>> signIn(
      {required SignInRequestModel signInRequestModel}) async {
    if (await RepositoryDependencies.httpConnectionInfo.isConnected) {
      dynamic response;
      AuthenticationData authenticationData = instance<AuthenticationData>();
      UserData userData = instance<UserData>();

      try {
        response = await AuthenticationDataService.signIn(
            signInRequestModel: signInRequestModel);
        Map<String, dynamic> responseJson = jsonDecode(response.body);
        SignedInUserResponseModel signInResponseModel =
            SignedInUserResponseModel.fromJson(responseJson);

        if (response.statusCode == 200) {
          if (signInResponseModel.status!) {
            await authenticationData.setUserRefreshToken(
                value: signInResponseModel.data!.refreshToken.toString());
            await authenticationData.setUserAuthToken(
                value: signInResponseModel.data!.token.toString());
            await authenticationData.hasUserActiveSession(value: true);
            await userData.setUserId(value: signInResponseModel.data!.id!);
            await userData.setUserInfo(
                jsonEncodedValue: jsonEncode(signInResponseModel.data));
            return Right(signInResponseModel);
          } else {
            return Left(Failure(0, signInResponseModel.message!, false));
          }
        } else {
          return Left(Failure(0, signInResponseModel.message!, false));
        }
      } catch (error) {
        return Left(DataSource.FromBE.getFailure(message: error.toString()));
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure(message: ''));
    }
  }

  static Future<Either<Failure, SignedInUserResponseModel>> verifyOtp(
      {required OtpRequestModel otpRequestModel}) async {
    if (await RepositoryDependencies.httpConnectionInfo.isConnected) {
      dynamic response;
      try {
        response = await AuthenticationDataService.verifyOtp(
            otpRequestModel: otpRequestModel);
        Map<String, dynamic> responseJson = jsonDecode(response.body);
        SignedInUserResponseModel otpResponseModel =
            SignedInUserResponseModel.fromJson(responseJson);

        if (response.statusCode == 200) {
          if (otpResponseModel.status!) {
            return Right(otpResponseModel);
          } else {
            return Left(Failure(0, otpResponseModel.message!, false));
          }
        } else {
          return Left(Failure(0, otpResponseModel.message!, false));
        }
      } catch (error) {
        return Left(DataSource.FromBE.getFailure(message: error.toString()));
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure(message: ''));
    }
  }

  static Future<Either<Failure, CommonResponseModel>> forgotPassword(
      {required String email}) async {
    if (await RepositoryDependencies.httpConnectionInfo.isConnected) {
      dynamic response;
      try {
        response = await AuthenticationDataService.forgotPassword(email: email);
        Map<String, dynamic> responseJson = jsonDecode(response.body);
        CommonResponseModel forgotPasswordResponseModel =
            CommonResponseModel.fromJson(responseJson);

        if (response.statusCode == 200) {
          if (forgotPasswordResponseModel.status!) {
            return Right(forgotPasswordResponseModel);
          } else {
            return Left(
                Failure(0, forgotPasswordResponseModel.message!, false));
          }
        } else {
          return Left(Failure(0, forgotPasswordResponseModel.message!, false));
        }
      } catch (error) {
        return Left(DataSource.FromBE.getFailure(message: error.toString()));
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure(message: ''));
    }
  }

  static Future<Either<Failure, CommonResponseModel>> resetPassword(
      {required ResetPasswordRequestModel resetPasswordRequestModel}) async {
    if (await RepositoryDependencies.httpConnectionInfo.isConnected) {
      dynamic response;
      try {
        response = await AuthenticationDataService.resetPassword(
            resetPasswordRequestModel: resetPasswordRequestModel);
        Map<String, dynamic> responseJson = jsonDecode(response.body);
        CommonResponseModel resetPasswordModel =
            CommonResponseModel.fromJson(responseJson);

        if (response.statusCode == 200) {
          if (resetPasswordModel.status!) {
            return Right(resetPasswordModel);
          } else {
            return Left(Failure(0, resetPasswordModel.message!, false));
          }
        } else {
          return Left(Failure(0, resetPasswordModel.message!, false));
        }
      } catch (error) {
        return Left(DataSource.FromBE.getFailure(message: error.toString()));
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure(message: ''));
    }
  }




}
