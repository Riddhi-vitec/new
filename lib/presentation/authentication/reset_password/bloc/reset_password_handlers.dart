import 'package:bloc/bloc.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/functions/exception_handler.dart';
import 'package:template_flutter_mvvm_repo_bloc/presentation/authentication/reset_password/bloc/reset_password_bloc.dart';

import '../../../../imports/data.dart';
import '../../../../usecase/reset_password_usecase.dart';

Future<void> handleResetPasswordSubmission({required TriggerResetPasswordSubmission event, required Emitter<ResetPasswordWithInitialState> emit, required ResetPasswordWithInitialState state, required ResetPasswordUseCase resetPasswordUseCase}) async {
  emit(state.copyWith(isLoading: true, message: '', isFailure: false));

  try {
    final response =
    await resetPasswordUseCase.execute(ResetPasswordRequestModel(
      newPassword: event.newPassword,
      resetPasswordToken: event.tokenExtractedFromEmail,
    ));
    response.fold(
            (failure) =>_handleResetPasswordFailure(failure: failure, emit: emit, state: state),
            (success) => _handleResetPasswordSuccess(success: success, emit: emit, state: state));
  } catch (e) {
    emit(state.copyWith(
        message: e.toString(), isFailure: true, isLoading: false));
  }
}

_handleResetPasswordSuccess({required CommonResponseModel success, required Emitter<ResetPasswordWithInitialState> emit, required ResetPasswordWithInitialState state}) {
  emit(state.copyWith(
    message: success.message!,
    isFailure: false,
  ));
}

_handleResetPasswordFailure({required Failure failure, required Emitter<ResetPasswordWithInitialState> emit, required ResetPasswordWithInitialState state}) {
  emit(state.copyWith(
      message: failure.message, isFailure: true, isLoading: false));
}