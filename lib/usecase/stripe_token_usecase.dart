import 'package:dartz/dartz.dart';
import 'package:template_flutter_mvvm_repo_bloc/data/repository/stripe_token_repository.dart';

import '../data/models/api_response_models/payment_card_model.dart';

import '../imports/common.dart';
import 'base_usecase.dart';

class StripeTokenUseCase
    extends BaseUseCase<StripeTokenUseCaseInput, PaymentCardModel> {
  final StripeTokenRepository _stripeTokenRepository;

  StripeTokenUseCase(this._stripeTokenRepository);

  @override
  Future<Either<Failure, PaymentCardModel>> execute(
      StripeTokenUseCaseInput input) {
    return _stripeTokenRepository.createStripeToken(StripeTokenUseCaseInput(
        cardNumber: input.cardNumber,
        cardHolderName: input.cardHolderName,
        expiryMonth: input.expiryMonth,
        expiryYear: input.expiryYear,
        cvc: input.cvc));
  }
}

class StripeTokenUseCaseInput {
  final String cardNumber;
  final String cardHolderName;
  final String expiryMonth;
  final String expiryYear;
  final String cvc;

  StripeTokenUseCaseInput(
      {required this.cardNumber,
        required this.cardHolderName,
        required this.expiryMonth,
        required this.expiryYear,
        required this.cvc});
}