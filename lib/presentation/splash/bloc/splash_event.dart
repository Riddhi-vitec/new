part of 'splash_bloc.dart';

@immutable
abstract class SplashEvent extends Equatable{
  const SplashEvent();
  @override

  List<Object?> get props => [];
}

class TriggerSplashScreenOpen extends SplashEvent{

  const TriggerSplashScreenOpen();
  @override

  List<Object?> get props => [];
}

class TriggerCheckForDynamic extends SplashEvent{

  const TriggerCheckForDynamic();
  @override

  List<Object?> get props => [];
}