import 'package:shared_preferences/shared_preferences.dart';
import 'package:template_flutter_mvvm_repo_bloc/services/share_preferences_services/record_key_manager.dart';

import '../../common/resources/app_strings.dart';

class CurrencySettingsData{
  final SharedPreferences _sharedPreferences;
  CurrencySettingsData(this._sharedPreferences);
  //Currency Setting
  Future<void> setCurrency({required String currency}) async {
    _sharedPreferences.setString(RecordKeyManager.selectedCurrency, currency);
  }
  Future<String?> getCurrency() async {
    return _sharedPreferences.getString(RecordKeyManager.selectedCurrency) ?? "hi";
  }

  Future<bool> hasCurrencyValue() async {
    return  _sharedPreferences.containsKey(RecordKeyManager.selectedCurrency);
  }
}