part of 'my_account_bloc.dart';

@immutable
abstract class MyAccountEvent extends Equatable {
  const MyAccountEvent();
  @override

  List<Object?> get props => [];
}

class TriggerGetProfile extends MyAccountEvent{}
class TriggerSignOut extends MyAccountEvent{}
