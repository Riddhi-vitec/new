import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:template_flutter_mvvm_repo_bloc/di/di.dart';
import 'package:template_flutter_mvvm_repo_bloc/presentation/splash/bloc/splash_bloc.dart';

import '../../../imports/common.dart';
import '../../../imports/services.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final SplashBloc _splashBloc = instance<SplashBloc>();
  FirebaseCloudMessage fcmMessageService = FirebaseCloudMessage();

  @override
  void initState() {
    super.initState();
    DeviceInfoPlugin().deviceInfo.then((value) {});
    retrieveFcmApnsTokens();
    fcmMessageService.setUpNotificationServiceForOS(isCalledFromBg: false);
  }
  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _splashBloc..add(const TriggerSplashScreenOpen()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashEndState) {
            _splashBloc.add(const TriggerCheckForDynamic());
          }
        },
        child: BlocBuilder<SplashBloc, SplashState>(
          builder: (context, state) {
            return Scaffold(
                backgroundColor: AppColor.colorPrimaryInverse,
                // make sure to customise your color according to Figma
                body: Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                        child: Image.asset(
                          Assets.imgSplash,
                          width: 100.w,
                        ))
                        .animate()
                        .fadeIn(duration: 200.ms)
                        .then(delay: 100.ms)
                        .slideX(end: -0.2, duration: 300.ms)
                        .then(delay: 200.ms)
                        .slideX(end: 0.2)
                        .then(delay: 100.ms)
                        .scaleXY(end: 3, duration: 100.ms)
                        .then(delay: 100.ms),
                    Positioned(
                      bottom: 5.h,
                      child: Text(
                        AppStrings.splash_title,
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(fontWeight: FontWeight.bold, color: AppColor.colorPrimary),
                      ),
                    )
                  ],
                ));
          },
        ),
      ),
    );
  }
}
