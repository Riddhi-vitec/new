import 'package:shared_preferences/shared_preferences.dart';
import 'package:template_flutter_mvvm_repo_bloc/services/share_preferences_services/record_key_manager.dart';


class LanguageSettingsData{
  final SharedPreferences _sharedPreferences;
  LanguageSettingsData(this._sharedPreferences);
  //Language setting
  Future<void> setLanguage({required String language}) async {
    _sharedPreferences.setString(RecordKeyManager.selectedLanguage, language);
  }
  Future<String?> getUserLanguage() async {
    return _sharedPreferences.getString(RecordKeyManager.selectedLanguage);
  }
}