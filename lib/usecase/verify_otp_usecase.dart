import 'package:dartz/dartz.dart';
import '../data/models/api_response_models/signed_in_user_response_model.dart';
import '../imports/common.dart';
import '../imports/data.dart';
import 'base_usecase.dart';

class VerifyOtpUseCase extends BaseUseCase<OtpRequestModel, SignedInUserResponseModel> {
  @override
  Future<Either<Failure, SignedInUserResponseModel>> execute(OtpRequestModel input) {
    return AuthenticationRepository.
    verifyOtp(otpRequestModel: input);
  }
}