import 'package:bloc/bloc.dart';
import '../../../../imports/common.dart';
import '../../../../imports/data.dart';
import '../../../../usecase/forgot_password_usecase.dart';
import 'forgot_password_bloc.dart';

void handleEmailValidation({
 required TriggerEmailValidation event,
 required Emitter<ForgotPasswordWithInitialState> emit,
  required ForgotPasswordWithInitialState state,
}) {
  String email = event.email.trim().toLowerCase();
  String? validationResult = validateEmail(email);

  emit(state.copyWith(
    message: '',
    isFailure: false,
    isEmailInvalid: validationResult != null,
  ));
}

Future<void> handleSubmitEmail({
  required TriggerSubmitEmail event,
  required Emitter<ForgotPasswordWithInitialState> emit,
  required ForgotPasswordUseCase forgotPasswordUseCase,
  required ForgotPasswordWithInitialState state,
}) async {
  emit(state.copyWith(message: '', isFailure: false, isLoading: true));

  try {
    final response = await forgotPasswordUseCase.execute(event.email.trim().toLowerCase());

    response.fold(
          (failure) =>

           handleForgotPasswordFailure(failure: failure, state: state,emit:  emit),
          (success) => handleForgotPasswordSuccess(state: state, emit: emit, success: success)
    );
  } catch (e) {
    emit(state.copyWith(
      isFailure: true,
      message: e.toString(),
      isLoading: false,
    ));
  }
}

handleForgotPasswordSuccess({required ForgotPasswordWithInitialState state, required Emitter<ForgotPasswordWithInitialState> emit, required CommonResponseModel success}) {
  emit(state.copyWith(
    message: success.message!,
    isFailure: false,
    isLoading: false,
  ));
}

handleForgotPasswordFailure({required Failure failure, required ForgotPasswordWithInitialState state, required Emitter<ForgotPasswordWithInitialState> emit}) {
  emit(state.copyWith(
    isFailure: true,
    message: failure.message,
    isLoading: false,
  ));
}
