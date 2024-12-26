part of 'forgot_password_bloc.dart';

@immutable
abstract class ForgotPasswordEvent extends Equatable{
  const ForgotPasswordEvent();
  @override
  List<Object?> get props => [];
}

class TriggerEmailValidation extends ForgotPasswordEvent{
  final String email;
  const TriggerEmailValidation({required this.email});
  @override
  List<Object?> get props => [email];
}

class TriggerSubmitEmail extends ForgotPasswordEvent{
  final String email;
  const TriggerSubmitEmail({required this.email});
  @override

  List<Object?> get props => [email];
}