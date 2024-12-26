import 'package:bloc/bloc.dart';

import '../../../imports/common.dart';
import '../../../imports/data.dart';
import '../../../imports/usecase.dart';
import 'contact_us_bloc.dart';

Future<void> handleContactUsSubmitButtonEvent({
  required TriggerContactUs event,
  required Emitter<ContactUsWithInitialState> emit,
  required ContactUsUseCase contactUsUseCase,
  required String? userId,
  required ContactUsWithInitialState state,
}) async {
  emit(state.copyWith(message: '', isFailure: false, isLoading: true));
  try {
    final response = await contactUsUseCase.execute(ContactUsRequestModel(
      message: event.message,
      firstName: event.firstName,
      lastName: event.lastName,
      email: event.email,
      code: event.code,
      number: event.number,
      userId: userId ?? '',
    ));
    response.fold(
      (failure) =>
          _handleContactUsFailure(failure: failure, emit: emit, state: state),
      (success) =>
          _handleContactUsSuccess(success: success, emit: emit, state: state),
    );
  } catch (e) {
    emit(state.copyWith(
        message: e.toString(), isFailure: true, isLoading: false));
  }
}

_handleContactUsSuccess(
    {required CommonResponseModel success,
    required Emitter<ContactUsWithInitialState> emit,
    required ContactUsWithInitialState state}) {
  emit(state.copyWith(
      message: success.message!, isFailure: false, isLoading: false));
}

_handleContactUsFailure(
    {required Failure failure,
    required Emitter<ContactUsWithInitialState> emit,
    required ContactUsWithInitialState state}) {
  emit(state.copyWith(
      message: failure.message, isFailure: true, isLoading: false));
}

handleContactUsNameCheck(
    {required String name,
    required Emitter<ContactUsWithInitialState> emit,
      required TextFieldVariant textFieldVariant,
    required ContactUsWithInitialState state}) {
  emit(state.copyWith(
      message: '',
      isFailure: false,
      hasFocusMessageField: false,
      hasFocusMobileNumberField: false));
  String? validationResult = textFieldVariant == TextFieldVariant.firstName
      ? validateFirstName(name.trim().toLowerCase())
      :  validateLastName(name.trim().toLowerCase());

  if( textFieldVariant == TextFieldVariant.firstName) {
    emit(state.copyWith(
      isFirstNameInvalid: validationResult == null ? false : true));
  }else{
    emit(state.copyWith(
      isLastNameInvalid: validationResult == null ? false : true));
  }

}
bool shouldTriggerContactUsEvent({required TriggerContactUsMobileNumberCheck event, required String? validationResult }){
  return !event.isFirstNameValid &&
      !event.isLastNameValid &&
      !event.isEmailValid &&
      !event.isMessageValid &&
      validationResult == null;
}