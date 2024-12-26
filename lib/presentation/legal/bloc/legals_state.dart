part of 'legals_bloc.dart';

@freezed
class LegalsWithInitialState with _$LegalsWithInitialState {
  const factory LegalsWithInitialState({
    required String message,
    required bool isFailure,
    required LegalsData? tou,
    required LegalsData? pp,
    required LegalsData? imprint,
  }) = _LegalsWithInitialState;

  factory LegalsWithInitialState.initial() =>
      LegalsWithInitialState(
          message: '',
          isFailure: false,
          imprint: null,
          pp: null,
          tou: null
      );
}