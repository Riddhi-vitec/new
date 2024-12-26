import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:template_flutter_mvvm_repo_bloc/presentation/onboarding/bloc/onboarding_bloc.dart';

import '../../../di/di.dart';
import '../../../imports/common.dart';
import '../widgets/Carousel.dart';

class OnboardingView extends StatefulWidget {
  OnboardingView({Key? key}) : super(key: key);

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView>
    with TickerProviderStateMixin {
  final OnboardingBloc onboardingBloc = instance<OnboardingBloc>();

  @override
  void initState() {
    onboardingBloc.add(TriggerOnboardingInitialization(this));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => onboardingBloc,
      child: BlocBuilder<OnboardingBloc, OnboardingWithInitialsState>(
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ConcentricPageView(
                  colors: state.carouselDataList
                      .map((carousel) => carousel.bgColor)
                      .toList(),
                  radius: getScreenWidth(context: context) * 0.7,
                  onFinish: () {
                    Navigator.pushNamed(context, RouteName.routeSignIn);
                  },
                  scaleFactor: 0.2,
                  verticalPosition: 0.7,
                  itemBuilder: (index) {
                    final page = state.carouselDataList[
                        index % state.carouselDataList.length];
                    return SafeArea(
                      child: Carousel(carouselModel: page),
                    );
                  },
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.routeSignIn);
                  },
                  child: Container(
                    height: 100.h,
                    margin: EdgeInsets.only(bottom: 50.h),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.onboarding_getStartedBtn,
                          style: Style.appBarTitleStyle(
                              color: AppColor.colorWarning),
                        ),
                        if(state.animation != null)
                        AnimatedIcon(
                          icon: AnimatedIcons.play_pause,
                          progress: state.animation!,
                          color: AppColor.colorWarning,
                          size: 25.h,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
