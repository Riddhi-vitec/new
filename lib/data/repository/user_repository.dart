import 'dart:convert';

import 'package:dartz/dartz.dart';
import '../../imports/common.dart';
import '../../imports/data.dart';

class UserRepository {
  static Future<Either<Failure, SignedInUserResponseModel>> getProfile() async {
    if (await RepositoryDependencies.httpConnectionInfo.isConnected) {
      dynamic response;
      try {
        response = await UserDataServices.getProfile();
        Map<String, dynamic> responseJson = jsonDecode(response.body);
        SignedInUserResponseModel profileModelResponse =
            SignedInUserResponseModel.fromJson(responseJson);

        if (response.statusCode == 200) {
          if (profileModelResponse.status!) {
            return Right(profileModelResponse);
          } else {
            return Left(Failure(0, profileModelResponse.message!, false));
          }
        } else if (response.statusCode == 401) {
          return (Left(AppExceptions.handle(
            isRefreshTokenValid: true,
            int.parse(response.statusCode.toString()),
            message: profileModelResponse.message!,
            callApiAgain: UserRepository.getProfile,
          ).failure));
        } else {
          return Left(Failure(0, profileModelResponse.message!, false));
        }
      } catch (error) {
        return Left(DataSource.FromBE.getFailure(message: error.toString()));
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure(message: ''));
    }
  }

  static Future<Either<Failure, SignedInUserResponseModel>> updateProfile(
      {required ProfileUpdateRequestModel profileUpdateRequestModel}) async {
    if (await RepositoryDependencies.httpConnectionInfo.isConnected) {
      dynamic response;
      try {
        response = await UserDataServices.getProfile();
        Map<String, dynamic> responseJson = jsonDecode(response.body);
        SignedInUserResponseModel updateProfileModel =
            SignedInUserResponseModel.fromJson(responseJson);

        if (response.statusCode == 200) {
          if (updateProfileModel.status!) {
            return Right(updateProfileModel);
          } else {
            return Left(Failure(0, updateProfileModel.message!, false));
          }
        } else if (response.statusCode == 401) {
          return (Left(AppExceptions.handle(
                  int.parse(response.statusCode.toString()),
                  isRefreshTokenValid: true,
                  callApiAgain: UserRepository.updateProfile,
                  message: updateProfileModel.message!)
              .failure));
        } else {
          return Left(Failure(0, updateProfileModel.message!, false));
        }
      } catch (error) {
        return Left(DataSource.FromBE.getFailure(message: error.toString()));
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure(message: ''));
    }
  }

  static Future<Either<Failure, CommonResponseModel>> changeEmail(
      {required String email}) async {
    if (await RepositoryDependencies.httpConnectionInfo.isConnected) {
      dynamic response;
      try {
        response = await UserDataServices.changeEmail(email: email);
        Map<String, dynamic> responseJson = jsonDecode(response.body);
        CommonResponseModel changeEmailResponseModel =
            CommonResponseModel.fromJson(responseJson);

        if (response.statusCode == 200) {
          if (changeEmailResponseModel.status!) {
            return Right(changeEmailResponseModel);
          } else {
            return Left(Failure(0, changeEmailResponseModel.message!, false));
          }
        } else if (response.statusCode == 401) {
          return (Left(AppExceptions.handle(
                  int.parse(response.statusCode.toString()),
                  isRefreshTokenValid: true,
                  callApiAgain: UserRepository.changeEmail,
                  message: changeEmailResponseModel.message!)
              .failure));
        } else {
          return Left(Failure(0, changeEmailResponseModel.message!, false));
        }
      } catch (error) {
        return Left(DataSource.FromBE.getFailure(message: error.toString()));
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure(message: ''));
    }
  }

