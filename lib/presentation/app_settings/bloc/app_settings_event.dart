part of 'app_settings_bloc.dart';

@immutable
abstract class AppSettingsEvent extends Equatable{
  const AppSettingsEvent();
  @override
  List<Object?> get props => [];
}
class TriggerFetchActivatedSwitches extends AppSettingsEvent{}
class TriggerCrashlyticsPermissionEvent extends AppSettingsEvent{
  final bool isCrashCollectionActivated;

  const TriggerCrashlyticsPermissionEvent({required this.isCrashCollectionActivated});
  @override
  List<Object?> get props => [isCrashCollectionActivated];
}

class TriggerNotificationAndLocationPermissionEvent extends AppSettingsEvent{}

class TriggerAppInfoDisplay extends AppSettingsEvent {
  final bool isAppInfoAccordionExpanded;
  const TriggerAppInfoDisplay({required this.isAppInfoAccordionExpanded});
  @override
  List<Object?> get props => [isAppInfoAccordionExpanded];
}

