part of 'onboarding_bloc.dart';

@freezed
class OnboardingWithInitialsState with _$OnboardingWithInitialsState {
  const factory OnboardingWithInitialsState({
    required List<CarouselModel> carouselDataList,
    required bool isLoading,
    required bool isFailure,
    required AnimationController? controller,
    required Animation<double>? animation,
  }) = _OnboardingWithInitialsState;

  factory OnboardingWithInitialsState.initial() => OnboardingWithInitialsState(
        carouselDataList:  [
          CarouselModel(
            subTitle: AppStrings.onboarding_firstCarousel_subtitle,
            title: AppStrings.onboarding_firstCarousel_title,
            bgColor: AppColor.colorPrimary,
            image: Assets.icOnboardingFirstCarousel,
            textColor: AppColor.colorPrimaryTextInverse,
          ),
          CarouselModel(
            subTitle: AppStrings.onboarding_secondCarousel_subtitle,
            title: AppStrings.onboarding_secondCarousel_title,
            bgColor: AppColor.colorAccent,
            image: Assets.icOnboardingSecondCarousel,
            textColor: AppColor.colorPrimaryText,
          ),
          CarouselModel(
            subTitle: AppStrings.onboarding_thirdCarousel_subtitle,
            title: AppStrings.onboarding_thirdCarousel_title,
            bgColor: AppColor.colorPrimaryInverse,
            image: Assets.icOnboardingThirdCarousel,
            textColor: AppColor.colorPrimaryText,
          ),
        ],
        isFailure: false,
        isLoading: false,
        controller: null,
        animation: null,

      );
}

class CarouselModel {
  final String image;
  final String title;
  final String subTitle;
  final Color bgColor;
  final Color textColor;

  CarouselModel(
      {required this.image,
      required this.title,
      required this.subTitle,
      required this.textColor,
      required this.bgColor});
}