  static Future<Either<Failure, CommonResponseModel>> signOutUser() async {
    if (await RepositoryDependencies.httpConnectionInfo.isConnected) {
      dynamic response;
      try {
        response = await UserDataServices.signOutUser();
        Map<String, dynamic> responseJson = jsonDecode(response.body);
        CommonResponseModel signOutResponseModel =
            CommonResponseModel.fromJson(responseJson);
        if (response.statusCode == 200) {
          RepositoryDependencies.authenticationRecord.removeUserDataCache();
          if (signOutResponseModel.status!) {
            return Right(signOutResponseModel);
          } else {
            return Left(Failure(0, signOutResponseModel.message!, false));
          }
        } else if (response.statusCode == 401) {
          return (Left(AppExceptions.handle(
            int.parse(response.statusCode.toString()),
            isRefreshTokenValid: true,
            callApiAgain: UserRepository.signOutUser,
            message: signOutResponseModel.message!,
          ).failure));
        } else {
          return Left(Failure(0, signOutResponseModel.message!, false));
        }
      } catch (error) {
        return Left(DataSource.FromBE.getFailure(message: error.toString()));
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure(message: ''));
    }
  }

  static Future<Either<Failure, CommonResponseModel>> deleteAccount() async {
    if (await RepositoryDependencies.httpConnectionInfo.isConnected) {
      dynamic response;
      try {
        response = await UserDataServices.deleteAccount();
        Map<String, dynamic> responseJson = jsonDecode(response.body);
        CommonResponseModel deleteAccountResponseModel =
            CommonResponseModel.fromJson(responseJson);

        if (response.statusCode == 200) {
          if (deleteAccountResponseModel.status!) {
            return Right(deleteAccountResponseModel);
          } else {
            return Left(Failure(0, deleteAccountResponseModel.message!, false));
          }
        } else if (response.statusCode == 401) {
          return (Left(AppExceptions.handle(
            int.parse(response.statusCode.toString()),
            callApiAgain: UserRepository.deleteAccount,
            isRefreshTokenValid: true,
            message: deleteAccountResponseModel.message!,
          ).failure));
        } else {
          return Left(Failure(0, deleteAccountResponseModel.message!, false));
        }
      } catch (error) {
        return Left(DataSource.FromBE.getFailure(message: error.toString()));
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure(message: ''));
    }
  }

  static Future<Either<Failure, CommonResponseModel>> deletionVerification(
      {required String otp}) async {
    if (await RepositoryDependencies.httpConnectionInfo.isConnected) {
      dynamic response;
      try {
        response = await UserDataServices.deletionVerification(otp: otp);
        Map<String, dynamic> responseJson = jsonDecode(response.body);
        CommonResponseModel deletionVerificationResponseModel =
            CommonResponseModel.fromJson(responseJson);

        if (response.statusCode == 200) {
          if (deletionVerificationResponseModel.status!) {
            return Right(deletionVerificationResponseModel);
          } else {
            return Left(
                Failure(0, deletionVerificationResponseModel.message!, false));
          }
        } else if (response.statusCode == 401) {
          return (Left(AppExceptions.handle(
            int.parse(response.statusCode.toString()),
            isRefreshTokenValid: true,
            callApiAgain: UserRepository.deletionVerification,
            message: deletionVerificationResponseModel.message!,
          ).failure));
        } else {
          return Left(
              Failure(0, deletionVerificationResponseModel.message!, false));
        }
      } catch (error) {
        return Left(DataSource.FromBE.getFailure(message: error.toString()));
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure(message: ''));
    }
  }

  static Future<Either<Failure, CommonResponseModel>> changePassword(
      {required ChangePasswordRequestModel changePasswordRequestModel}) async {
    if (await RepositoryDependencies.httpConnectionInfo.isConnected) {
      dynamic response;
      try {
        response = await AuthenticationDataService.changePassword(
            changePasswordRequestModel: changePasswordRequestModel);
        Map<String, dynamic> responseJson = jsonDecode(response.body);
        CommonResponseModel changePasswordModel =
            CommonResponseModel.fromJson(responseJson);

        if (response.statusCode == 200) {
          if (changePasswordModel.status!) {
            return Right(changePasswordModel);
          } else {
            return Left(Failure(0, changePasswordModel.message!, false));
          }
        } else if (response.statusCode == 401) {
          return (Left(AppExceptions.handle(
            int.parse(response.statusCode.toString()),
            callApiAgain: UserRepository.changePassword,
            isRefreshTokenValid: true,
            message: changePasswordModel.message!,
          ).failure));
        } else {
          return Left(Failure(0, changePasswordModel.message!, false));
        }
      } catch (error) {
        return Left(DataSource.FromBE.getFailure(message: error.toString()));
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure(message: ''));
    }
  }
}
