import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bloc/bloc.dart';

import 'package:template_flutter_mvvm_repo_bloc/imports/services.dart';

import '../../../../di/di.dart';
import '../../../../imports/common.dart';
import '../../../../imports/usecase.dart';
import 'edit_profile_handlers.dart';

part 'edit_profile_event.dart';

part 'edit_profile_state.dart';

part 'edit_profile_bloc.freezed.dart';

class EditProfileBloc
    extends Bloc<EditProfileEvent, EditProfileWithInitialState> {
  UserData userData = instance<UserData>();
  final EditProfileUseCase editProfileUseCase;
  final ChangeEmailUseCase changeEmailUseCase;
  File? fileImage;
  String email = '';

  EditProfileBloc(this.editProfileUseCase, this.changeEmailUseCase)
      : super(EditProfileWithInitialState.initial()) {
    on<TriggerFillUpFieldsEvent>(_onTriggerFillUpFieldsEvent);
    on<TriggerImagePickerEvent>(_onTriggerImagePickerEvent);
    on<TriggerFirstNameValidation>(_onTriggerFirstNameValidation);
    on<TriggerLastNameValidation>(_onTriggerLastNameValidation);
    on<TriggerUpdateBirthday>(_onTriggerUpdateBirthday);
    on<TriggerValidateBirthday>(_onTriggerValidateBirthday);
    on<TriggerOnChangeMobileNumber>(_onTriggerOnChangeMobileNumber);
    on<TriggerMobileNumberValidation>(_onTriggerMobileNumberValidation);
    on<TriggerFocusFields>(_onTriggerFocusFields);
    on<TriggerAddressValidation>(_onTriggerAddressValidation);
    on<TriggerUpdateProfile>(_onTriggerUpdateProfile);
    on<TriggerEmailValidation>(_onTriggerEmailValidation);
    on<TriggerChangeEmailEvent>(_onTriggerChangeEmailEvent);
    on<TriggerGetUserEmail>(_onTriggerGetUserEmail);
  }

  FutureOr<void> _onTriggerFillUpFieldsEvent(TriggerFillUpFieldsEvent event,
      Emitter<EditProfileWithInitialState> emit) async {
    handleFillUpFieldsEvent(

         email: email, emit: emit, state: state);
  }

  FutureOr<void> _onTriggerGetUserEmail(TriggerGetUserEmail event,
      Emitter<EditProfileWithInitialState> emit) async {
    handleUserEmailRetrieval(
        userData: userData, emit: emit, email: email, state: state);
  }

  FutureOr<void> _onTriggerImagePickerEvent(TriggerImagePickerEvent event,
      Emitter<EditProfileWithInitialState> emit) async {
   await handleImagePickerEvent(
        event: event, emit: emit, state: state, fileImage: fileImage);
  }

  FutureOr<void> _onTriggerFirstNameValidation(TriggerFirstNameValidation event,
      Emitter<EditProfileWithInitialState> emit) {
    handleNameValidation(
        isFirstName: true, name: event.firstName, emit: emit, state: state);
  }

  FutureOr<void> _onTriggerLastNameValidation(TriggerLastNameValidation event,
      Emitter<EditProfileWithInitialState> emit) {
    handleNameValidation(
        isFirstName: false, name: event.lastName, emit: emit, state: state);
  }

  FutureOr<void> _onTriggerUpdateBirthday(TriggerUpdateBirthday event,
      Emitter<EditProfileWithInitialState> emit) async {
   await handleBirthdayUpdate(event: event, emit: emit, state: state);
  }

  FutureOr<void> _onTriggerValidateBirthday(TriggerValidateBirthday event,
      Emitter<EditProfileWithInitialState> emit) {
    handleBirthdayValidation(event: event, emit: emit, state: state);
  }

  FutureOr<void> _onTriggerOnChangeMobileNumber(
      TriggerOnChangeMobileNumber event,
      Emitter<EditProfileWithInitialState> emit) {
    handleMobileNumberChange(event: event, emit: emit, state: state);
  }

  FutureOr<void> _onTriggerMobileNumberValidation(
      TriggerMobileNumberValidation event,
      Emitter<EditProfileWithInitialState> emit) {
    var validationResult =
        handleMobileNumberValidation(event: event, emit: emit, state: state);

    if (shouldHandleUpdateProfile(
        event: event, validationResult: validationResult)) {
      add(TriggerUpdateProfile(
        firstName: event.firstName,
        lastName: event.lastName,
        address: event.address,
        mobileNumber: event.mobileNumber,
        mobileCode: event.code,
        imageFile: fileImage,
        birthday: event.birthday,
      ));
    } else {
      handleInvalidMobileNumber(
          emit: emit,
          formKeyForScaffold: event.formKeyForScaffold,
          minLength: event.minLength,
          validationResult: validationResult,
          state: state);
    }
  }

  FutureOr<void> _onTriggerAddressValidation(TriggerAddressValidation event,
      Emitter<EditProfileWithInitialState> emit) {
    handleAddressValidation(event: event, emit: emit, state: state);
  }

  FutureOr<void> _onTriggerFocusFields(
      TriggerFocusFields event, Emitter<EditProfileWithInitialState> emit) {
    emit(state.copyWith(hasFocusMobileNumberField: event.hasMobileFieldFocus));
  }

  FutureOr<void> _onTriggerEmailValidation(
      TriggerEmailValidation event, Emitter<EditProfileWithInitialState> emit) {
    handleEmailValidation(email: event.email, emit: emit, state: state);
  }

  FutureOr<void> _onTriggerUpdateProfile(TriggerUpdateProfile event,
      Emitter<EditProfileWithInitialState> emit) async {
    handleProfileUpdate(
        event: event,
        emit: emit,
        state: state,
        editProfileUseCase: editProfileUseCase);
  }

  FutureOr<void> _onTriggerChangeEmailEvent(TriggerChangeEmailEvent event,
      Emitter<EditProfileWithInitialState> emit) async {
    if (event.isForValidation) {
      handleEmailValidation(email: event.email, emit: emit, state: state);
    } else {
      emit(state.copyWith(
          message: '', isFailure: false, isBottomSheetLoading: true));
      try {
        final response = await changeEmailUseCase.execute(email);
        response.fold((failure) {
          handleChangeEmailFailure(failure: failure, emit: emit, state: state);
        }, (success) {
          handleChangeEmailSuccess(success: success, emit: emit, state: state);
        });
      } catch (e) {
        emit(state.copyWith(
            isFailure: true,
            isBottomSheetLoading: false,
            message: e.toString()));
      }
    }
  }
}
