import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../imports/common.dart';

import '../../di/di.dart';
import '../../imports/services.dart';
import '../../imports/usecase.dart';
import '../../imports/data.dart';


class StripeTokenRepository {
  final HttpConnectionInfoServices _httpConnectionInfo =
      instance<HttpConnectionInfoServices>();
  final StripeTokenDataService _stripeTokenDataService =
      instance<StripeTokenDataService>();

  Future<Either<Failure, PaymentCardModel>> createStripeToken(
      StripeTokenUseCaseInput input) async {
    dynamic response;
    if (await _httpConnectionInfo.isConnected) {
      try {
        response = await _stripeTokenDataService.createStripeToken(input);
        PaymentCardModel stripeCardModel =
            PaymentCardModel.fromJson(jsonDecode(response.body));
        if(response.statusCode == 200) {
          return Right(stripeCardModel);
        }else{
          return (Left(AppExceptions.handle(
            isRefreshTokenValid: false,
              int.parse(response.statusCode.toString()),            callApiAgain: null,
            message: ''// later
          ).failure));
        }
      } catch (error) {
        return Left(DataSource.FromBE.getFailure(message: error.toString()));
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure(message: ''));
    }
  }
}
