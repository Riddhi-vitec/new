import 'package:flutter/material.dart';
import 'package:template_flutter_mvvm_repo_bloc/app_configuration/app_environments.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/resources/app_strings.dart';
import 'package:template_flutter_mvvm_repo_bloc/di/di.dart';
import 'package:template_flutter_mvvm_repo_bloc/presentation/authentication/change_password/page/change_password_view.dart';

import 'package:template_flutter_mvvm_repo_bloc/presentation/authentication/forgot_password/page/forgot_password_view.dart';
import 'package:template_flutter_mvvm_repo_bloc/presentation/authentication/otp_verification/page/otp_verification_view.dart';
import 'package:template_flutter_mvvm_repo_bloc/presentation/chat_view/page/chat_view.dart';
import 'package:template_flutter_mvvm_repo_bloc/presentation/contact_us/page/contact_us_view.dart';
import 'package:template_flutter_mvvm_repo_bloc/presentation/legal/page/foss_view.dart';
import 'package:template_flutter_mvvm_repo_bloc/presentation/legal/page/legal_view.dart';
import 'package:template_flutter_mvvm_repo_bloc/presentation/my_account/page/my_account_view.dart';

import 'package:template_flutter_mvvm_repo_bloc/presentation/navigator/page/navigator_view.dart';
import 'package:template_flutter_mvvm_repo_bloc/presentation/dashboard/page/dashboard_view.dart';
import 'package:template_flutter_mvvm_repo_bloc/presentation/notifications/page/notification_view.dart';

import 'package:template_flutter_mvvm_repo_bloc/presentation/splash/page/splash_view.dart';

import '../../presentation/app_settings/page/app_settings_view.dart';
import '../../presentation/authentication/otp_verification/page/otp_verification_view.dart';
import '../../presentation/authentication/sign_in/page/sign_in_view.dart';
import '../../presentation/authentication/sign_up/page/sign_up_view.dart';

import '../../imports/data.dart';
import '../../presentation/authentication/reset_password/page/reset_password_view.dart';
import '../../presentation/language_and_currency/page/language_and_currency_view.dart';
import '../../presentation/legal/page/foss_detail_view.dart';
import '../../presentation/legal/page/legals_subfeature_view.dart';
import '../../presentation/my_profile/delete_or_deactivate/page/delete_or_deactivate_view.dart';
import '../../presentation/my_profile/edit_profile/page/edit_profile_view.dart';
import '../../presentation/notifications/page/notification_detail_view.dart';
import '../../presentation/onboarding/page/onboarding_view.dart';

class RouteName {
  //property owner
  static const String routeSplash = '/';
  static const String routeOnboarding = '/onboarding-route';
  static const String routeSignIn = '/sign-in-route';
  static const String routeSignUp = '/sign-up-route';
  static const String routeResetPassword = '/reset-password-route';
  static const String routeParentNavigation = '/navigation-route';
  static const String routeDashboard = '/dashboard-route';
  static const String routeMyAccount = '/my-account-route';
  static const String routeAppSettings = '/app-settings-route';
  static const String routeEditProfile = '/edit-profile-route';
  static const String routeProfilePhoto = '/profile-photo-route';
  static const String routeChat = '/chat-route';
  static const String routeDeactivateAccount = '/deactivate-account-route';
  static const String routeLegals = '/legal-route';
  static const String routeFoss = '/legals/foss-route';
  static const String routeLegalsSubFeature = '/legals/legals-subfeature-route';
  static const String routeChangePassword = '/change-password-route';
  static const String routeContactUs = '/contact-us-route';
  static const String routeVerifyOtp = '/verify-otp-route';
  static const String routeForgotPassword = "/forgot-password-route";
  static const String routeRateUs = "/rate-us-route";
  static const String routeLanguageAndCurrency = "/language-and-currency";
  static const String routeFossDetailView = "/foss-detail-view-route";
  static const String routeNotification = "/notification-route";
  static const String routeNotificationDetail = "/notification-detail-route";
}

class Routes {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    // final Arguments args = routeSettings.arguments as Arguments;
    final args = routeSettings.arguments;

    switch (routeSettings.name) {
      case RouteName.routeSplash:
        initSplashModule();
        initAppSettingModule();
        return MaterialPageRoute(builder: (_) => const SplashView());
      case RouteName.routeSignIn:
        initAuthenticationModule();
        return MaterialPageRoute(builder: (_) => const SignInView());
      case RouteName.routeResetPassword:
        initAuthenticationModule();
        return MaterialPageRoute(
            builder: (_) => ResetPasswordView(
                  tokenExtractedFromEmail: args as String,
                ));
      case RouteName.routeForgotPassword:
        initAuthenticationModule();
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case RouteName.routeParentNavigation:
        initNavigatorModule();
        initProfileModule();
        initProductModule();
        return MaterialPageRoute(builder: (_) => const NavigatorView());
      case RouteName.routeMyAccount:
        return MaterialPageRoute(builder: (_) => MyAccountView());
      case RouteName.routeOnboarding:
        return MaterialPageRoute(builder: (_) =>  OnboardingView());
      case RouteName.routeLanguageAndCurrency:
        initLanguageAndCurrencyModule();
        return MaterialPageRoute(
            builder: (_) => const LanguageAndCurrencyView());
      case RouteName.routeVerifyOtp:
        initAuthenticationModule();
        return MaterialPageRoute(
            builder: (_) => OtpVerificationView(otpRequestModel: args as OtpRequestModel));
      case RouteName.routeDeactivateAccount:
        initProfileModule();
        return MaterialPageRoute(builder: (_) =>  DeleteOrDeactivateView());
      case RouteName.routeDashboard:
        return MaterialPageRoute(builder: (_) =>  DashBoardView());
      case RouteName.routeSignUp:
        initAuthenticationModule();
        return MaterialPageRoute(builder: (_) => const SignUpView());
      case RouteName.routeAppSettings:
        initAppSettingModule;
        return MaterialPageRoute(builder: (_) => const AppSettingsView());
      case RouteName.routeEditProfile:
        initProfileModule();
        return MaterialPageRoute(builder: (_) => const EditProfileView());
      case RouteName.routeNotification:
        initNotificationModule();
        return MaterialPageRoute(builder: (_) => NotificationView());
      case RouteName.routeNotificationDetail:
        initNotificationModule();
        return MaterialPageRoute(builder: (_) => const NotificationDetailView());
      case RouteName.routeChat:
        return MaterialPageRoute(builder: (_) => const ChatView());


      case RouteName.routeChangePassword:
        initAuthenticationModule();
        return MaterialPageRoute(builder: (_) => ChangePasswordView());
      case RouteName.routeContactUs:
        initContactUsModule();
        return MaterialPageRoute(builder: (_) => const ContactUsView());
      case RouteName.routeLegals:
        initLegalModule();
        return MaterialPageRoute(builder: (_) => LegalView());
      case RouteName.routeFoss:
        return MaterialPageRoute(builder: (_) => const FossView());
      case RouteName.routeFossDetailView:
        return MaterialPageRoute(
            builder: (_) => FossDetailView(licenceDetails: args as Map));
      case RouteName.routeLegalsSubFeature:
        return MaterialPageRoute(
            builder: (_) =>
                LegalsSubFeatureView(legalsData: args as LegalsData));
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: Text(AppEnvironments.appName),
              ),
              body: const Center(
                child: Text(AppStrings.routName_defaultRoute_title),
              ),
            ));
  }
}
