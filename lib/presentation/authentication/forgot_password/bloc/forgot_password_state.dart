part of 'forgot_password_bloc.dart';

@freezed
class ForgotPasswordWithInitialState with _$ForgotPasswordWithInitialState {
  const factory ForgotPasswordWithInitialState({
    required String message,
    required bool isFailure,
    required bool isLoading,
    required TextEditingController emailController,
    required FocusNode emailFocusNode,
    required bool isEmailInvalid,
  }) = _ForgotPasswordWithInitialState;

  factory ForgotPasswordWithInitialState.initial() =>
      ForgotPasswordWithInitialState(
        message: '',
        isLoading: false,
        isFailure: false,

        emailController: TextEditingController(),
        emailFocusNode: FocusNode(),
        isEmailInvalid: false,
      );
}
