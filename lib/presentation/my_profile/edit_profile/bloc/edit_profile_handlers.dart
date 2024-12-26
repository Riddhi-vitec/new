import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/countries.dart';

import '../../../../imports/common.dart';
import '../../../../imports/data.dart';
import '../../../../imports/services.dart';
import '../../../../imports/usecase.dart';
import '../../../../root_app.dart';
import 'edit_profile_bloc.dart';

// handle fill up fields event
void handleFillUpFieldsEvent(
    {
    required String email,
    required Emitter<EditProfileWithInitialState> emit,
    required EditProfileWithInitialState state}) async {

  SignedInUserData signedInUserData = await extractUserDataFromCache();
  email = signedInUserData.email ?? '';
  emit(state.copyWith(
    imageUrl: signedInUserData.profile,
    formKeyForBottomSheet: state.formKeyForBottomSheet,
    formKeyForScaffold: state.formKeyForScaffold,
    emailController: TextEditingController(text: email),
    firstNameController: TextEditingController(text: signedInUserData.fullName),
    lastNameController: TextEditingController(text: signedInUserData.fullName),
    mobileNumberController:
        TextEditingController(text: signedInUserData.mobile!.number ?? ''),
  ));
}

// handle fetching user email in bottom sheet
void handleUserEmailRetrieval(
    {required UserData userData,
    required Emitter<EditProfileWithInitialState> emit,
    required String email,
    required EditProfileWithInitialState state}) async {
  emit(state.copyWith(isLoading: true, message: '', isFailure: false));
  String userDataInString = await userData.getUserInfo() ?? '';
  Map<String, dynamic> userDataInMap = jsonDecode(userDataInString);

  SignedInUserData signedInUserData = SignedInUserData.fromJson(userDataInMap);
  email = signedInUserData.email ?? '';

  emit(state.copyWith(
    isLoading: false,
    emailController: TextEditingController(text: email),
  ));
}

//handle picking images from gallery or camera

Future<void> handleImagePickerEvent(
    {required TriggerImagePickerEvent event,
    required Emitter<EditProfileWithInitialState> emit,
    required EditProfileWithInitialState state,
    required File? fileImage}) async {
  XFile? image = await getImage(isFromCamera: event.isFromCamera);
  if (image != null) {
    fileImage = File(image.path);
    emit(state.copyWith(
      fileImage: fileImage,
    ));
  }
}

// handle name validation (firstName and lastName)

 handleNameValidation(
    {required bool isFirstName,
      required String name,
      required Emitter<EditProfileWithInitialState> emit,
      required EditProfileWithInitialState state}) {
  emit(state.copyWith(
    message: '',
    isFailure: false,
    hasFocusMobileNumberField: false,
  ));
  String? validationResult = isFirstName
      ? validateFirstName(name.trim().toLowerCase())
      : validateLastName(name.trim().toLowerCase());
  if(isFirstName) {
    emit(state.copyWith(
        isFirstNameInvalid: validationResult == null ? false : true));
  }else {
    emit(state.copyWith(
        isLastNameInvalid: validationResult == null ? false : true));
  }
}

//handle birthday calendar update
Future<void>  handleBirthdayUpdate(
    {required TriggerUpdateBirthday event,
    required Emitter<EditProfileWithInitialState> emit,
    required EditProfileWithInitialState state}) async {
  try {
    DateTime? selectedDate = await showDatePicker(
      context: event.context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return buildCalendarTheme(context, child);
      },
    );
    if (selectedDate != null) {
      DateFormat formatter = DateFormat('M/d/yyyy');
      String formattedDate = formatter.format(selectedDate);
      emit(state.copyWith(
        isLoading: false,
        hasFocusMobileNumberField: false,
        birthDayController: TextEditingController(text: formattedDate),
      ));
    }
  }catch(e){
    emit(state.copyWith(
      isLoading: false,
      isBirthdayInvalid: true,
      hasFocusMobileNumberField: false,
    ));
  }

}
// handle birthday validation
void handleBirthdayValidation(
    {required TriggerValidateBirthday event,
    required Emitter<EditProfileWithInitialState> emit,
    required EditProfileWithInitialState state}) {
  String? validationResult = validateBirthday(event.value.toString());
  emit(
    state.copyWith(
        hasFocusMobileNumberField: false,
        isBirthdayInvalid: validationResult == null ? false : true,
        isLoading: false),
  );
}

