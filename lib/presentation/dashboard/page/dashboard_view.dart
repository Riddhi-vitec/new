import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../di/di.dart';
import '../../../imports/common.dart';
import '../bloc/dashboard_bloc.dart';

class DashBoardView extends StatelessWidget {
  DashBoardView({super.key});

  final DashboardBloc _dashBoardBloc = instance<DashboardBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _dashBoardBloc..add(TriggerCountNotification()),
      child: BlocBuilder<DashboardBloc, DashboardWithInitialState>(
        builder: (context, state) {
          return Scaffold(
            appBar: CustomAppBar(
                title: AppStrings.dashboard_screen_title,
                actions: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      AppBarActionIcon(
                          isLeading: false,
                          svg: Assets.icBell,
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouteName.routeNotification);
                          }),
                      if(state.notificationCount > 0)
                      buildNotificationWithCounter(state),
                    ],
                  ),
                ],
                isLeading: false),
            drawer:
                const CustomDrawer(text: AppStrings.dashboard_openDrawer_text),
            endDrawer:
                const CustomDrawer(text: AppStrings.dashboard_endDrawer_text),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  horizontal: screenHPadding, vertical: screenVPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Text(AppLocalizations.of(context)!.dashboard,
                          style: Style.subTitleStyle(
                              color: AppColor.colorPrimary))),
                  CustomButton(
                      variant: ButtonVariant.btnPrimary,
                      onTap: () {
                        Navigator.pushNamed(context, RouteName.routeChat);
                      },
                      text: AppStrings.chat_myChats_viewBtn),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Positioned buildNotificationWithCounter(DashboardWithInitialState state) {
    return Positioned(
                        top: -2.h,
                        right: 5.w,
                        child: CircleAvatar(
                            radius: 12.r,
                            backgroundColor: AppColor.colorPrimary,
                            child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 10.r,
                                child: Center(
                                    child: Transform.translate(
                                  offset:  Offset(0.1.w, 0.1.h),
                                  // if notification count is <9 then set it Offset(0, 0),
                                  child: RichText(
                                      text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text: state.notificationCount.toString(),
                                          style: Style.paragraphStyle(
                                              color: AppColor.colorPrimary)),
                                    ],
                                  )),
                                )))));
  }
}
