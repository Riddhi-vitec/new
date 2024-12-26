part of 'app_settings_bloc.dart';

@freezed
class AppSettingsWithInitialState with _$AppSettingsWithInitialState {
  const factory AppSettingsWithInitialState({
    required bool isCrashCollectionActive,
    required bool isPushNotificationActive,
    required bool isLocationDetectionActive,
    required bool isAppInfoAccordionExpanded,
    required String errorMessage,
    required String appName,
    required String appBuildVersion,
    required String appBuildNumber,
    required String language,
    required String selectedLanguage,
    required Currency? selectedCurrency,
    required bool isRefresh,
    required bool isLoading,
  }) = _AppSettingsWithInitialState;

  factory AppSettingsWithInitialState.initial() => AppSettingsWithInitialState(
      isAppInfoAccordionExpanded: false,
      isCrashCollectionActive: false,
      isLocationDetectionActive: false,
      isPushNotificationActive: false,
      isRefresh: false,
      isLoading: true,
      errorMessage: '',
      appName: '',
      appBuildVersion: '',
      selectedCurrency: null,
      appBuildNumber: '',
      language: LanguageCode.en.name,
      selectedLanguage: LanguageCode.en.languageName);
}
