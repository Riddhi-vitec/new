import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../di/di.dart';
import '../../../imports/common.dart';
import '../../../imports/services.dart';
import 'global_settings_handlers.dart';

part 'global_settings_event.dart';

part 'global_settings_state.dart';

part 'global_settings_bloc.freezed.dart';

class GlobalSettingsBloc
    extends Bloc<GlobalSettingsEvent, GlobalSettingsWithInitialState> {
  final LanguageSettingsData _languageSettingsData =
      instance<LanguageSettingsData>();
  final CurrencySettingsData currencySettingsData =
      instance<CurrencySettingsData>();
  String languageCode = LanguageCode.en.name;
  String selectedLanguage = LanguageCode.en.languageName;
  Currency? selectedCurrency;

  // = CurrencyService().getAll()[0];
  String? selectedCurrencyFlag;

  GlobalSettingsBloc() : super(GlobalSettingsWithInitialState.initial()) {
    on<TriggerChangeLanguage>(_onTriggerChangeLanguage);
    on<TriggerCheckForLanguageAndCurrency>(
        _onTriggerCheckForLanguageAndCurrency);
    on<TriggerChangeCurrency>(_onTriggerChangeCurrency);
  }

  FutureOr<void> _onTriggerChangeLanguage(TriggerChangeLanguage event,
      Emitter<GlobalSettingsWithInitialState> emit) async {
    if (event.languageCode == LanguageCode.de) {
      languageCode = LanguageCode.de.name;
    } else {
      languageCode = LanguageCode.en.name;
    }
    await _languageSettingsData.setLanguage(language: languageCode);
    selectedLanguage =
        handleSelectedLanguageRetrieval(languageCode: languageCode);
    emit(state.copyWith(
        language: languageCode, selectedLanguage: selectedLanguage));
  }

  FutureOr<void> _onTriggerCheckForLanguageAndCurrency(
      TriggerCheckForLanguageAndCurrency event,
      Emitter<GlobalSettingsWithInitialState> emit) async {
    languageCode = await _languageSettingsData.getUserLanguage() ?? LanguageCode.en.name;
    var selectedCurrencyCode = await handleSelectedCurrencyCodeRetrieval(
        currencySettingsData: currencySettingsData);
    selectedCurrency = handleSelectedCurrencyRetrieval(
        currencyCode: selectedCurrencyCode,
        currencySettingsData: currencySettingsData);
    selectedLanguage =
        handleSelectedLanguageRetrieval(languageCode: languageCode);
    emit(state.copyWith(
        language: languageCode,
        selectedCurrency: selectedCurrency,
        selectedLanguage: selectedLanguage));
  }

  FutureOr<void> _onTriggerChangeCurrency(TriggerChangeCurrency event,
      Emitter<GlobalSettingsWithInitialState> emit) async {
    emit(state.copyWith(isRefresh: true));
    await currencySettingsData.setCurrency(currency: event.currency.code);
    selectedCurrency = event.currency;
    emit(state.copyWith(selectedCurrency: selectedCurrency, isRefresh: false));
  }
}
