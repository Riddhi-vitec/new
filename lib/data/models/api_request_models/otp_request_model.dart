class OtpRequestModel {

  final String fullName, email, password, otp, deviceType, deviceToken;
  final bool isChangeEmail, isSocialAccountVerification, isAccountDeletion;
  final String? socialId, socialType;

  OtpRequestModel({
    required this.isChangeEmail,
    required this.fullName,
    required this.email,
    required this.password,
    required this.otp,
    required this.deviceType,
    required this.deviceToken,
    required this.isSocialAccountVerification,
    required this.socialId,
    required this.socialType,required this.isAccountDeletion,
  });
}
