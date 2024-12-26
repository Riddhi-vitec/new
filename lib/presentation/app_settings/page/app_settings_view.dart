import 'package:app_settings/app_settings.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:notification_permissions/notification_permissions.dart';

import '../../../common/widgets/custom_card_with_toggle_button.dart';
import '../../../imports/common.dart';
import '../../../di/di.dart';

import '../bloc/app_settings_bloc.dart';

class AppSettingsView extends StatefulWidget {
  const AppSettingsView({super.key});

  @override
  State<AppSettingsView> createState() => _AppSettingsViewState();
}

class _AppSettingsViewState extends State<AppSettingsView>
    with WidgetsBindingObserver {
  final AppSettingsBloc _appSettingsBloc = instance<AppSettingsBloc>();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _appSettingsBloc.add(TriggerNotificationAndLocationPermissionEvent());
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _appSettingsBloc.add(TriggerFetchActivatedSwitches());
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;

    return BlocConsumer<AppSettingsBloc, AppSettingsWithInitialState>(
        bloc: _appSettingsBloc..add(TriggerFetchActivatedSwitches()),
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColor.colorPrimaryInverse,
            appBar: const CustomAppBar(
                centerTitle: false, title: AppStrings.myAccount_appSettings_screen_title),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  horizontal: screenHPadding, vertical: screenVPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  buildAppSettingsLayout(
                      context: context,
                      screenHeight: screenHeight,
                      crashState: state.isCrashCollectionActive,
                      notificationState: state.isPushNotificationActive,
                      isVisible: state.isAppInfoAccordionExpanded,
                      appName: state.appName,
                      isLoading: state.isLoading,
                      localeValue: state.language,
                      selectedCurrency: state.selectedCurrency,
                      locationState: state.isLocationDetectionActive,
                      selectedLanguage: state.selectedLanguage,
                      buildVersion: state.appBuildVersion,
                      buildNumber: state.appBuildNumber),
                ],
              ),
            ),
          );
        });
  }

  Widget buildAppSettingsLayout(
          {required BuildContext context,
          crashState,
          isLoading,
          notificationState,
          screenHeight,
          locationState,
          isVisible,
          appName,
          buildVersion,
          buildNumber,
          localeValue,
          selectedCurrency,
          selectedLanguage}) =>
      Column(
        children: [

          if (!isLoading) ...[
            Padding(
              padding: EdgeInsets.only(bottom: widgetBottomPadding),
              child: customCardWithToggleButton(
                  title: AppStrings.myAccount_appSettings_crashCollection_title,
                  description:
                      AppStrings.myAccount_appSettings_crashCollection_description_text,
                  toggle: () {
                    _appSettingsBloc.add(
                         TriggerCrashlyticsPermissionEvent(
                            isCrashCollectionActivated: crashState));
                  },
                  isToggled: crashState),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: widgetBottomPadding),
              child: customCardWithToggleButton(
                  title: AppStrings.myAccount_appSettings_notification_title,
                  description:
                      AppStrings.myAccount_appSettings_notification_description_text,
                  toggle: () {
                    AppSettings.openAppSettings(
                        type: AppSettingsType.notification);
                    NotificationPermissions.requestNotificationPermissions(
                        iosSettings: const NotificationSettingsIos(
                            sound: true, badge: true, alert: true));
                  },
                  isToggled: notificationState),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: widgetBottomPadding),
              child: customCardWithToggleButton(
                  title: AppStrings.myAccount_appSettings_location_title,
                  description:
                      AppStrings.myAccount_appSettings_location_description_text,
                  toggle: () async {
                    await Geolocator.openLocationSettings();
                  },
                  isToggled: locationState),
            ),
          ],
          Container(
            margin: EdgeInsets.only(bottom: widgetBottomPadding),
            padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
            clipBehavior: Clip.none,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent),
                borderRadius: BorderRadius.circular(10.r),
                color: AppColor.colorAccent.withOpacity(0.2)),
            child: Theme(
              data: Theme.of(context).copyWith(
                  dividerColor: Colors.transparent,
                  dividerTheme: const DividerThemeData(thickness: 0)),
              child: ExpansionTile(
                onExpansionChanged: (isVisible) {
                  _appSettingsBloc.add(TriggerAppInfoDisplay(
                      isAppInfoAccordionExpanded: isVisible));
                },
                tilePadding: EdgeInsets.zero,
                childrenPadding: EdgeInsets.zero,
                iconColor: AppColor.colorPrimary,
                collapsedIconColor: AppColor.colorAccent,
                collapsedTextColor: AppColor.colorAccent,
                textColor: AppColor.colorPrimary,
                title: Text(
                  AppStrings.myAccount_appSettings_information_title,
                  style: Style.paragraphStyle(
                      color: isVisible
                          ? AppColor.colorAccent
                          : AppColor.colorPrimary),
                ),
                children: <Widget>[
                  _appInformation(
                      title: AppStrings.myAccount_appSettings_appName_title, name: appName),
                  _appInformation(
                      title: AppStrings.myAccount_appSettings_version_title,
                      name: buildVersion),
                  _appInformation(
                      title: AppStrings.myAccount_appSettings_buildVersion_title,
                      name: buildNumber),
                ],
              ),
            ),
          ),
        ],
      );

  Widget _appInformation({required String title, required String name}) =>
      Container(
        padding: EdgeInsets.fromLTRB(5.w, 15.h, 5.w, 15.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: AppColor.colorAbsent),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: Style.subTitleStyle(),
              ),
            ),
            Text(
              name,
             style: Style.subTitleStyle(),
            )
          ],
        ),
      );
}
