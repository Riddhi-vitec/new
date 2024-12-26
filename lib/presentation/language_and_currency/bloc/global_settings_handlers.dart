import 'package:currency_picker/currency_picker.dart';

import '../../../imports/common.dart';
import '../../../imports/services.dart';

String handleSelectedLanguageRetrieval({required String languageCode}) {
  return LanguageCode
      .values[LanguageCode.values
          .indexWhere((element) => element.name == languageCode)]
      .languageName;
}

Future<String> handleSelectedCurrencyCodeRetrieval(
    {required CurrencySettingsData currencySettingsData}) async {
  return (await currencySettingsData.hasCurrencyValue()
      ? await currencySettingsData.getCurrency()
      : CurrencyService().getAll()[0].code)!;
}

handleSelectedCurrencyRetrieval(
    {required String currencyCode,
    required CurrencySettingsData currencySettingsData}) {
  return CurrencyService().getAll()[CurrencyService()
      .getAll()
      .indexWhere((element) => element.code == currencyCode)];
}
