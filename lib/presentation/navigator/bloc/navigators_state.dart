part of 'navigators_bloc.dart';

@freezed
class NavigatorStateWithInitialState with _$NavigatorStateWithInitialState {
  const factory NavigatorStateWithInitialState({
    required int currentIndex,
    required int notificationCount,
  }) = _NavigatorStateWithInitialState;

  factory NavigatorStateWithInitialState.initial() =>
      const NavigatorStateWithInitialState(
          currentIndex: 0, notificationCount: 0);
}