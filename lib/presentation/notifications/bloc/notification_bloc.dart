import 'dart:async';
import 'package:clear_all_notifications/clear_all_notifications.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/resources/routes.dart';
import 'package:template_flutter_mvvm_repo_bloc/root_app.dart';

import '../../../di/di.dart';
import '../../../imports/data.dart';
import '../../../imports/usecase.dart';

part 'notification_event.dart';

part 'notification_state.dart';

part 'notification_bloc.freezed.dart';

class NotificationBloc
    extends Bloc<NotificationEvent, NotificationWithInitialState> {
  final NotificationUseCase notificationUseCase;
  final ReadNotificationUseCase readNotificationUseCase;

  listenToForegroundNotification({required NotificationBloc notificationBloc}) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if(notificationBloc.isClosed){
        notificationBloc = instance<NotificationBloc>();
      }
      notificationBloc.add(TriggerFetchNotificationList());
    });
  }
  NotificationBloc(this.notificationUseCase, this.readNotificationUseCase)
      : super(NotificationWithInitialState.initial()) {
    on<TriggerFetchNotificationList>(_onTriggerFetchNotificationList);

    on<TriggerReadNotification>(_onTriggerReadNotification);
  }

  FutureOr<void> _onTriggerFetchNotificationList(TriggerFetchNotificationList event,
      Emitter<NotificationWithInitialState> emit) async {
    emit(state.copyWith(isLoading: true));
    await ClearAllNotifications.clear();
    try {
      final response = await notificationUseCase.execute(null);
      response.fold(
          (failure) => emit(state.copyWith(
              isLoading: false, isFailure: true, message: failure.message)),
          (success) => emit(state.copyWith(
              isLoading: false,
              isFailure: false,
              notificationData: success.data ?? [])));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, isFailure: true, message: e.toString()));
    }
  }

  FutureOr<void> _onTriggerReadNotification(TriggerReadNotification event,
      Emitter<NotificationWithInitialState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final response =
          await readNotificationUseCase.execute(event.notificationID);
      response.fold(
        (failure) => emit(state.copyWith(
            isLoading: false, isFailure: true, message: failure.message)),
        (success) => {
          emit(state.copyWith(isLoading: false, isFailure: false, message: '')),
          Navigator.pushNamed(navigatorKey.currentState!.context,
              RouteName.routeNotificationDetail,
              arguments: event.notificationID),
        },
      );
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, isFailure: true, message: e.toString()));
    }
  }


}
