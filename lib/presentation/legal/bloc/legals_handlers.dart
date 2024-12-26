import 'package:bloc/bloc.dart';
import 'package:template_flutter_mvvm_repo_bloc/data/models/api_response_models/legals_response_model.dart';

import '../../../imports/common.dart';
import '../../../imports/usecase.dart';
import 'legals_bloc.dart';

handleFetchLegalsEvent({required TriggerFetchLegalsEvent event, required Emitter<LegalsWithInitialState> emit, required LegalsWithInitialState state, required LegalsUseCase legalsUseCase}) async {
  emit(state.copyWith(isFailure: false, message: ''));
  try {
    final response = await legalsUseCase.execute(null);
    response.fold(
          (failure) =>
          _handleLegalsFailure(failure: failure, emit: emit, state: state),
          (success) {return _handleLegalsSuccess(success: success, emit: emit, state: state);},
    );
  } catch (e) {
    emit(state.copyWith(isFailure: true, message: e.toString()));
  }
}

_handleLegalsSuccess({required LegalsResponseModel success, required Emitter<LegalsWithInitialState> emit, required LegalsWithInitialState state}) {
  LegalsData? pp;
  LegalsData? tou;
  LegalsData? imprint;

    for (var i = 0; i < success.data!.length; i++) {
      if (success.data![i].pageName! == Legals.privacyPolicy.name) {
        pp = success.data![i];
      }
      if (success.data![i].pageName! == Legals.termsConditions.name) {
        tou = success.data![i];
      }
      if (success.data![i].pageName! == Legals.imprint.name) {
        imprint = success.data![i];
      }
    }
    emit(state.copyWith(
        isFailure: false,
        message: success.message!,
        tou: tou,
        pp: pp,
        imprint: imprint));

}

_handleLegalsFailure({required Failure failure, required Emitter<LegalsWithInitialState> emit, required LegalsWithInitialState state}) {
  emit(state.copyWith(isFailure: true, message: failure.message));
}