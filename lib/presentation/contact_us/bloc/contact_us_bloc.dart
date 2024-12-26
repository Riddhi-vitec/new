import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl_phone_field/countries.dart';

import '../../../di/di.dart';
import '../../../imports/common.dart';

import '../../../imports/services.dart';
import '../../../imports/usecase.dart';
import 'contact_us_handlers.dart';


part 'contact_us_event.dart';

part 'contact_us_state.dart';

part 'contact_us_bloc.freezed.dart';

class ContactUsBloc extends Bloc<ContactUsEvent, ContactUsWithInitialState> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ContactUsUseCase contactUsUseCase;
  UserData userData = instance<UserData>();

  ContactUsBloc(this.contactUsUseCase)
      : super(ContactUsWithInitialState.initial()) {
    on<TriggerContactUs>(_onTriggerContactUs);
    on<TriggerContactUsFirstNameCheck>(_onTriggerContactUsFirstNameCheck);
    on<TriggerContactUsPageRefresh>(_onTriggerContactUsPageRefresh);
    on<TriggerContactUsLastNameCheck>(_onTriggerContactUsLastNameCheck);
    on<TriggerOnChangeContactUs>(_onTriggerOnChangeContactUs);
    on<TriggerContactUsMobileNumberCheck>(_onTriggerContactUsMobileNumberCheck);
    on<TriggerContactUsEmailCheck>(_onTriggerContactUsEmailCheck);
    on<TriggerContactUsMessageCheck>(_onTriggerContactUsMessageCheck);
    on<TriggerRequestFocusForTextFieldWithChar>(
        _onTriggerRequestFocusForTextFieldWithChar);
  }

  FutureOr<void> _onTriggerContactUs(
      TriggerContactUs event, Emitter<ContactUsWithInitialState> emit) async {
    final userId = await userData.getUserId();
    if (formKey.currentState!.validate()) {
      await handleContactUsSubmitButtonEvent(
        event: event,
        emit: emit,
        state: state,
        contactUsUseCase: contactUsUseCase,
        userId: userId,
      );
    }
  }

  FutureOr<void> _onTriggerContactUsFirstNameCheck(
      TriggerContactUsFirstNameCheck event,
      Emitter<ContactUsWithInitialState> emit) {
    handleContactUsNameCheck(textFieldVariant: TextFieldVariant.firstName,name: event.firstName, emit: emit, state: state);
  }

  FutureOr<void> _onTriggerContactUsLastNameCheck(
      TriggerContactUsLastNameCheck event,
      Emitter<ContactUsWithInitialState> emit) {
    handleContactUsNameCheck(textFieldVariant: TextFieldVariant.lastName,name: event.lastName, emit: emit, state: state);
  }

  FutureOr<void> _onTriggerContactUsMobileNumberCheck(
      TriggerContactUsMobileNumberCheck event,
      Emitter<ContactUsWithInitialState> emit) {
    emit(state.copyWith(
      message: '',
      isFailure: false,
    ));
    String? validationResult = validateMobileNumber(
        value: event.mobileNumber.trim().toLowerCase(),
        length: event.minLength);

    if (shouldTriggerContactUsEvent(event: event, validationResult: validationResult)) {
      add(TriggerContactUs(
        firstName: event.firstName,
        lastName: event.lastName,
        email: event.email,
        message: event.message,
        code: event.code,
        number: event.mobileNumber,
      ));
    } else {
      formKey.currentState!.validate();
      emit(
        state.copyWith(
          message: '',
          isFailure: false,
          hasFocusMessageField: false,
          hasFocusMobileNumberField: false,
          minLength: event.minLength,
          invalidMobileNumberError: validationResult,
          isMobileNumberInvalid: validationResult == null ? false : true,
        ),
      );
    }
  }

  FutureOr<void> _onTriggerContactUsMessageCheck(
      TriggerContactUsMessageCheck event,
      Emitter<ContactUsWithInitialState> emit) {
    String? validationResult =
        validateMessage(event.message.trim().toLowerCase());
    emit(state.copyWith(
        message: '',
        isFailure: false,
        hasFocusMessageField: false,
        hasFocusMobileNumberField: false,
        invalidMessageError: validationResult,
        isMessageInvalid: validationResult == null ? false : true));
  }

  FutureOr<void> _onTriggerContactUsEmailCheck(TriggerContactUsEmailCheck event,
      Emitter<ContactUsWithInitialState> emit) {
    String? validationResult = validateEmail(event.email.trim().toLowerCase());
    emit(state.copyWith(
        message: '',
        isFailure: false,
        hasFocusMessageField: false,
        hasFocusMobileNumberField: false,
        invalidMessageError: validationResult,
        isEmailInvalid: validationResult == null ? false : true));
  }

  FutureOr<void> _onTriggerContactUsPageRefresh(
      TriggerContactUsPageRefresh event,
      Emitter<ContactUsWithInitialState> emit) {
    formKey = GlobalKey<FormState>();
    emit(ContactUsWithInitialState.initial());
  }

  FutureOr<void> _onTriggerRequestFocusForTextFieldWithChar(
      TriggerRequestFocusForTextFieldWithChar event,
      Emitter<ContactUsWithInitialState> emit) {
    if (event.isPhone == null) {
      emit(state.copyWith(
        hasFocusMessageField: false,
        hasFocusMobileNumberField: false,
      ));
    } else {
      if (event.isPhone!) {
        emit(state.copyWith(
          hasFocusMessageField: false,
          hasFocusMobileNumberField: true,
        ));
      } else {
        emit(state.copyWith(
          hasFocusMessageField: true,
          hasFocusMobileNumberField: false,
        ));
      }
    }
  }

  FutureOr<void> _onTriggerOnChangeContactUs(
      TriggerOnChangeContactUs event, Emitter<ContactUsWithInitialState> emit) {
    int minLength =
        countries.firstWhere((element) => event.code == element.code).minLength;
    emit(
      state.copyWith(
          message: '',
          isFailure: false,
          hasFocusMessageField: false,
          hasFocusMobileNumberField: false,
          minLength: minLength,
          code: event.code),
    );
  }
}
