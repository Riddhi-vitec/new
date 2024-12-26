import 'package:template_flutter_mvvm_repo_bloc/app_configuration/app_environments.dart';

class UrlPrefixes {
  static  String baseUrl = AppEnvironments.baseUrl;
  static  String baseWebUrl = AppEnvironments.baseWebUrl;

  static const String stripeTokenUrl = "https://api.stripe.com/v1/tokens";
}

class UrlSuffixes{
  //Example
  static const String dummy_api = "/dummy-api";
  static const String otp = "/auth/verify-otp";
  static const String signOut = "/logout";
  static const String verifyOtp = "/auth/verify-otp";
  static const String forgotPassword = "/auth/forgot-password";
  static const String resetPassword = '/auth/reset-password';
  static const String signIn = '/auth/login';
  static const String socialSignIn = '/auth/social-login';
  static const String signUp = '/auth/register';
  static const String refreshToken = '/auth/refresh-token';
  static const String getProfile = '/profile';
  static const String changePassword = '/change-password';
  static const String contactUs = '/contact-us';
  static const String getCms = '/legal-pages';
  static const String getNotification = '/notification';
  static const String readNotification = '/notification?id=';

  static const String updateProfile = '/update-profile';


  static const String changeEmail = '/change-email';
  static const String deleteAccount = '/delete-account';
  static const String deletionVerification = '/delete-account?otp=';
}