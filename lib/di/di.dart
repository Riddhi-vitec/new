import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template_flutter_mvvm_repo_bloc/presentation/authentication/otp_verification/bloc/otp_verification_bloc.dart';

import 'package:template_flutter_mvvm_repo_bloc/presentation/contact_us/bloc/contact_us_bloc.dart';
import 'package:template_flutter_mvvm_repo_bloc/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:template_flutter_mvvm_repo_bloc/presentation/language_and_currency/bloc/global_settings_bloc.dart';
import 'package:template_flutter_mvvm_repo_bloc/presentation/legal/bloc/legals_bloc.dart';
import 'package:template_flutter_mvvm_repo_bloc/presentation/my_account/bloc/my_account_bloc.dart';
import 'package:template_flutter_mvvm_repo_bloc/presentation/my_profile/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:template_flutter_mvvm_repo_bloc/presentation/my_products/bloc/my_products_bloc.dart';
import 'package:template_flutter_mvvm_repo_bloc/presentation/navigator/bloc/navigators_bloc.dart';
import 'package:template_flutter_mvvm_repo_bloc/presentation/notifications/bloc/notification_bloc.dart';
import 'package:template_flutter_mvvm_repo_bloc/presentation/onboarding/bloc/onboarding_bloc.dart';

import 'package:template_flutter_mvvm_repo_bloc/presentation/splash/bloc/splash_bloc.dart';

import '../imports/data.dart';
import '../imports/usecase.dart';
import '../presentation/authentication/authentication_bloc/authentication_bloc.dart';
import '../presentation/authentication/reset_password/bloc/reset_password_bloc.dart';

import '../presentation/app_settings/bloc/app_settings_bloc.dart';

import '../imports/services.dart';

import '../presentation/authentication/forgot_password/bloc/forgot_password_bloc.dart';
import '../presentation/my_profile/delete_or_deactivate/bloc/delete_or_deactivate_bloc.dart';

final instance = GetIt.instance;
//init modules should register corresponding repository, services, and blocs
Future<void> initAppModule() async {
  SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  instance.registerLazySingleton<HttpConnectionInfoServices>(
      () => HttpConnectionEstablishment());
  IsarHelpers isarHelpers = IsarHelpers();
  instance.registerLazySingleton<IsarHelpers>(() => isarHelpers);
  instance.registerLazySingleton<ProductDataBaseSource>(
      () => ProductDataBaseSource());
  instance.registerLazySingleton<SocketService>(() => SocketService());
  instance
      .registerLazySingleton<OnboardingData>(() => OnboardingData(instance()));
  instance.registerLazySingleton<UserData>(() => UserData(instance()));
  instance
      .registerLazySingleton<GlobalSettingsBloc>(() => GlobalSettingsBloc());
  instance.registerLazySingleton<AuthenticationData>(
      () => AuthenticationData(instance()));
  instance.registerLazySingleton<AppSettingsData>(
      () => AppSettingsData(instance()));
  instance.registerLazySingleton<CurrencySettingsData>(
      () => CurrencySettingsData(instance()));
  instance.registerLazySingleton<LanguageSettingsData>(
      () => LanguageSettingsData(instance()));
  instance.registerLazySingleton<AppSettingsBloc>(() => AppSettingsBloc());
  instance.registerLazySingleton<OnboardingBloc>(() => OnboardingBloc());
  initProfileModule();
} //For entire app

Future<void> initSplashModule() async {
  if (!GetIt.I.isRegistered<SplashBloc>()) {
    instance.registerFactory<SplashBloc>(() => SplashBloc());
  }
} //For splash screen

Future<void> initAuthenticationModule() async {
  if (!GetIt.I.isRegistered<SignInUseCase>()) {
    instance.registerFactory<SignInUseCase>(() => SignInUseCase());
  }
  if (!GetIt.I.isRegistered<SignUpUseCase>()) {
    instance.registerFactory<SignUpUseCase>(() => SignUpUseCase());
  }
  if (!GetIt.I.isRegistered<ChangePasswordUseCase>()) {
    instance
        .registerFactory<ChangePasswordUseCase>(() => ChangePasswordUseCase());
  }

  if (!GetIt.I.isRegistered<AuthenticationBloc>()) {
    instance.registerFactory<AuthenticationBloc>(() => AuthenticationBloc(
        signInUseCase: instance(),
        signUpUseCase: instance(),
        changePasswordUseCase: instance()));
  }

  if (!GetIt.I.isRegistered<VerifyOtpUseCase>()) {
    instance.registerFactory<VerifyOtpUseCase>(() => VerifyOtpUseCase());
  }
  if (!GetIt.I.isRegistered<ForgotPasswordUseCase>()) {
    instance
        .registerFactory<ForgotPasswordUseCase>(() => ForgotPasswordUseCase());
  }

  if (!GetIt.I.isRegistered<ForgotPasswordBloc>()) {
    instance.registerFactory<ForgotPasswordBloc>(
        () => ForgotPasswordBloc(instance()));
  }
  if (!GetIt.I.isRegistered<ResetPasswordUseCase>()) {
    instance
        .registerFactory<ResetPasswordUseCase>(() => ResetPasswordUseCase());
  }
  if (!GetIt.I.isRegistered<ResetPasswordBloc>()) {
    instance.registerFactory<ResetPasswordBloc>(
        () => ResetPasswordBloc(instance()));
  }
  if (!GetIt.I.isRegistered<AuthenticationBloc>()) {
    instance.registerFactory<AuthenticationBloc>(() => AuthenticationBloc(
        signInUseCase: instance(),
        signUpUseCase: instance(),
        changePasswordUseCase: instance()));
  }

  if (!GetIt.I.isRegistered<OtpVerificationBloc>()) {
    instance.registerFactory<OtpVerificationBloc>(
        () => OtpVerificationBloc(instance(), instance()));
  }
}

