part of 'authentication_bloc.dart';

@freezed
class AuthenticationWithInitialState with _$AuthenticationWithInitialState {
  const factory AuthenticationWithInitialState({
    required String message,
    required bool isPasswordVisible,
    required bool isConfirmPasswordVisible,
    required bool isCurrentPasswordVisible,
    required bool isFailure,
    required bool isRefresh,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required TextEditingController firstNameController,
    required TextEditingController lastNameController,
    required TextEditingController confirmPasswordController,
    required TextEditingController currentPasswordController,
    required FocusNode confirmPasswordFocusNode,
    required FocusNode emailFocusNode,
    required FocusNode passwordFocusNode,
    required FocusNode firstNameFocusNode,
    required FocusNode lastNameFocusNode,
    required FocusNode currentPasswordFocusNode,
    required bool isEmailInvalid,
    required bool isFirstNameInvalid,
    required bool isLastNameInvalid,
    required bool isPasswordInvalid,
    required bool isConfirmPasswordInvalid,
    required bool isFullNameInvalid,
    required bool isCurrentPasswordInvalid,
    required bool isChecked,
    required bool isLoading,
    required bool isPasswordFieldCorrectlyFilled,
    required bool hasLowerChar,
    required bool hasUpperChar,
    required bool hasDigit,
    required bool hasSpecialChar,
    required bool hasMinChar,
    required bool isSociallySignedIn,
    required SignedInUserData? signInData,
    required bool isPasswordFieldTapped,
  }) = _AuthenticationWithInitialState;

  factory AuthenticationWithInitialState.initial() =>
      AuthenticationWithInitialState(
        message: '',
        isPasswordVisible: false,
        isSociallySignedIn: false,
        isConfirmPasswordVisible: false,
        isConfirmPasswordInvalid: false,
        isRefresh: false,
        isFullNameInvalid: false,
        firstNameController: TextEditingController(),
        lastNameController: TextEditingController(),
        currentPasswordController: TextEditingController(),
        firstNameFocusNode: FocusNode(),
        lastNameFocusNode: FocusNode(),
        currentPasswordFocusNode: FocusNode(),
        isFirstNameInvalid: false,
        isLastNameInvalid: false,
        isFailure: false,
        isCurrentPasswordVisible: false,
        emailController: TextEditingController(),
        emailFocusNode: FocusNode(),
        isEmailInvalid: false,
        isPasswordInvalid: false,
        isPasswordFieldCorrectlyFilled: true,
        isPasswordFieldTapped: false,
        isCurrentPasswordInvalid: false,
        isChecked: false,
        isLoading: false,
        hasLowerChar: false,
        hasUpperChar: false,
        hasDigit: false,
        hasSpecialChar: false,
        hasMinChar: false,
        confirmPasswordController: TextEditingController(),
        confirmPasswordFocusNode: FocusNode(),
        passwordController: TextEditingController(),
        passwordFocusNode: FocusNode(),
        signInData: null,
      );
}