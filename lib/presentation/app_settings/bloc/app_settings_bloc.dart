import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter/cupertino.dart';

import 'package:template_flutter_mvvm_repo_bloc/di/di.dart';

import '../../../imports/common.dart';
import '../../../services/http_services/http_connection_info_services.dart';
import '../../../services/share_preferences_services/app_settings_data.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'app_settings_handlers.dart';

part 'app_settings_event.dart';

part 'app_settings_state.dart';

part 'app_settings_bloc.freezed.dart';

class AppSettingsBloc
    extends Bloc<AppSettingsEvent, AppSettingsWithInitialState> {
  final AppSettingsData appSettingsData = instance<AppSettingsData>();
  final HttpConnectionInfoServices httpConnectionEstablishment =
      instance<HttpConnectionInfoServices>();

  AppSettingsBloc() : super(AppSettingsWithInitialState.initial()) {
    on<TriggerFetchActivatedSwitches>(_onTriggerFetchActivatedSwitches);
    on<TriggerCrashlyticsPermissionEvent>(_onEnableDisableCrashEvent);
    on<TriggerNotificationAndLocationPermissionEvent>(
        _onEnableDisableNotificationAndLocationEvent);
    on<TriggerAppInfoDisplay>(_onTriggerAppInfoDisplay);
  }

  Future<FutureOr<void>> _onEnableDisableCrashEvent(
      TriggerCrashlyticsPermissionEvent event,
      Emitter<AppSettingsWithInitialState> emit) async {
    await handleEnableDisableCrashCollection(
        appSettingsData: appSettingsData,
        emit: emit,
        event: event,
        httpConnectionEstablishment: httpConnectionEstablishment,
        state: state);
  }

  FutureOr<void> _onEnableDisableNotificationAndLocationEvent(
      TriggerNotificationAndLocationPermissionEvent event,
      Emitter<AppSettingsWithInitialState> emit) async {
    await handleNotificationAndLocationPermissions(
        appSettingsData: appSettingsData,
        emit: emit,
        event: event,
        state: state);
  }

  Future<FutureOr<void>> _onTriggerAppInfoDisplay(TriggerAppInfoDisplay event,
      Emitter<AppSettingsWithInitialState> emit) async {
    await handleAppInfoDisplay(
      event: event,
      emit: emit,
      state: state,
    );
  }

  FutureOr<void> _onTriggerFetchActivatedSwitches(
      TriggerFetchActivatedSwitches event,
      Emitter<AppSettingsWithInitialState> emit) async {
    await handleActivatedToggleButtonStateRetrieval(
      event: event,
      emit: emit,
      state: state,
      appSettingsData: appSettingsData,
    );
  }
}
