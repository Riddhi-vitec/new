import 'package:dartz/dartz.dart';

import '../imports/common.dart';
import '../imports/data.dart';
import 'base_usecase.dart';

class DeleteAccountUseCase extends BaseUseCase<void, CommonResponseModel> {
  @override
  Future<Either<Failure, CommonResponseModel>> execute(void input) {
    return UserRepository.deleteAccount();
  }
}