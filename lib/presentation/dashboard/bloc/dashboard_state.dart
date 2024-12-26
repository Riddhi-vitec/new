part of 'dashboard_bloc.dart';


@freezed
class DashboardWithInitialState with _$DashboardWithInitialState{
  const factory DashboardWithInitialState({
    required int notificationCount,
  }) = _DashboardWithInitialState;

  factory DashboardWithInitialState.initial() =>
      const DashboardWithInitialState(
         notificationCount: 0);
}