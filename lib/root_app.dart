import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:path_provider/path_provider.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:month_year_picker/month_year_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'package:flutter_localizations/flutter_localizations.dart';
import 'app_configuration/app_environments.dart';


import 'di/di.dart';


import 'firebase_options.dart';
import 'imports/common.dart';
import 'imports/services.dart';
import 'presentation/language_and_currency/bloc/global_settings_bloc.dart';



Future<void>  mainDelegateForEnvironments() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseCloudMessage().setUpNotificationServiceForOS(isCalledFromBg: true);
  await ScreenUtil.ensureScreenSize();
  await IsarHelpers.initializeDatabase();
  const fatalError = true;

  debugPrint("Env is ${AppEnvironments.environments}");
  if (await _appSettingsRecord.isCrashCollectionActive()) {
    // Non-async exceptions
    FlutterError.onError = (errorDetails) {
      if (fatalError) {
        // If you want to record a "fatal" exception
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
        // ignore: dead_code
      } else {
        // If you want to record a "non-fatal" exception
        FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
      }
    };
    // Async exceptions
    PlatformDispatcher.instance.onError = (error, stack) {
      if (fatalError) {
        // If you want to record a "fatal" exception
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        // ignore: dead_code
      } else {
        // If you want to record a "non-fatal" exception
        FirebaseCrashlytics.instance.recordError(error, stack);
      }
      return true;
    };
  }
  // FirebaseCrashlytics.instance.crash();
  //open isar for getting the dir path
  // final dir = await getApplicationDocumentsDirectory();
  // isar = Isar.open(
  //   [BookSchema],  /// we got this from build_runner - generated code
  //   directory: dir.path,
  // );

  Stripe.publishableKey='pk_test_51OBsT8LermSLISYer0L76Ven3Y0EZullsN4q7lVojdiSouJNJvtunYpJpHZwPZrJP8Uv9WpbwlSj5jhNxLWruRO900UcGEx1Yg';
  runApp( RootApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final AppSettingsData _appSettingsRecord = instance<AppSettingsData>();
final botToastBuilder = BotToastInit();

class RootApp extends StatefulWidget {
  const RootApp._internal();

  static const RootApp instance = RootApp._internal();

  factory RootApp() => instance;

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  final GlobalSettingsBloc _languageAndCurrencyBloc = instance<GlobalSettingsBloc>();

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      //ColorManager.white
      statusBarIconBrightness: Brightness.dark,
      // Brightness.light, /
      systemNavigationBarColor: AppColor.colorPrimaryInverse,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ));
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      ResetPasswordDynamicLinkServices
          .resetDynamicLinkOnBackgroundOrForeground();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _languageAndCurrencyBloc..add(TriggerCheckForLanguageAndCurrency()),
      child: BlocBuilder<GlobalSettingsBloc, GlobalSettingsWithInitialState>(
        builder: (context, state) {
          return MaterialApp(
            localizationsDelegates:  const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              MonthYearPickerLocalizations.delegate,
            ],
            locale: Locale(state.language),
            supportedLocales: const [
              Locale('en'), // English
              Locale('de'), // German
            ],
            theme: ThemeData(
                // you can decide app bar themes here
                ),
            debugShowCheckedModeBanner: AppEnvironments.debugBannerBoolean,
            builder: (ctx, child) {
              ScreenUtil.init(ctx);
              child = botToastBuilder(context, child);
              return ResponsiveBreakpoints.builder(
                child: child,
                breakpoints: [
                  const Breakpoint(start: 0, end: 450, name: MOBILE),
                  const Breakpoint(start: 451, end: 800, name: TABLET),
                  const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                  const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
                ],
              );
            },
            initialRoute: RouteName.routeSplash,
            onGenerateRoute: Routes.getRoute,
            title: AppEnvironments.appName,
            navigatorKey: navigatorKey,
          );
        },
      ),
    );
  }
}