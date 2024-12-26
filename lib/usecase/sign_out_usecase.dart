import 'package:dartz/dartz.dart';
import 'package:template_flutter_mvvm_repo_bloc/data/repository/user_repository.dart';
import '../imports/common.dart';
import '../imports/data.dart';
import 'base_usecase.dart';

class SignOutUseCase extends BaseUseCase<void, CommonResponseModel> {
  @override
  Future<Either<Failure, CommonResponseModel>> execute(void input) {
    return UserRepository.signOutUser();
  }
}
