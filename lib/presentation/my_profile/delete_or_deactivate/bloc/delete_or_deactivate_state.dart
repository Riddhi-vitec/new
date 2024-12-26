part of 'delete_or_deactivate_bloc.dart';

@freezed
class DeleteOrDeactivateWithInitialState with _$DeleteOrDeactivateWithInitialState {
  const factory DeleteOrDeactivateWithInitialState({
    required String message,
    required bool isFailure,
    required bool isLoading,
    required String email,
  }) = _DeleteOrDeactivateWithInitialState;

  factory DeleteOrDeactivateWithInitialState.initial() => const DeleteOrDeactivateWithInitialState(
      message: '',
      isFailure: false,
      isLoading: false,
      email: ''
     );
}

