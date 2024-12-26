import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/resources/enum.dart';
import 'package:template_flutter_mvvm_repo_bloc/data/models/api_response_models/legals_response_model.dart';
import '../../../imports/usecase.dart';
import 'legals_handlers.dart';

part 'legals_event.dart';

part 'legals_state.dart';

part 'legals_bloc.freezed.dart';

class LegalsBloc extends Bloc<LegalsEvent, LegalsWithInitialState> {
  final LegalsUseCase legalsUseCase;

  LegalsBloc(this.legalsUseCase) : super(LegalsWithInitialState.initial()) {
    on<TriggerFetchLegalsEvent>(_onTriggerFetchLegalsEvent);
  }

  FutureOr<void> _onTriggerFetchLegalsEvent(TriggerFetchLegalsEvent event,
      Emitter<LegalsWithInitialState> emit) async {
    await handleFetchLegalsEvent(
      event: event,
      emit: emit,
      state: state,
      legalsUseCase: legalsUseCase,
    );
  }
}
