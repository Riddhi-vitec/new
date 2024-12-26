part of 'contact_us_bloc.dart';

@freezed
class ContactUsWithInitialState with _$ContactUsWithInitialState {
  const factory ContactUsWithInitialState({
    required String message,
    required bool isFailure,
    required TextEditingController firstNameController,
    required TextEditingController lastNameController,
    required TextEditingController mobileNumberController,
    required TextEditingController emailController,
    required TextEditingController messageController,
    required FocusNode firsNameFocusNode,
    required FocusNode lastNameFocusNode,
    required FocusNode mobileNumberFocusNode,
    required FocusNode emailFocusNode,
    required FocusNode messageFocusNode,
    required bool isFirstNameInvalid,
    required bool isLastNameInvalid,
    required bool isMobileNumberInvalid,
    required bool isEmailInvalid,
    required bool isMessageInvalid,
    required bool hasFocusMessageField,
    required bool hasFocusMobileNumberField,
    required bool isLoading,
    required String? invalidMessageError,
    required String? invalidMobileNumberError,
    required int minLength,
    required String code,
  }) = _ContactUsWithInitialState;

  factory ContactUsWithInitialState.initial() => ContactUsWithInitialState(
      message: '',
      isFailure: false,
      isLoading: false,
      invalidMessageError: null,
      invalidMobileNumberError: null,
      firstNameController: TextEditingController(),
      lastNameController: TextEditingController(),
      mobileNumberController: TextEditingController(),
      emailController: TextEditingController(),
      messageController: TextEditingController(),
      firsNameFocusNode: FocusNode(),
      lastNameFocusNode: FocusNode(),
      mobileNumberFocusNode: FocusNode(),
      emailFocusNode: FocusNode(),
      messageFocusNode: FocusNode(),
      isFirstNameInvalid: false,
      isLastNameInvalid: false,
      isMobileNumberInvalid: false,
      isEmailInvalid: false,
      isMessageInvalid: false,
      hasFocusMessageField: true,
      hasFocusMobileNumberField: false,
      code: '49',
      minLength: 9);
}