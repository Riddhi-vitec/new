part of 'contact_us_bloc.dart';

abstract class ContactUsEvent extends Equatable {
  const ContactUsEvent();

  @override
  List<Object?> get props => [];
}

class TriggerRequestFocusForTextFieldWithChar extends ContactUsEvent {
  final bool hasFocus;
  final bool? isPhone;

  const TriggerRequestFocusForTextFieldWithChar(
      {required this.hasFocus, required this.isPhone});

  @override
  List<Object?> get props => [hasFocus, isPhone];
}

class TriggerContactUs extends ContactUsEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String message;
  final String code;
  final String number;

  const TriggerContactUs({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.message,
    required this.code,
    required this.number,
  });

  @override
  List<Object?> get props =>
      [firstName, lastName, email, message, code, number];
}

class TriggerContactUsPageRefresh extends ContactUsEvent {}

class TriggerContactUsFirstNameCheck extends ContactUsEvent {
  final String firstName;

  const TriggerContactUsFirstNameCheck({required this.firstName});

  @override
  List<Object?> get props => [firstName];
}

class TriggerOnChangeContactUs extends ContactUsEvent {
  final String mobileNumber;
  final String code;

  const TriggerOnChangeContactUs(
      {required this.mobileNumber, required this.code});

  @override
  List<Object?> get props => [mobileNumber, code];
}

class TriggerContactUsLastNameCheck extends ContactUsEvent {
  final String lastName;

  const TriggerContactUsLastNameCheck({required this.lastName});

  @override
  List<Object?> get props => [lastName];
}

class TriggerContactUsMobileNumberCheck extends ContactUsEvent {
  final String mobileNumber;
  final int minLength;
  final bool isEmailValid;
  final bool isFirstNameValid;
  final bool isLastNameValid;
  final bool isMessageValid;
  final String firstName;
  final String lastName;
  final String email;
  final String message;
  final String code;


  const TriggerContactUsMobileNumberCheck({
    required this.isEmailValid,
    required this.isFirstNameValid,
    required this.isLastNameValid,
    required this.isMessageValid,
    required this.mobileNumber,
    required this.minLength,
    required this.firstName,
    required this.lastName,
    required this.email, required this.message, required this.code,
  });

  @override
  List<Object?> get props => [
        mobileNumber,
        minLength,
    isEmailValid, isFirstNameValid, isLastNameValid, isMessageValid,
    firstName, lastName, email, message, code
      ];
}

class TriggerContactUsEmailCheck extends ContactUsEvent {
  final String email;

  const TriggerContactUsEmailCheck({required this.email});

  @override
  List<Object?> get props => [email];
}

class TriggerContactUsMessageCheck extends ContactUsEvent {
  final String message;

  const TriggerContactUsMessageCheck({required this.message});

  @override
  List<Object?> get props => [message];
}
