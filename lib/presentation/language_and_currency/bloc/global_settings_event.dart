part of 'global_settings_bloc.dart';


class GlobalSettingsEvent extends Equatable{
  const GlobalSettingsEvent();
  @override

  List<Object?> get props => [];

}
class TriggerCheckForLanguageAndCurrency extends GlobalSettingsEvent{}
class TriggerChangeLanguage extends GlobalSettingsEvent{
  final LanguageCode languageCode;
  const TriggerChangeLanguage({required this.languageCode});
  @override

  List<Object?> get props => [languageCode];
}

class TriggerChangeCurrency extends GlobalSettingsEvent{
  final Currency currency;
  const TriggerChangeCurrency({required this.currency});
  @override

  List<Object?> get props => [currency];
}