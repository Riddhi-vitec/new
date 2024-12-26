import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../imports/common.dart';

import '../../imports/data.dart';


class CardListRepository{
  static  Future<Either<Failure, List<PaymentCardModel>>> fetchCardList() async {
    if (await RepositoryDependencies.httpConnectionInfo.isConnected) {
      try {
        final response = await CardListDataService.fetchCardList();

        List<dynamic> responseJson = jsonDecode(response);
        List<PaymentCardModel> stripeCardList =
            responseJson.map((json) => PaymentCardModel.fromJson(json)).toList();

        return Right(stripeCardList);
      } catch (error) {

        return Left(DataSource.FromBE.getFailure(message: error.toString()));

      }
    } else {
      return Left(
        DataSource.NO_INTERNET_CONNECTION.getFailure(message: ''),
      );
    }
  }
}