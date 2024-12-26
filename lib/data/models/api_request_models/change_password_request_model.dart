class ChangePasswordRequestModel {
  final String oldPassword;
  final String password;

  const ChangePasswordRequestModel({
    required this.oldPassword,
    required this.password,
  });
}
