import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:template_flutter_mvvm_repo_bloc/presentation/authentication/reset_password/bloc/reset_password_handlers.dart';

import '../../../../imports/common.dart';
import '../../../../imports/usecase.dart';

part 'reset_password_event.dart';

part 'reset_password_state.dart';

part 'reset_password_bloc.freezed.dart';

class ResetPasswordBloc
    extends Bloc<ResetPasswordEvent, ResetPasswordWithInitialState> {
  String newPassword = '';
  bool isNewPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  final ResetPasswordUseCase resetPasswordUseCase;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ResetPasswordBloc(this.resetPasswordUseCase)
      : super(ResetPasswordWithInitialState.initial()) {
    on<TriggerPasswordValidationCheck>(_onTriggerNewPasswordValidationCheck);
    on<TriggerPasswordVisibilityCheck>(_onTriggerPasswordVisibilityCheck);
    on<TriggerResetPasswordSubmission>(_onTriggerResetPasswordSubmission);
  }

  FutureOr<void> _onTriggerNewPasswordValidationCheck(
      TriggerPasswordValidationCheck event,
      Emitter<ResetPasswordWithInitialState> emit) {
    emit(state.copyWith(message: '', isFailure: false, isLoading: false));
    if (event.isNewPasswordCheck) {
      String? validationResult =
          validatePasswordSecurityPolicies(event.password.trim(), null);
      newPassword = event.password.trim();
      emit(state.copyWith(
          message: '',
          isFailure: false,
          hasLowerChar: validatePasswordForLowerChar(password: newPassword),
          hasUpperChar: validatePasswordForUpperChar(password: newPassword),
          hasSpecialChar:
              validatePasswordForSpecialCharacter(password: newPassword),
          hasDigit: validatePasswordForDigits(password: newPassword),
          hasMinChar: validatePasswordMinLength(password: newPassword),
          isPasswordFieldTapped: true,
          isPasswordFieldIncorrectlyFilled:
              validationResult == null ? false : true,
          isNewPasswordInvalid: validationResult == null ? false : true));
    } else {
      String? validationResult =
          validateConfirmPassword(event.password.trim(), newPassword);
      emit(state.copyWith(
          message: '',
          isFailure: false,
          isConfirmPasswordInvalid: validationResult == null ? false : true));
    }
  }

  FutureOr<void> _onTriggerPasswordVisibilityCheck(
      TriggerPasswordVisibilityCheck event,
      Emitter<ResetPasswordWithInitialState> emit) {
    if (event.isNewPasswordCheck) {
      isNewPasswordVisible = !isNewPasswordVisible;
      emit(state.copyWith(
          message: '',
          isFailure: false,
          isNewPasswordVisible: isNewPasswordVisible));
    } else {
      isConfirmPasswordVisible = !isConfirmPasswordVisible;
      emit(state.copyWith(
          message: '',
          isFailure: false,
          isConfirmPasswordVisible: isConfirmPasswordVisible));
    }
  }

  FutureOr<void> _onTriggerResetPasswordSubmission(
      TriggerResetPasswordSubmission event,
      Emitter<ResetPasswordWithInitialState> emit) async {
    await handleResetPasswordSubmission(
        event: event,
        emit: emit,
        state: state,
        resetPasswordUseCase: resetPasswordUseCase);
  }
}
