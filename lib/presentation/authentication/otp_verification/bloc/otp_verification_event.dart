part of 'otp_verification_bloc.dart';





@immutable
abstract class OtpVerificationEvent extends Equatable {
  const OtpVerificationEvent();

  @override
  List<Object?> get props => [];
}

class TriggerAnimationInitialization extends OtpVerificationEvent {
  final TickerProvider vsync;
  final OtpRequestModel otpRequestModel;


  const TriggerAnimationInitialization({required this.vsync, required this.otpRequestModel});

  @override
  List<Object?> get props => [vsync, otpRequestModel];
}

class TriggerAnimationStart extends OtpVerificationEvent {

  const TriggerAnimationStart();

  @override
  List<Object?> get props => [];
}

class TriggerAnimationStop extends OtpVerificationEvent {
  const TriggerAnimationStop();

  @override
  List<Object?> get props => [];
}

class TriggerSubmitOtp extends OtpVerificationEvent {
  final String email;
  final String password;
  final String fullName;
  final List<TextEditingController> fields;
  final bool isFromDeletion;

  const TriggerSubmitOtp(
      {required this.email, required this.isFromDeletion, required this.fields,required this.fullName, required this.password});

  @override
  List<Object?> get props => [ email, password, fullName, fields, isFromDeletion];
}


class TriggerDigitReplace extends OtpVerificationEvent {
  final int index;
  final String val;
  final List<TextEditingController> fields;
  final List<String?> fieldErrors;

  const TriggerDigitReplace({required this.index, required this.fieldErrors,required this.fields, required this.val});

  @override
  List<Object?> get props => [index, val, fields, fieldErrors];
}

class TriggerResendOtp extends OtpVerificationEvent {
  final TickerProvider vsync;
  final OtpRequestModel otpRequestModel;

  const TriggerResendOtp({required this.vsync, required this.otpRequestModel});

  @override
  List<Object?> get props => [vsync, otpRequestModel];
}