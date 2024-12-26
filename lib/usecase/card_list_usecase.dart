import 'package:dartz/dartz.dart';
import '../imports/common.dart';
import '../imports/data.dart';
import 'base_usecase.dart';

class CardListUseCase extends BaseUseCase<String, List<PaymentCardModel>> {
  @override
  Future<Either<Failure, List<PaymentCardModel>>> execute(void input) {
    return CardListRepository.fetchCardList();
  }
}
