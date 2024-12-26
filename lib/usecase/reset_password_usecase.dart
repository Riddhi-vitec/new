import 'package:dartz/dartz.dart';
import '../imports/common.dart';
import '../imports/data.dart';
import 'base_usecase.dart';

class ResetPasswordUseCase extends BaseUseCase<ResetPasswordRequestModel, CommonResponseModel> {
  @override
  Future<Either<Failure, CommonResponseModel>> execute(ResetPasswordRequestModel input) {
    return AuthenticationRepository.resetPassword(resetPasswordRequestModel: input);
  }
}
