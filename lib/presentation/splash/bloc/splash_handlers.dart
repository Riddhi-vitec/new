
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:template_flutter_mvvm_repo_bloc/presentation/splash/bloc/splash_bloc.dart';

import '../../../imports/common.dart';
import '../../../imports/services.dart';
import '../../../root_app.dart';

handleNoDynamicLink({ required Emitter<SplashState> emit, required OnboardingData onboardingData, required AuthenticationData authenticationData}) async {

  bool isOnboardedFirstTime = await onboardingData.isOnboardingFirstTime();
  bool isUserLoggedIn = await authenticationData.isUserSignedIn();

  if (isOnboardedFirstTime) {
    emit(SplashToOnboarding());
    onboardingData.setOnboardingFirstTime(value: false);
    _navigateToRoute(RouteName.routeOnboarding, );
  } else {
    if (isUserLoggedIn) {
      emit(SplashToDashBoardView());
      _navigateToRoute(RouteName.routeParentNavigation, );
    } else {
      emit(SplashToSignInView());
      _navigateToRoute(RouteName.routeSignIn, );
    }
  }
}

void _navigateToRoute(String routeName,) {
  BuildContext context = navigatorKey.currentState!.context;
  if (context.mounted) {
    Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);
  }
}