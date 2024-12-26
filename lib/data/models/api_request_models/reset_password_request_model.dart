class ResetPasswordRequestModel {
  final String resetPasswordToken,newPassword;

  const ResetPasswordRequestModel(
      {required this.resetPasswordToken, required this.newPassword});
}