//handle mobile number changes
void handleMobileNumberChange(
    {required TriggerOnChangeMobileNumber event,
    required Emitter<EditProfileWithInitialState> emit,
    required EditProfileWithInitialState state}) {
  int minLength =
      countries.firstWhere((element) => event.code == element.code).minLength;
  emit(
    state.copyWith(
        message: '',
        isFailure: false,
        hasFocusMobileNumberField: false,
        minLength: minLength,
        code: event.code),
  );
}
// handle address validation
void handleAddressValidation(
    {required TriggerAddressValidation event,
    required Emitter<EditProfileWithInitialState> emit,
    required EditProfileWithInitialState state}) {
  String? validationResult = validateAddress(event.address.trim());
  emit(state.copyWith(
      message: '',
      isFailure: false,
      hasFocusMobileNumberField: false,
      isAddressInvalid: validationResult == null ? false : true));
}

// handle change email  success
void handleChangeEmailSuccess(
    {required CommonResponseModel success,
      required Emitter<EditProfileWithInitialState> emit,
      required EditProfileWithInitialState state}) {
  emit(state.copyWith(
      isFailure: false,
      isBottomSheetLoading: false,
      message: success.message!));
  Navigator.pushNamedAndRemoveUntil(navigatorKey.currentContext!,
      RouteName.routeVerifyOtp, (route) => false);
}
// handle change email failure
void handleChangeEmailFailure(
    {required Failure failure,
      required Emitter<EditProfileWithInitialState> emit,
      required  EditProfileWithInitialState state}) {
  emit(state.copyWith(
      isFailure: true,
      isBottomSheetLoading: false,
      message: failure.message));
  Navigator.pop(navigatorKey.currentContext!);
}

// handle mobile number validation
String? handleMobileNumberValidation(
    {required TriggerMobileNumberValidation event,
      required Emitter<EditProfileWithInitialState> emit,
      required EditProfileWithInitialState state}) {
  emit(state.copyWith(
    message: '',
    isFailure: false,
  ));
  String? validationResult = validateMobileNumber(
      value: event.mobileNumber.trim().toLowerCase(),
      length: event.minLength);
  return validationResult;
}

// handle invalid mobile number
void handleInvalidMobileNumber(
    {required Emitter<EditProfileWithInitialState> emit,
      required GlobalKey<FormState> formKeyForScaffold,
      required int minLength,
      required String? validationResult,
      required EditProfileWithInitialState state}) {
  formKeyForScaffold.currentState!.validate();
  emit(
    state.copyWith(
      message: '',
      isFailure: false,
      hasFocusMobileNumberField: false,
      minLength: minLength,
      invalidMobileNumberError: validationResult,
      isMobileNumberInvalid: validationResult == null ? false : true,
    ),
  );
}

// boolean to check if update profile should be handled
bool shouldHandleUpdateProfile(
    {required TriggerMobileNumberValidation event, required String? validationResult}) {
  return !event.isFirstNameValid &&
      !event.isLastNameValid &&
      !event.isAddressValid &&
      validationResult == null;
}

// handle email validation
void handleEmailValidation(
    {required String email,
      required Emitter<EditProfileWithInitialState> emit,
      required EditProfileWithInitialState state}) {
  email = email.toLowerCase().toString();
  handleEmailValidation(email: email, emit: emit, state: state);
  String? validationResult = validateEmail(email.toLowerCase().trim());
  emit(state.copyWith(
      message: '',
      isFailure: false,
      isLoading: false,
      hasFocusMobileNumberField: false,
      isEmailInvalid: validationResult == null ? false : true));
}

//handle profile update
void handleProfileUpdate(
    {required  event,
      required Emitter<EditProfileWithInitialState> emit,
      required EditProfileWithInitialState state,
      required EditProfileUseCase editProfileUseCase}) async {
  emit(state.copyWith(isLoading: true, message: '', isFailure: false));
  try {
    final response = await editProfileUseCase.execute(ProfileUpdateRequestModel(
        firstName: event.firstName,
        lastName: event.lastName,
        birthday: event.birthday,
        countryCode: event.mobileCode,
        mobileNumber: event.mobileNumber,
        address: event.address,
        profileImage: event.imageFile));
    response.fold((failure) => handleUpdateProfileFailure(failure: failure, emit: emit, state: state),
            (success) => handleUpdateProfileSuccess(success: success, emit: emit, state: state));
  } catch (e) {
    emit(state.copyWith(
        isFailure: true, isLoading: false, message: e.toString()));
  }
}

// handle update profile success
handleUpdateProfileSuccess(
    {required SignedInUserResponseModel success,
      required Emitter<EditProfileWithInitialState> emit,
      required EditProfileWithInitialState state}) {
  emit(state.copyWith(
      isFailure: false, isLoading: false, message: success.message!));
}

// handle update profile failure
handleUpdateProfileFailure(
    {required Failure failure,
      required Emitter<EditProfileWithInitialState> emit,
      required EditProfileWithInitialState state}) {
  emit(state.copyWith(
      isFailure: true, isLoading: false, message: failure.message));
}
