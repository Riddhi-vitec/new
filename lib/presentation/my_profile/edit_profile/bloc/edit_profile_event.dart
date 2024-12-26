part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object?> get props => [];
}

class TriggerFillUpFieldsEvent extends EditProfileEvent {}

class TriggerValidateBirthday extends EditProfileEvent {
  final String value;

  const TriggerValidateBirthday({required this.value});

  @override
  List<Object?> get props => [value];
}

class TriggerUpdateProfile extends EditProfileEvent {
  final String firstName;
  final String lastName;
  final String birthday;
  final String mobileCode;
  final String mobileNumber;
  final String address;

  final File? imageFile;

  const TriggerUpdateProfile({
    required this.firstName,
    required this.lastName,
    required this.birthday,
    required this.mobileCode,
    required this.mobileNumber,
    required this.address,
    required this.imageFile,
  });

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        address,
        birthday,
        mobileNumber,
        birthday,
        mobileCode,
        imageFile
      ];
}

class TriggerUpdateBirthday extends EditProfileEvent {
  final BuildContext context;

  const TriggerUpdateBirthday({required this.context});

  @override
  List<Object?> get props => [context];
}

class TriggerFirstNameValidation extends EditProfileEvent {
  final String firstName;

  const TriggerFirstNameValidation({required this.firstName});

  @override
  List<Object?> get props => [firstName];
}

class TriggerOnChangeMobileNumber extends EditProfileEvent {
  final String mobileNumber;
  final String code;

  const TriggerOnChangeMobileNumber(
      {required this.mobileNumber, required this.code});

  @override
  List<Object?> get props => [mobileNumber, code];
}

class TriggerLastNameValidation extends EditProfileEvent {
  final String lastName;

  const TriggerLastNameValidation({required this.lastName});

  @override
  List<Object?> get props => [lastName];
}

class TriggerFocusFields extends EditProfileEvent {
  final bool hasMobileFieldFocus;

  const TriggerFocusFields({
    required this.hasMobileFieldFocus,
  });

  @override
  List<Object?> get props => [
        hasMobileFieldFocus,
      ];
}

class TriggerMobileNumberValidation extends EditProfileEvent {
  final String mobileNumber;
  final int minLength;

  final bool isFirstNameValid;
  final bool isLastNameValid;
  final bool isAddressValid;

  final String firstName;
  final String lastName;
  final String birthday;

  final String address;
  final String code;

  final GlobalKey<FormState> formKeyForScaffold;

  const TriggerMobileNumberValidation({
    required this.address,
    required this.isAddressValid,
    required this.isFirstNameValid,
    required this.isLastNameValid,
    required this.birthday,
    required this.formKeyForScaffold,
    required this.mobileNumber,
    required this.minLength,
    required this.firstName,
    required this.lastName,
    required this.code,
  });

  @override
  List<Object?> get props => [
        mobileNumber,
        minLength,
        isFirstNameValid,
        isLastNameValid,
        isAddressValid,
        birthday,
        firstName,
        lastName,
        address,
        code
      ];
}

class TriggerEmailValidation extends EditProfileEvent {
  final String email;

  const TriggerEmailValidation({required this.email});

  @override
  List<Object?> get props => [email];
}

class TriggerAddressValidation extends EditProfileEvent {
  final String address;

  const TriggerAddressValidation({required this.address});

  @override
  List<Object?> get props => [address];
}

class TriggerImagePickerEvent extends EditProfileEvent {
  final bool isFromCamera;

  const TriggerImagePickerEvent({this.isFromCamera = false});

  @override
  List<Object?> get props => [isFromCamera];
}

class TriggerChangeEmailEvent extends EditProfileEvent {
  final String email;
  final bool isForValidation;

  const TriggerChangeEmailEvent(
      {required this.email, required this.isForValidation});

  @override
  List<Object?> get props => [email, isForValidation];
}

class TriggerGetUserEmail extends EditProfileEvent {}
