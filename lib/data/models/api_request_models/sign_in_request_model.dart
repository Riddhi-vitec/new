class SignInRequestModel {
  final String email,socialId, password,socialType;
  final bool isEmailVerified, isSocial;

  SignInRequestModel({
    required this.email,
    required this.socialId,
    required this.socialType,
    required this.isSocial,
    required this.password,
    required this.isEmailVerified,
  });
}


