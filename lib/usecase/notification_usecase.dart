import 'package:dartz/dartz.dart';
import 'package:template_flutter_mvvm_repo_bloc/data/models/api_response_models/notification_response_model.dart';
import 'package:template_flutter_mvvm_repo_bloc/data/repository/notification_repository.dart';

import '../imports/common.dart';
import 'base_usecase.dart';

class NotificationUseCase extends BaseUseCase<void, NotificationResponseModel> {
  @override
  Future<Either<Failure, NotificationResponseModel>> execute(void input) {
    return NotificationRepository.getNotification();
  }
}