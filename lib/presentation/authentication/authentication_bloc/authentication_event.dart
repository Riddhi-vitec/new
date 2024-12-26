part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent extends Equatable{
  const AuthenticationEvent();
  @override
  List<Object?> get props => [];
}

class TriggerFieldValidationEvent extends AuthenticationEvent{
  final String input;
  final TextFieldVariant textFieldVariant;
  final   bool? isPassword;
  final   bool? isCurrentPassword;
  const TriggerFieldValidationEvent({required this.textFieldVariant, this.isCurrentPassword, required this.input, required this.isPassword});
  @override
  List<Object?> get props => [input, textFieldVariant, isPassword, isCurrentPassword];
}
class TriggerCheckboxForSignUp extends AuthenticationEvent {}

class TriggerPasswordVisibilityCheck extends AuthenticationEvent {
  final bool? isPassword;
  final bool? currentPassword;
  final bool? isCurrentPasswordVisible;
  final bool? isPasswordVisible;
  final bool? isConfirmedPasswordVisible;
  const TriggerPasswordVisibilityCheck({required this.isPassword, required this.currentPassword, required this.isCurrentPasswordVisible, required this.isPasswordVisible, required this.isConfirmedPasswordVisible});
  @override
  List<Object?> get props => [isPassword, currentPassword, currentPassword, isCurrentPasswordVisible, isPasswordVisible, isConfirmedPasswordVisible];
}
class TriggerRefreshView extends AuthenticationEvent{}



///Api events
class TriggerGoogleSignInRequest extends AuthenticationEvent {}
class TriggerFacebookSignInRequest extends AuthenticationEvent {}
class TriggerAppleSignInRequest extends AuthenticationEvent {}
class TriggerEmailSignInRequest extends AuthenticationEvent {
  final String email;
  final String password;

  const TriggerEmailSignInRequest(
      {required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
class TriggerEmailSignUpRequest extends AuthenticationEvent {
  final String email;
  const TriggerEmailSignUpRequest(
      {required this.email, });

  @override
  List<Object?> get props => [email];
}

class TriggerChangePasswordRequest extends AuthenticationEvent{
  final String oldPassword;
  final String newPassword;
  const TriggerChangePasswordRequest({required this.oldPassword, required this.newPassword});
  @override

  List<Object?> get props => [oldPassword, newPassword];
}