part of 'my_account_bloc.dart';

@freezed
class MyAccountWithInitialState with _$MyAccountWithInitialState {
  const factory MyAccountWithInitialState({
    required String fullName,
    required String email,
    required String phone,
    required String cachedNetworkImageUrl,
    required SignedInUserResponseModel? signedInUserResponseModel,
    required String message,
    required bool isFailure,
    required bool isLoadingForUserInfo,
    required bool isLoadingForLogout,
    required bool isLogout,
    required List<MyAccountMenuModel> myAccountMenuModelList,
  }) = _MyAccountWithInitialState;

  factory MyAccountWithInitialState.initial() =>
      MyAccountWithInitialState(
        message: '',
        isFailure: false,
        isLoadingForUserInfo: true,
        isLogout: false,
        email: '',
        cachedNetworkImageUrl: '',
        fullName: '',
        myAccountMenuModelList: [  MyAccountMenuModel(
          iconUrl: Assets.icEditProfile,
          routeName: RouteName.routeEditProfile,
          menuTitle: AppStrings.myAccount_menu_editProfileBtn,
        ),  MyAccountMenuModel(
          iconUrl: Assets.icChangePassword,
          routeName: RouteName.routeChangePassword,
          menuTitle: AppStrings.myAccount_menu_changePasswordBtn,
        ),
          MyAccountMenuModel(
            iconUrl: Assets.icPayHistory,
            routeName: '',
            menuTitle: AppStrings.myAccount_menu_paymentHistoryBtn,
          ),
          MyAccountMenuModel(
            iconUrl: Assets.icPaymentMethod,
            routeName: '',
            menuTitle: AppStrings.myAccount_menu_paymentMethodBtn,
          ),
          MyAccountMenuModel(
            iconUrl: Assets.icLanguage,
            routeName: RouteName.routeLanguageAndCurrency,
            menuTitle:  AppStrings.myAccount_menu_languageAndurrencyBtn,
          ),
          MyAccountMenuModel(
            iconUrl: Assets.icAppSettings,
            routeName: RouteName.routeAppSettings,
            menuTitle: AppStrings.myAccount_menu_appSettingsBtn,
          ),
          MyAccountMenuModel(
            iconUrl: Assets.icContactUs,
            routeName: RouteName.routeContactUs,
            menuTitle:  AppStrings.myAccount_menu_contactUsBtn,
          ),
          MyAccountMenuModel(
            iconUrl: Assets.icLegals,
            routeName: RouteName.routeLegals,
            menuTitle: AppStrings.myAccount_menu_legalsBtn,
          ),
          MyAccountMenuModel(
            iconUrl: Assets.icRateUs,
            routeName: RouteName.routeRateUs,
            menuTitle: AppStrings.myAccount_menu_rateUsBtn,
          ),],
        phone: '',
        isLoadingForLogout: false,
        signedInUserResponseModel: null,
      );
}

class MyAccountMenuModel{
  String menuTitle;
  String routeName;
  String iconUrl;
  MyAccountMenuModel({required this.iconUrl, required this.routeName, required this.menuTitle});
}