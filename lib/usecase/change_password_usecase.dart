import 'package:dartz/dartz.dart';

import '../imports/common.dart';
import '../imports/data.dart';
import 'base_usecase.dart';

class ChangePasswordUseCase extends BaseUseCase<ChangePasswordRequestModel, CommonResponseModel> {
  @override
  Future<Either<Failure, CommonResponseModel>> execute(ChangePasswordRequestModel input) {
    return UserRepository.changePassword(changePasswordRequestModel: input);
  }
}
