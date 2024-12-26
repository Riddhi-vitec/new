part of 'global_settings_bloc.dart';

@freezed

class GlobalSettingsWithInitialState with _$GlobalSettingsWithInitialState {
  const factory GlobalSettingsWithInitialState({
    required String language,
    required String selectedLanguage,
    required Currency? selectedCurrency,
    required bool isRefresh
  }) = _GlobalSettingsWithInitialState;

  factory GlobalSettingsWithInitialState.initial() =>
       GlobalSettingsWithInitialState(
       selectedLanguage: LanguageCode.en.languageName,
        language: LanguageCode.en.name,
        selectedCurrency: null,
         isRefresh: false
      );
}

