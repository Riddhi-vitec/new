part of 'splash_bloc.dart';

@immutable
abstract class SplashState extends Equatable{
  const SplashState();
  @override
  List<Object?> get props => [];
}

class SplashInitial extends SplashState {}
class SplashStartState extends SplashState {}
class SplashEndState extends SplashState {}
class SplashToOnboarding extends SplashState {}
class SplashToResetView extends SplashState {}
class SplashToDashBoardView extends SplashState {}
class SplashToSignInView extends SplashState {}
