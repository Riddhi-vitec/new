import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../imports/usecase.dart';

part 'navigators_event.dart';

part 'navigators_state.dart';

part 'navigators_bloc.freezed.dart';

class NavigatorsBloc
    extends Bloc<NavigatorsEvent, NavigatorStateWithInitialState> {
  final NotificationUseCase notificationUseCase;

  NavigatorsBloc(this.notificationUseCase)
      : super(NavigatorStateWithInitialState.initial()) {
    on<TriggerNavigatorsButton>(_onNavigatorsEventTriggerButton);

  }

  FutureOr<void> _onNavigatorsEventTriggerButton(TriggerNavigatorsButton event,
      Emitter<NavigatorStateWithInitialState> emit) {
    emit(NavigatorStateWithInitialState(currentIndex: event.currentIndex, notificationCount: state.notificationCount));
  }


}
