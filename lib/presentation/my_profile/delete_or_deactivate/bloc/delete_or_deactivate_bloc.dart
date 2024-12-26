import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../di/di.dart';
import '../../../../imports/common.dart';
import '../../../../imports/data.dart';
import '../../../../imports/services.dart';
import '../../../../imports/usecase.dart';


part 'delete_or_deactivate_event.dart';

part 'delete_or_deactivate_state.dart';

part 'delete_or_deactivate_bloc.freezed.dart';

class DeleteOrDeactivateBloc
    extends Bloc<DeleteOrDeactivateEvent, DeleteOrDeactivateWithInitialState> {
  final DeleteAccountUseCase deleteAccountUseCase;
  UserData userData = instance<UserData>();
  DeleteOrDeactivateBloc(this.deleteAccountUseCase)
      : super(DeleteOrDeactivateWithInitialState.initial()) {

    on<TriggerDeleteAccount>(_onTriggerDeleteAccount);
  }

  FutureOr<void> _onTriggerDeleteAccount(TriggerDeleteAccount event,
      Emitter<DeleteOrDeactivateWithInitialState> emit) async {
    emit(state.copyWith(isLoading: true, isFailure: false, message: ''));

    try {
      SignedInUserData signedInUserData = await extractUserDataFromCache();
      String email = signedInUserData.email ?? '';
      final response = await deleteAccountUseCase.execute(null);
      response.fold(
          (failure) => emit(state.copyWith(
              message: failure.message, isFailure: true, isLoading: false)),
          (success) => emit(state.copyWith(
            email: email,
              message: success.message!, isFailure: false, isLoading: false)));
    } catch (e) {
      emit(state.copyWith(
          message: e.toString(), isFailure: true, isLoading: false));
    }
  }
}
