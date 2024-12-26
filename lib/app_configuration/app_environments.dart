import 'package:template_flutter_mvvm_repo_bloc/app_configuration/app_environment_variables.dart';

import '../imports/common.dart';


class AppEnvironments{
  static Map<String, dynamic>? information;
  static Environment? environments;
  static get baseUrl => information?[AppEnvironmentVariables.baseURL];
  static get baseWebUrl => information?[AppEnvironmentVariables.baseWebURL];
  static get socketUrl => information?[AppEnvironmentVariables.socketUrl];
  static get appName => information?[AppEnvironmentVariables.appName];
  static get appTitle => information?[AppEnvironmentVariables.appTitle];
  static get debugBannerBoolean => information?[AppEnvironmentVariables.debugBannerBoolean];
  static get stripePublishableKey => information?[AppEnvironmentVariables.stripePublishableKey];
  static get iOSBundleID => information?[AppEnvironmentVariables.iOSBundleID];
  static void setUpEnvironments(Environment env){
    switch(env){
      case Environment.dev:
        information = AppEnvironmentVariables.dev;
        environments = Environment.dev;
        break;
      case Environment.prod:
        information = AppEnvironmentVariables.prod;
        environments = Environment.prod;
        break;
    }
  }
}