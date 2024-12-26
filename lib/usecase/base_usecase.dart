

import 'package:dartz/dartz.dart';

import '../imports/common.dart';



abstract class BaseUseCase<In, Out> {
  Future<Either<Failure, Out>> execute(In input);
}
