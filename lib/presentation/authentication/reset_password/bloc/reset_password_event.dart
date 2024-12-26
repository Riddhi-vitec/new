part of 'reset_password_bloc.dart';

@immutable
abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object?> get props => [];
}

class TriggerPasswordValidationCheck extends ResetPasswordEvent {
  final String password;
  final bool isNewPasswordCheck;

  const TriggerPasswordValidationCheck(
      {required this.password, required this.isNewPasswordCheck});

  @override
  List<Object?> get props => [password, isNewPasswordCheck];
}

class TriggerPasswordVisibilityCheck extends ResetPasswordEvent {
  final bool isNewPasswordCheck;

  const TriggerPasswordVisibilityCheck({required this.isNewPasswordCheck});

  @override
  List<Object?> get props => [isNewPasswordCheck];
}

class TriggerResetPasswordSubmission extends ResetPasswordEvent {
  final String newPassword;
  final String tokenExtractedFromEmail;

  const TriggerResetPasswordSubmission(
      {required this.newPassword, required this.tokenExtractedFromEmail});

  @override
  List<Object?> get props => [newPassword, tokenExtractedFromEmail];
}
