// Onboarding records
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template_flutter_mvvm_repo_bloc/services/share_preferences_services/record_key_manager.dart';


class OnboardingData{
  final SharedPreferences _sharedPreferences;
  OnboardingData(this._sharedPreferences);
  Future<bool> isOnboardingFirstTime() async {
    return _sharedPreferences.getBool(RecordKeyManager.isOnboardingFirstTime) ??true; }
  Future<void> setOnboardingFirstTime({required bool value}) async {
    _sharedPreferences.setBool(RecordKeyManager.isOnboardingFirstTime, value);
  }
}
