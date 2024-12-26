import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:template_flutter_mvvm_repo_bloc/data/models/api_response_models/notification_response_model.dart';
import 'package:template_flutter_mvvm_repo_bloc/data/remote_data_services/notification_data_service.dart';

import '../../imports/common.dart';
import '../../imports/data.dart';

class NotificationRepository {
  static Future<Either<Failure, NotificationResponseModel>>
      getNotification() async {
    if (await RepositoryDependencies.httpConnectionInfo.isConnected) {
      dynamic response;
      try {
        response = await NotificationDataService.getNotification();
        Map<String, dynamic> responseJson = jsonDecode(response.body);
        NotificationResponseModel notificationResponseModel =
            NotificationResponseModel.fromJson(responseJson);

        if (response.statusCode == 200) {
          if (notificationResponseModel.status!) {
            return Right(notificationResponseModel);
          } else {
            return Left(Failure(0, notificationResponseModel.message!, false));
          }
        }
        else if (response.statusCode == 401) {
          return (Left(AppExceptions.handle(
            int.parse(response.statusCode.toString()),
            callApiAgain: NotificationRepository.getNotification,
            isRefreshTokenValid: true,
            message: notificationResponseModel.message!,
          ).failure));
        }
        else {
          return Left(Failure(0, notificationResponseModel.message!, false));
        }
      } catch (error) {
        return Left(DataSource.FromBE.getFailure(message: error.toString()));
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure(message: ''));
    }
  }

  static Future<Either<Failure, CommonResponseModel>> readNotification(
      {required String notificationID}) async {
    if (await RepositoryDependencies.httpConnectionInfo.isConnected) {
      dynamic response;
      try {
        response = await NotificationDataService.readNotification(
            notificationID: notificationID);
        Map<String, dynamic> responseJson = jsonDecode(response.body);
        CommonResponseModel readNotificationResponseModel =
            CommonResponseModel.fromJson(responseJson);

        if (response.statusCode == 200) {
          if (readNotificationResponseModel.status!) {
            return Right(readNotificationResponseModel);
          } else {
            return Left(
                Failure(0, readNotificationResponseModel.message!, false));
          }
        }
        else if (response.statusCode == 401) {
          return (Left(AppExceptions.handle(
            int.parse(response.statusCode.toString()),
            callApiAgain: NotificationRepository.readNotification,
            isRefreshTokenValid: true,
            message: readNotificationResponseModel.message!,
          ).failure));
        }
        else {
          return Left(
              Failure(0, readNotificationResponseModel.message!, false));
        }
      } catch (error) {
        return Left(DataSource.FromBE.getFailure(message: error.toString()));
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure(message: ''));
    }
  }
}
