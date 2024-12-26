import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../imports/common.dart';
import '../../../imports/data.dart';
import '../../../imports/usecase.dart';
import 'my_account_handlers.dart';

part 'my_account_event.dart';

part 'my_account_state.dart';

part 'my_account_bloc.freezed.dart';

class MyAccountBloc extends Bloc<MyAccountEvent, MyAccountWithInitialState> {
  final ProfileUseCase profileUseCase;
  final SignOutUseCase signOutUseCase;

  MyAccountBloc(this.profileUseCase, this.signOutUseCase)
      : super(MyAccountWithInitialState.initial()) {
    on<TriggerGetProfile>(_onTriggerGetProfile);
    on<TriggerSignOut>(_onTriggerSignOut);
  }

  FutureOr<void> _onTriggerGetProfile(
      TriggerGetProfile event, Emitter<MyAccountWithInitialState> emit) async {
    await handleProfileEvent(
        event: event, emit: emit, state: state, profileUseCase: profileUseCase);
  }

  FutureOr<void> _onTriggerSignOut(
      TriggerSignOut event, Emitter<MyAccountWithInitialState> emit) async {
    await handleSignOut(
        event: event, emit: emit, state: state, signOutUseCase: signOutUseCase);
  }
}

