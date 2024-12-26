part of 'onboarding_bloc.dart';

@immutable
abstract class OnboardingEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class TriggerOnboardingInitialization extends OnboardingEvent{
  final TickerProvider vsync;
  TriggerOnboardingInitialization(this.vsync);
  @override
  List<Object?> get props => [vsync];
}