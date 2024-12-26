part of 'reset_password_bloc.dart';



@freezed
class ResetPasswordWithInitialState with _$ResetPasswordWithInitialState {
  const factory ResetPasswordWithInitialState({
    required String message,
    required bool isFailure,
    required bool isLoading,
    required TextEditingController newPasswordController,
    required FocusNode newPasswordFocus,
    required TextEditingController confirmPasswordController,
    required FocusNode confirmPasswordFocus,
    required bool isPasswordFieldIncorrectlyFilled,
    required bool hasLowerChar,
    required bool hasUpperChar,
    required bool hasDigit,
    required bool hasSpecialChar,
    required bool hasMinChar,
    required bool isPasswordFieldTapped,
    required bool isNewPasswordInvalid,
    required bool isConfirmPasswordInvalid,
    required bool isNewPasswordVisible,
    required bool isConfirmPasswordVisible,
  }) = _ResetPasswordWithInitialState;

  factory ResetPasswordWithInitialState.initial() =>
      ResetPasswordWithInitialState(
        message: '',
        isLoading: false,
        isFailure: false,
        isConfirmPasswordInvalid: false,
        isNewPasswordInvalid: false,
        isConfirmPasswordVisible: false,
        isNewPasswordVisible: false,
        confirmPasswordController: TextEditingController(),
        confirmPasswordFocus: FocusNode(),
        newPasswordController: TextEditingController(),
        newPasswordFocus: FocusNode(),
        hasDigit: false,
        hasLowerChar: false,
        hasMinChar: false,
        isPasswordFieldIncorrectlyFilled: true,
        isPasswordFieldTapped: false,
        hasSpecialChar: false,
        hasUpperChar: false
      );
}
