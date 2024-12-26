import 'package:shared_preferences/shared_preferences.dart';
import 'package:template_flutter_mvvm_repo_bloc/services/share_preferences_services/record_key_manager.dart';

import '../../common/resources/app_strings.dart';


class AppSettingsData {
  final SharedPreferences _sharedPreferences;

  AppSettingsData(this._sharedPreferences);

  //Crashlytics
  Future<bool> isCrashCollectionActive() async {
    return _sharedPreferences.getBool(RecordKeyManager.isCrashCollectionActive) ??
        true;
  }

  Future<void> setCrashlyticsCollectionPermission({required bool value}) async {
    _sharedPreferences.setBool(RecordKeyManager.isCrashCollectionActive, value);
  }

  //Notification
  Future<bool> isPushNotificationActive() async {
    return _sharedPreferences
            .getBool(RecordKeyManager.isPushNotificationActive) ??
        true;
  }

  Future<void> setNotificationPermission({required bool value}) async {
    _sharedPreferences.setBool(RecordKeyManager.isPushNotificationActive, value);
  }

  //Enable location
  Future<bool> isLocationDetectionActive() async {
    return _sharedPreferences
        .getBool(RecordKeyManager.isLocationDetectionActive) ??
        false;
  }

  Future<void> setLocationDetectionPermission({required bool value}) async {
    _sharedPreferences.setBool(RecordKeyManager.isLocationDetectionActive, value);
  }

}
