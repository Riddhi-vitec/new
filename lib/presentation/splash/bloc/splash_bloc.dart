import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

import 'package:template_flutter_mvvm_repo_bloc/di/di.dart';
import 'package:template_flutter_mvvm_repo_bloc/presentation/splash/bloc/splash_handlers.dart';

import '../../../services/reset_password_dynamic_link.dart';
import '../../../services/share_preferences_services/authentication_data.dart';
import '../../../services/share_preferences_services/onboarding_data.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final OnboardingData onboardingData = instance<OnboardingData>();
  final AuthenticationData authenticationData = instance<AuthenticationData>();

  PendingDynamicLinkData? pendingDynamicLinkData;

  SplashBloc() : super(SplashInitial()) {
    on<TriggerSplashScreenOpen>(_onTriggerSplashScreenOpen);
    on<TriggerCheckForDynamic>(_onTriggerCheckForDynamic);
  }

  FutureOr<void> _onTriggerSplashScreenOpen(
      TriggerSplashScreenOpen event, Emitter<SplashState> emit) async {
    emit(SplashStartState());
    //Duration should be decided with the PM
    await Future.delayed(const Duration(seconds: 4), () {
      emit(SplashEndState());
    });
  }

  FutureOr<void> _onTriggerCheckForDynamic(
      TriggerCheckForDynamic event, Emitter<SplashState> emit) async {
    pendingDynamicLinkData = await ResetPasswordDynamicLinkServices
        .resetDynamicLinkFromTerminatedState();
    if (pendingDynamicLinkData?.link == null) {
      await handleNoDynamicLink(
          authenticationData: authenticationData,
          onboardingData: onboardingData,
          emit: emit);
    } else {
      final Uri deepLink = pendingDynamicLinkData!.link;
      emit(SplashToResetView());
      ResetPasswordDynamicLinkServices
          .resetDynamicLinkObtainedFromTerminatedState(deepLink: deepLink);
    }
  }
}
