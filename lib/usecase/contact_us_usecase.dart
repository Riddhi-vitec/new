import 'package:dartz/dartz.dart';
import 'package:template_flutter_mvvm_repo_bloc/data/repository/contact_us_repository.dart';
import '../imports/common.dart';
import '../imports/data.dart';
import 'base_usecase.dart';


class ContactUsUseCase extends BaseUseCase<ContactUsRequestModel, CommonResponseModel> {
  @override
  Future<Either<Failure, CommonResponseModel>> execute(ContactUsRequestModel input) {
    return ContactUsRepository.contactUs( contactUsRequestModel: input);
  }
}