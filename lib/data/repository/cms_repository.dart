import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../imports/common.dart';
import '../../imports/data.dart';
class CmsRepository{
  static Future<Either<Failure, LegalsResponseModel>> getCms() async {
    if (await RepositoryDependencies.httpConnectionInfo.isConnected) {
      dynamic response;
      try {
        response = await UserDataServices.getCms();
        Map<String, dynamic> responseJson = jsonDecode(response.body);
        LegalsResponseModel cmsResponseModel =
        LegalsResponseModel.fromJson(responseJson);

        if (response.statusCode == 200) {
          if (cmsResponseModel.status!) {
            return Right(cmsResponseModel);
          } else {
            return Left(Failure(0, cmsResponseModel.message!, false));
          }
        } else if (response.statusCode == 401) {
          return (Left(AppExceptions.handle(
              int.parse(response.statusCode.toString()),
              isRefreshTokenValid: true,
              callApiAgain: CmsRepository.getCms,
              message: cmsResponseModel.message!)
              .failure));
        } else {
          return Left(Failure(0, cmsResponseModel.message!, false));
        }
      } catch (error) {
        return Left(DataSource.FromBE.getFailure(message: error.toString()));
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure(message: ''));
    }
  }
}