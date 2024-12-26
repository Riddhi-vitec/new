part of 'notification_bloc.dart';

@immutable
abstract class NotificationEvent extends Equatable {
  const NotificationEvent();
 @override
  List<Object?> get props => [];
}

class TriggerFetchNotificationList extends NotificationEvent {}
class TriggerReadNotification extends NotificationEvent {
  final String notificationID;
  const TriggerReadNotification({required this.notificationID});
  @override
  List<Object?> get props => [notificationID];
}