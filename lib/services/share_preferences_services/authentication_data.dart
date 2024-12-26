import 'package:shared_preferences/shared_preferences.dart';
import 'package:template_flutter_mvvm_repo_bloc/services/share_preferences_services/record_key_manager.dart';


class AuthenticationData {
  final SharedPreferences _sharedPreferences;

  AuthenticationData(this._sharedPreferences);

  //Login prefs
  Future<bool> isUserSignedIn() async {
    return _sharedPreferences
            .getBool(RecordKeyManager.isUserLoggedIn) ??
        false;
  }

  Future<void> hasUserActiveSession({required bool value}) async {
    _sharedPreferences.setBool(
        RecordKeyManager.isUserLoggedIn, value);
  }

  //Token prefs
  Future<String?> getUserAuthToken() async {
    return _sharedPreferences
        .getString(RecordKeyManager.authToken);
  }

  Future<void> setUserAuthToken({required String value}) async {
    _sharedPreferences.setString(
        RecordKeyManager.authToken, value);
  }
  //Refresh Token prefs
  Future<String?> getUserRefreshToken() async {
    return _sharedPreferences
        .getString(RecordKeyManager.userRefreshToken);
  }

  Future<void> setUserRefreshToken({required String value}) async {
    _sharedPreferences.setString(
        RecordKeyManager.userRefreshToken, value);
  }

  //Eraser Function
  removeSharedPreferencesGeneralFunction(String key) async {
    return _sharedPreferences.remove(key);
  }

  // Eraser function for signing out
  removeUserDataCache() async {
    await removeSharedPreferencesGeneralFunction(
        RecordKeyManager.userInfo);
    await removeSharedPreferencesGeneralFunction(
        RecordKeyManager.userId);
    await removeSharedPreferencesGeneralFunction(
        RecordKeyManager.authToken);
    await removeSharedPreferencesGeneralFunction(
        RecordKeyManager.userRefreshToken);
    await removeSharedPreferencesGeneralFunction(
        RecordKeyManager.isUserLoggedIn);
  }
}
