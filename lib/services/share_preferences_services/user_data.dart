import 'package:shared_preferences/shared_preferences.dart';
import 'package:template_flutter_mvvm_repo_bloc/services/share_preferences_services/record_key_manager.dart';

class UserData {
  final SharedPreferences _sharedPreferences;

  UserData(this._sharedPreferences);

  //User id
  Future<String?> getUserId() async {
    return _sharedPreferences.getString(RecordKeyManager.userId);
  }

  Future<void> setUserId({required String value}) async {
    _sharedPreferences.setString(RecordKeyManager.userId, value);
  }

  //User extensive detail-- use jsonEncode to transform to string when setting value
  Future<String?> getUserInfo() async {
    return _sharedPreferences.getString(RecordKeyManager.userInfo);
  }

  Future<void> setUserInfo({required String jsonEncodedValue}) async {
    _sharedPreferences.setString(
        RecordKeyManager.userInfo, jsonEncodedValue);
  }

  //apple sign in user data
  Future<void> setAppleUserData(String appleUser) async {
    _sharedPreferences.setString(RecordKeyManager.appleUserData, appleUser);
  }

  Future<String> getAppleUserData() async {
    return _sharedPreferences.getString(RecordKeyManager.appleUserData) ?? "";
  }
}
