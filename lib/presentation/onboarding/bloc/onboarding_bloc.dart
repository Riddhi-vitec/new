import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../imports/common.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';
part 'onboarding_bloc.freezed.dart';


class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingWithInitialsState> {
  late AnimationController controller;
  late Animation<double> animation;

  OnboardingBloc() : super(OnboardingWithInitialsState.initial()) {
    on<TriggerOnboardingInitialization>(_onTriggerOnboardingInitialization);
  }


  FutureOr<void> _onTriggerOnboardingInitialization(
      TriggerOnboardingInitialization event,
      Emitter<OnboardingWithInitialsState> emit) {
    emit(state.copyWith(isLoading: true));
    controller = AnimationController(
      vsync: event.vsync,
      duration: const Duration(seconds: 3),
    )
      ..forward()
      ..repeat(reverse: true);
    animation = Tween<double>(begin: 0, end: 2).animate(controller);
    print('Heyy $controller $animation');
    emit(state.copyWith(
      controller: controller,
      animation: animation,
      isLoading: false,
    ));
  }
}