Future<void> initAppSettingModule() async {
  if (!GetIt.I.isRegistered<AppSettingsBloc>()) {
    instance.registerFactory<AppSettingsBloc>(() => AppSettingsBloc());
  }
}

Future<void> initNotificationModule() async {
  if (!GetIt.I.isRegistered<NotificationUseCase>()) {
    instance.registerFactory<NotificationUseCase>(() => NotificationUseCase());
  }
  if (!GetIt.I.isRegistered<ReadNotificationUseCase>()) {
    instance.registerFactory<ReadNotificationUseCase>(
        () => ReadNotificationUseCase());
  }
  if (!GetIt.I.isRegistered<NotificationBloc>()) {
    instance.registerFactory<NotificationBloc>(
        () => NotificationBloc(instance(), instance()));
  }
}

Future<void> initNavigatorModule() async {
  if (!GetIt.I.isRegistered<NotificationUseCase>()) {
    instance.registerFactory<NotificationUseCase>(() => NotificationUseCase());
  }
  if (!GetIt.I.isRegistered<NavigatorsBloc>()) {
    instance.registerFactory<NavigatorsBloc>(() => NavigatorsBloc(instance()));
  }
  if (!GetIt.I.isRegistered<ProfileUseCase>()) {
    instance.registerFactory<ProfileUseCase>(() => ProfileUseCase());
  }
  if (!GetIt.I.isRegistered<DashboardBloc>()) {
    instance.registerFactory<DashboardBloc>(() => DashboardBloc(instance()));
  }
  if (!GetIt.I.isRegistered<SignOutUseCase>()) {
    instance.registerFactory<SignOutUseCase>(() => SignOutUseCase());
  }
  if (!GetIt.I.isRegistered<MyAccountBloc>()) {
    instance.registerFactory<MyAccountBloc>(
        () => MyAccountBloc(instance(), instance()));
  }
}

Future<void> initProfileModule() async {
  if (!GetIt.I.isRegistered<EditProfileUseCase>()) {
    instance.registerFactory<EditProfileUseCase>(() => EditProfileUseCase());
  }
  if (!GetIt.I.isRegistered<ChangeEmailUseCase>()) {
    instance.registerFactory<ChangeEmailUseCase>(() => ChangeEmailUseCase());
  }
  if (!GetIt.I.isRegistered<EditProfileBloc>()) {
    instance.registerFactory<EditProfileBloc>(
        () => EditProfileBloc(instance(), instance()));
  }
  if (!GetIt.I.isRegistered<DeleteAccountUseCase>()) {
    instance
        .registerFactory<DeleteAccountUseCase>(() => DeleteAccountUseCase());
  }
  if (!GetIt.I.isRegistered<DeletionVerificationUseCase>()) {
    instance.registerFactory<DeletionVerificationUseCase>(
        () => DeletionVerificationUseCase());
  }
  if (!GetIt.I.isRegistered<DeleteOrDeactivateBloc>()) {
    instance.registerFactory<DeleteOrDeactivateBloc>(
        () => DeleteOrDeactivateBloc(instance()));
  }
}

Future<void> initProductModule() async {
  if (!GetIt.I.isRegistered<MyProductsBloc>()) {
    instance.registerFactory<MyProductsBloc>(() => MyProductsBloc());
  }
}

Future<void> initContactUsModule() async {
  if (!GetIt.I.isRegistered<ContactUsUseCase>()) {
    instance.registerFactory<ContactUsUseCase>(() => ContactUsUseCase());
  }
  if (!GetIt.I.isRegistered<ContactUsBloc>()) {
    instance.registerFactory<ContactUsBloc>(() => ContactUsBloc(instance()));
  }
}

Future<void> initLegalModule() async {
  if (!GetIt.I.isRegistered<LegalsUseCase>()) {
    instance.registerFactory<LegalsUseCase>(() => LegalsUseCase());
  }
  if (!GetIt.I.isRegistered<LegalsBloc>()) {
    instance.registerFactory<LegalsBloc>(() => LegalsBloc(instance()));
  }
}

Future<void> initLanguageAndCurrencyModule() async {
  if (!GetIt.I.isRegistered<GlobalSettingsBloc>()) {
    instance.registerFactory<GlobalSettingsBloc>(() => GlobalSettingsBloc());
  }
}
