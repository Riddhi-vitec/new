import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../imports/common.dart';
import '../../imports/data.dart';

class ContactUsRepository{
  static Future<Either<Failure, CommonResponseModel>> contactUs(
      {required ContactUsRequestModel contactUsRequestModel}) async {
    if (await RepositoryDependencies.httpConnectionInfo.isConnected) {
      dynamic response;
      try {
        response = await UserDataServices.contactUs(
            contactUsRequestModel: contactUsRequestModel);
        Map<String, dynamic> responseJson = jsonDecode(response.body);
        CommonResponseModel contactUsResponseModel =
        CommonResponseModel.fromJson(responseJson);

        if (response.statusCode == 200) {
          if (contactUsResponseModel.status!) {
            return Right(contactUsResponseModel);
          } else {
            return Left(Failure(0, contactUsResponseModel.message!, false));
          }
        } else if (response.statusCode == 401) {
          return (Left(AppExceptions.handle(
              int.parse(response.statusCode.toString()),
              isRefreshTokenValid: true,
              callApiAgain: ContactUsRepository.contactUs,
              message: contactUsResponseModel.message!)
              .failure));
        } else {
          return Left(Failure(0, contactUsResponseModel.message!, false));
        }
      } catch (error) {
        return Left(DataSource.FromBE.getFailure(message: error.toString()));
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure(message: ''));
    }
  }
}