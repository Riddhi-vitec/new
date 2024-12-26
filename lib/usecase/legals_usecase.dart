
import 'package:dartz/dartz.dart';
import 'package:template_flutter_mvvm_repo_bloc/data/repository/cms_repository.dart';

import '../imports/common.dart';
import '../imports/data.dart';
import 'base_usecase.dart';

class LegalsUseCase extends BaseUseCase<String, LegalsResponseModel> {
  @override
  Future<Either<Failure, LegalsResponseModel>> execute(void input) {
    return CmsRepository.getCms();
  }
}