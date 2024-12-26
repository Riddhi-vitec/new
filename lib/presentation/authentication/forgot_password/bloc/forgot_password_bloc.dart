import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


import '../../../../imports/usecase.dart';
import 'forgot_password_handlers.dart';


part 'forgot_password_event.dart';

part 'forgot_password_state.dart';

part 'forgot_password_bloc.freezed.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordWithInitialState> {
  final ForgotPasswordUseCase forgotPasswordUseCase;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ForgotPasswordBloc(this.forgotPasswordUseCase)
      : super(ForgotPasswordWithInitialState.initial()) {
    on<TriggerEmailValidation>(_onTriggerEmailValidation);
    on<TriggerSubmitEmail>(_onTriggerSubmitEmail);
  }

  FutureOr<void> _onTriggerEmailValidation(TriggerEmailValidation event,
      Emitter<ForgotPasswordWithInitialState> emit) {
    handleEmailValidation(
        event: event, emit: emit, state: state);
  }

  FutureOr<void> _onTriggerSubmitEmail(TriggerSubmitEmail event,
      Emitter<ForgotPasswordWithInitialState> emit) async {
   await handleSubmitEmail(event: event, emit: emit, forgotPasswordUseCase: forgotPasswordUseCase, state: state);
  }
}
