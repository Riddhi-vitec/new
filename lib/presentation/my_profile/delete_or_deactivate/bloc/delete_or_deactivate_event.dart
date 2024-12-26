part of 'delete_or_deactivate_bloc.dart';

@immutable
abstract class DeleteOrDeactivateEvent extends Equatable{
  const DeleteOrDeactivateEvent();
  @override
  List<Object?> get props => [];
}

class TriggerDeleteAccount extends DeleteOrDeactivateEvent {
}
