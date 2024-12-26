import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../imports/common.dart';
import '../../../imports/services.dart';
import 'app_settings_bloc.dart';

// handle firebase crash setup
handleFirebaseCrashSetUp(
    {required AppSettingsData appSettingsData,
    required bool isCrashCollectionActive}) async {
  await appSettingsData.setCrashlyticsCollectionPermission(
      value: isCrashCollectionActive);
  const fatalError = true;
  if (isCrashCollectionActive) {
    // Non-async exceptions
    FlutterError.onError = (errorDetails) {
      if (fatalError) {
        // If you want to record a "fatal" exception
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
        // ignore: dead_code
      } else {
        // If you want to record a "non-fatal" exception
        FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
      }
    };
    // Async exceptions
    PlatformDispatcher.instance.onError = (error, stack) {
      if (fatalError) {
        // If you want to record a "fatal" exception
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        // ignore: dead_code
      } else {
        // If you want to record a "non-fatal" exception
        FirebaseCrashlytics.instance.recordError(error, stack);
      }
      return true;
    };

    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  } else {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  }
}

// handle crash collection via app settings
Future<void> handleEnableDisableCrashCollection({
  required TriggerCrashlyticsPermissionEvent event,
  required AppSettingsData appSettingsData,
  required HttpConnectionInfoServices httpConnectionEstablishment,
  required Emitter<AppSettingsWithInitialState> emit,
  required AppSettingsWithInitialState state,
}) async {
  bool isCrashCollectionActive = false;

  if (await httpConnectionEstablishment.isConnected) {
    isCrashCollectionActive = !event.isCrashCollectionActivated;
    handleFirebaseCrashSetUp(
        isCrashCollectionActive: isCrashCollectionActive,
        appSettingsData: appSettingsData);
  } else {
    emit(state.copyWith(
        errorMessage: AppStrings.internetStatus_foundNoConnection_error));
  }
  emit(state.copyWith(
      isLoading: false, isCrashCollectionActive: isCrashCollectionActive));
}

// handle notification permission
Future<bool> handleNotificationPermission(
    {required AppSettingsData appSettingsData}) async {
  PermissionStatus status =
      await NotificationPermissions.getNotificationPermissionStatus();
  bool isPushNotificationActive;

  if (status == PermissionStatus.granted) {
    isPushNotificationActive = true;
  } else {
    isPushNotificationActive = false;
  }

  await appSettingsData.setNotificationPermission(
      value: isPushNotificationActive);

  return isPushNotificationActive;
}

// handle location detection
Future<bool> handleLocationDetection(
    {required AppSettingsData appSettingsData}) async {
  bool isLocationDetectionActive = await Geolocator.isLocationServiceEnabled();
  await appSettingsData.setLocationDetectionPermission(
      value: isLocationDetectionActive);
  return isLocationDetectionActive;
}

//handle notification and location permissions
Future<void> handleNotificationAndLocationPermissions({
  required TriggerNotificationAndLocationPermissionEvent event,
  required Emitter<AppSettingsWithInitialState> emit,
  required AppSettingsData appSettingsData,
  required AppSettingsWithInitialState state,
}) async {
  emit(state.copyWith(isLoading: true));

  bool isPushNotificationActive =
      await handleNotificationPermission(appSettingsData: appSettingsData);
  bool isLocationDetectionActive =
      await handleLocationDetection(appSettingsData: appSettingsData);

  emit(state.copyWith(
    isLocationDetectionActive: isLocationDetectionActive,
    isLoading: false,
    isPushNotificationActive: isPushNotificationActive,
  ));
}

// handle app info display
Future<void> handleAppInfoDisplay({
  required TriggerAppInfoDisplay event,
  required Emitter<AppSettingsWithInitialState> emit,
  required AppSettingsWithInitialState state,
}) async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String appName = packageInfo.appName ?? '';
  String appBuildVersion = packageInfo.version ?? '';
  String appBuildNumber = packageInfo.buildNumber ?? '';
  bool isAppInfoAccordionExpanded = !event.isAppInfoAccordionExpanded;

  emit(state.copyWith(
    appName: appName,
    appBuildNumber: appBuildNumber,
    appBuildVersion: appBuildVersion,
    isAppInfoAccordionExpanded: isAppInfoAccordionExpanded,
  ));
}

// handle active switch retrieval
Future<void> handleActivatedToggleButtonStateRetrieval(
    {required TriggerFetchActivatedSwitches event,
    required Emitter<AppSettingsWithInitialState> emit,
    required AppSettingsWithInitialState state,
    required AppSettingsData appSettingsData,
  }) async {
  bool isPushNotificationActive =
      await appSettingsData.isPushNotificationActive();
  bool isCrashCollectionActive =
      await appSettingsData.isCrashCollectionActive();
  bool isLocationDetectionActive =
      await appSettingsData.isLocationDetectionActive();

  emit(state.copyWith(
    isCrashCollectionActive: isCrashCollectionActive,
    isLocationDetectionActive: isLocationDetectionActive,
    isPushNotificationActive: isPushNotificationActive,
    isLoading: false,
  ));
}
