import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../di/di.dart';
import '../../../imports/common.dart';
import '../bloc/legals_bloc.dart';


class LegalView extends StatelessWidget {
  LegalView({super.key});

  final LegalsBloc legalsBloc = instance<LegalsBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => legalsBloc..add(TriggerFetchLegalsEvent()),
      child: BlocBuilder<LegalsBloc, LegalsWithInitialState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColor.colorScaffold,
            appBar: const CustomAppBar(
                centerTitle: false,
                title: AppStrings.myAccount_legals_screen_title),
            body: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenHPadding, vertical: screenVPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  buildMenuButton(context, argument: state.imprint,
                      routName: RouteName.routeLegalsSubFeature,
                      menuTitle: AppStrings.myAccount_legals_menu_imprintBtn,
                      hasPrefix: false,
                      iconUrl: ''),
                  buildMenuButton(context, argument: state.tou,
                      routName: RouteName.routeLegalsSubFeature,
                      menuTitle: AppStrings.myAccount_legals_menu_tcBtn,
                      hasPrefix: false,
                      iconUrl: ''),
                  buildMenuButton(context, argument: null,
                      routName: RouteName.routeFoss,
                      menuTitle:   AppStrings.myAccount_legals_menu_fossBtn,
                      hasPrefix: false,
                      iconUrl: ''),
                  buildMenuButton(context, argument: state.pp,
                      routName: RouteName.routeLegalsSubFeature,
                      menuTitle: AppStrings.myAccount_legals_menu_ppBtn,
                      hasPrefix: false,
                      iconUrl: ''),

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}