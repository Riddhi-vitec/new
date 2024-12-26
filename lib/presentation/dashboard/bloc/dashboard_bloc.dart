import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../imports/data.dart';
import '../../../imports/usecase.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

part 'dashboard_bloc.freezed.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardWithInitialState> {
  final NotificationUseCase notificationUseCase;

  int count = 0;
  DashboardBloc(this.notificationUseCase)
      : super(DashboardWithInitialState.initial()) {
    on<TriggerCountNotification>(_onTriggerCountNotification);
  }

  FutureOr<void> _onTriggerCountNotification(TriggerCountNotification event,
      Emitter<DashboardWithInitialState> emit) async {
    final response = await notificationUseCase.execute(null);
    try {
      response.fold(
          (failure) => emit(const DashboardWithInitialState(
                notificationCount: 0,
              )), (success) {
        List<NotificationData> listOfUnread   = success.data!.where((element) => element.isRead == false).toList();
        count = listOfUnread.length;
        emit(
          DashboardWithInitialState(
            notificationCount:count,
          ),
        );
      });
    } catch (e) {
      emit(const DashboardWithInitialState(notificationCount: 0));
    }
  }
}
