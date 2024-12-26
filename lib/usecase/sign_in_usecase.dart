import 'package:dartz/dartz.dart';
import 'package:template_flutter_mvvm_repo_bloc/data/models/api_response_models/signed_in_user_response_model.dart';

import '../imports/common.dart';
import '../imports/data.dart';
import '../imports/usecase.dart';
import 'base_usecase.dart';


class SignInUseCase extends BaseUseCase<SignInRequestModel, SignedInUserResponseModel> {
  @override
  Future<Either<Failure, SignedInUserResponseModel>> execute(SignInRequestModel input) {
    return AuthenticationRepository.signIn(signInRequestModel: input);
  }
}