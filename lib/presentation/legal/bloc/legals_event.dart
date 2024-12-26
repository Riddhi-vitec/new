part of 'legals_bloc.dart';

abstract class LegalsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TriggerFetchLegalsEvent extends LegalsEvent {}

