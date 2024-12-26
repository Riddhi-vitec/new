part of 'notification_bloc.dart';


@freezed
class NotificationWithInitialState with _$NotificationWithInitialState {
  const factory NotificationWithInitialState({
    required String message,
    required bool isLoading,
    required bool isFailure,
    required List<NotificationData> notificationData,

  }) = _NotificationWithInitialState;

  factory NotificationWithInitialState.initial() =>
      const NotificationWithInitialState(
        message: '',
        isFailure: false,
        isLoading: false,
        notificationData: []
      );
}
