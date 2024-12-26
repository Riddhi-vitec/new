import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/functions/exception_handler.dart';

import '../../../../device_variables.dart';
import '../../../../imports/common.dart';
import '../../../../imports/data.dart';
import '../../../../imports/usecase.dart';
import 'otp_verification_bloc.dart';

AnimationController handleAnimationControllerCreation(
    {required TriggerAnimationInitialization event}) {
  return AnimationController(
    vsync: event.vsync,
    duration: const Duration(seconds: 60),
  )..forward();
}

String handleFullNameExtraction({required String fullName}) {
  return fullName.toString().trim();
}

String handleEmailExtraction({required String email}) {
  return email.toString().trim();
}

String handlePasswordExtraction({required String password}) {
  return password.toString().trim();
}

void handleAnimationContinuation({
  required Emitter<VerifyOtpWithInitialState> emit,
  required double animationValue,
  required VerifyOtpWithInitialState state,
}) {
  emit(state.copyWith(
    hasAnimationStarted: true,
    isLoading: false,
    otpSubmissionMessage: '',
    animationValue: animationValue,
  ));
}

void handleAnimationTerminal({
  required AnimationController animationController,
  required Emitter<VerifyOtpWithInitialState> emit,
  required double animationValue,
  required VerifyOtpWithInitialState state,
}) {
  animationController.stop();
  animationController.dispose();
  emit(state.copyWith(
    hasAnimationStarted: false,
    isLoading: false,
    otpSubmissionMessage: '',
    animationValue: animationValue,
  ));
}

void handleDigitReplace({
  required TriggerDigitReplace event,
  required Emitter<VerifyOtpWithInitialState> emit,
  required VerifyOtpWithInitialState state,
}) {
  List<TextEditingController> fields =
      List.generate(event.fields.length, (index) {
    return TextEditingController(text: event.fields[index].text);
  });

  fields[event.index].text = event.val;
  fields[event.index].text = fields[event.index].text.substring(1);
  emit(state.copyWith(
    fields: fields,
    otpSubmissionMessage: '',
  ));
}

Future<void> handleOtpSubmission(
    {required TriggerSubmitOtp event,
    required Emitter<VerifyOtpWithInitialState> emit,
    required VerifyOtpWithInitialState state,
    required VerifyOtpUseCase verifyOtpUseCase}) async {
  String otp = _handleOtpExtraction(event.fields);
  if (_shouldProcessOtpSubmission(event.fields)) {
    await _handleValidOtpSubmission(
        event: event,
        emit: emit,
        state: state,
        verifyOtpUseCase: verifyOtpUseCase,
        otp: otp);
  } else {
    _handleInvalidOtpSubmission(event: event, emit: emit, state: state);
  }
}

void _handleInvalidOtpSubmission(
    {required TriggerSubmitOtp event,
    required Emitter<VerifyOtpWithInitialState> emit,
    required VerifyOtpWithInitialState state}) {
  var fieldErrors = _handleEmptyFieldError(fields: event.fields);

  emit(state.copyWith(
    fieldErrors: fieldErrors,
    isLoading: false,
    isOTPSubmissionSuccessful: false,
    isEmptyFieldError: true,
    otpSubmissionMessage: '',
    emptyFieldError: AppStrings.textfield_addOtp_emptyField_error,
  ));
}

List<String?> _handleEmptyFieldError(
    {required List<TextEditingController> fields}) {
  List<String?> fieldErrors = List.filled(4, null);

  for (var i = 0; i < fields.length; i++) {
    if (fields[i].text.isEmpty) {
      fieldErrors[i] = AppStrings.textfield_addOtp_emptyField_error;
    }
  }

  return fieldErrors;
}

Future<void> _handleValidOtpSubmission(
    {required TriggerSubmitOtp event,
    required Emitter<VerifyOtpWithInitialState> emit,
    required VerifyOtpWithInitialState state,
    required VerifyOtpUseCase verifyOtpUseCase,
    required String otp}) async {
  final response = await verifyOtpUseCase.execute(OtpRequestModel(
    isChangeEmail: false,
    isAccountDeletion: false,
    fullName: event.fullName,
    email: event.email,
    password: event.password,
    otp: otp,
    deviceType: DeviceVariables.deviceType,
    deviceToken: await DeviceVariables.deviceToken(),
    isSocialAccountVerification: false,
    socialId: null,
    socialType: null,
  ));

  try{
  response.fold(
    (failure) {
      _handleOtpSubmissionFailure(failure: failure, emit: emit, state: state);
    },
    (success) {
      _handleOtpSubmissionSuccess(emit: emit, state: state, success: success);
    },
  );}catch(e){
    emit(state.copyWith(
      isLoading: false,
      isOTPSubmissionSuccessful: false,
      otpSubmissionMessage: e.toString(),
      isEmptyFieldError: false,
    ));
  }
}

void _handleOtpSubmissionSuccess(
    {required Emitter<VerifyOtpWithInitialState> emit,
    required VerifyOtpWithInitialState state,
    required SignedInUserResponseModel success}) {
  emit(state.copyWith(
    isLoading: false,
    isOTPSubmissionSuccessful: true,
    otpSubmissionMessage: success.message!,
    isEmptyFieldError: false,
  ));
}

void _handleOtpSubmissionFailure(
    {required Failure failure,
    required Emitter<VerifyOtpWithInitialState> emit,
    required VerifyOtpWithInitialState state}) {
  emit(state.copyWith(
    isLoading: false,
    isOTPSubmissionSuccessful: false,
    otpSubmissionMessage: failure.message,
    isEmptyFieldError: false,
  ));
}

bool _shouldProcessOtpSubmission(List<TextEditingController> fields) {
  return fields.every((element) => element.text.isNotEmpty);
}

String _handleOtpExtraction(List<TextEditingController> fields) {
  return fields.map((field) => field.text).join('');
}

Future<void> handleOtpResend({required TriggerResendOtp event, required VerifyOtpWithInitialState state, required Emitter<VerifyOtpWithInitialState> emit, required SignUpUseCase signUpUseCase}) async {


  String email = event.otpRequestModel.email;

  try {
    final response = await signUpUseCase.execute(email);
    response.fold(
      (failure) => _handleOtpResendFailure(failure: failure, emit: emit, state: state),
      (success) => _handleOtpResendSuccess(emit: emit, state: state, success: success, event: event),
    );
  } catch (e) {
    emit(state.copyWith(
      isLoading: false,
      isOTPSubmissionSuccessful: false,
      otpSubmissionMessage: e.toString(),
    ));
  }
}

_handleOtpResendSuccess({required Emitter<VerifyOtpWithInitialState> emit, required VerifyOtpWithInitialState state, required CommonResponseModel success, required TriggerResendOtp event}) {
  emit(state.copyWith(
    isLoading: false,
    isOTPSubmissionSuccessful: true,
    isResendOtpSuccessful: true,
    otpSubmissionMessage: success.message!,
    fields:
    List.generate(4, (index) => TextEditingController(text: '')),
    nodes: List.generate(4, (index) => FocusNode()),
    fieldErrors: List.generate(4, (index) => null),
  ));
}

_handleOtpResendFailure({required Failure failure, required Emitter<VerifyOtpWithInitialState> emit, required VerifyOtpWithInitialState state}) {
  emit(state.copyWith(
    isLoading: false,
    isOTPSubmissionSuccessful: false,
    otpSubmissionMessage: failure.message,
  ));
}