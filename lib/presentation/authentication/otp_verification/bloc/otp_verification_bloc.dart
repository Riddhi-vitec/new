import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';

import '../../../../imports/data.dart';
import '../../../../imports/usecase.dart';
import 'otp_verification_handlers.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'otp_verification_event.dart';
part 'otp_verification_state.dart';
part 'otp_verification_bloc.freezed.dart';



class OtpVerificationBloc extends Bloc<OtpVerificationEvent, VerifyOtpWithInitialState> {
  late AnimationController animationController;
  late Animation<double> animation;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final VerifyOtpUseCase verifyOtpUseCase;
  final SignUpUseCase signUpUseCase;

  OtpVerificationBloc(this.verifyOtpUseCase, this.signUpUseCase)
      : super(VerifyOtpWithInitialState.initial()) {
    on<TriggerAnimationInitialization>(_onTriggerAnimationInitialization);
    on<TriggerAnimationStart>(_onTriggerAnimationStart);
    on<TriggerDigitReplace>(_onTriggerDigitReplace);
    on<TriggerSubmitOtp>(_onTriggerSubmitOtp);
    on<TriggerResendOtp>(_onTriggerResendOtp);
  }

  FutureOr<void> _onTriggerAnimationInitialization(
      TriggerAnimationInitialization event,
      Emitter<VerifyOtpWithInitialState> emit) {
    animationController = handleAnimationControllerCreation(event: event);
    animation =
        Tween<double>(begin: 60.0, end: 0.0).animate(animationController)
          ..addListener(() {
            add(const TriggerAnimationStart());
          });
    String fullname =
        handleFullNameExtraction(fullName: event.otpRequestModel.fullName);
    String email = handleEmailExtraction(email: event.otpRequestModel.email);
    String password =
        handlePasswordExtraction(password: event.otpRequestModel.password);
    emit(state.copyWith(
        fullname: fullname.trim(),
        email: email.trim().trim(),
        password: password.trim(),
        animationController: animationController,
        isLoading: false,
        otpSubmissionMessage: '',
        isResendOtpSuccessful: false,
        animationValue: animation.value));
  }

  FutureOr<void> _onTriggerAnimationStart(
      TriggerAnimationStart event, Emitter<VerifyOtpWithInitialState> emit) {
    if (animation.status == AnimationStatus.forward) {
      handleAnimationContinuation(
          emit: emit, animationValue: animation.value, state: state);
    } else {
      handleAnimationTerminal(
          animationController: animationController,
          emit: emit,
          animationValue: animation.value,
          state: state);
    }
  }

  FutureOr<void> _onTriggerDigitReplace(
      TriggerDigitReplace event, Emitter<VerifyOtpWithInitialState> emit) {
    handleDigitReplace(event: event, emit: emit, state: state);
  }

  FutureOr<void> _onTriggerSubmitOtp(
      TriggerSubmitOtp event, Emitter<VerifyOtpWithInitialState> emit) async {
    emit(state.copyWith(isLoading: true, otpSubmissionMessage: ''));

    await handleOtpSubmission(
        verifyOtpUseCase: verifyOtpUseCase,
        event: event,
        emit: emit,
        state: state);
  }

  FutureOr<void> _onTriggerResendOtp(
      TriggerResendOtp event, Emitter<VerifyOtpWithInitialState> emit) async {
    emit(state.copyWith(
        isLoading: true, otpSubmissionMessage: '', isEmptyFieldError: false));
    await handleOtpResend(
        event: event, state: state, emit: emit, signUpUseCase: signUpUseCase);
  }
}
