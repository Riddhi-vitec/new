import 'package:dartz/dartz.dart';

import '../imports/common.dart';
import '../imports/data.dart';
import '../imports/usecase.dart';

class ReadNotificationUseCase extends BaseUseCase<String, CommonResponseModel> {
  @override
  Future<Either<Failure, CommonResponseModel>> execute(String input) {
    return NotificationRepository.readNotification(notificationID: input);
  }
}
