

import 'package:dartz/dartz.dart';

import '../imports/common.dart';
import '../imports/data.dart';
import 'base_usecase.dart';

class ChangeEmailUseCase extends BaseUseCase<String, CommonResponseModel> {
  @override
  Future<Either<Failure, CommonResponseModel>> execute(String input) {
    return UserRepository.changeEmail(email: input);
  }
}