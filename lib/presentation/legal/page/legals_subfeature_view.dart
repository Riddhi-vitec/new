import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../imports/common.dart';
import '../../../imports/data.dart';

class LegalsSubFeatureView extends StatelessWidget {
  const LegalsSubFeatureView({super.key, required this.legalsData});

  final LegalsData legalsData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  CustomAppBar(
            centerTitle: false, title: legalsData.pageName == Legals.imprint.name? AppStrings.myAccount_legals_menu_imprintBtn: legalsData.pageName == Legals.termsConditions.name ? AppStrings.myAccount_legals_termsConditions_screen_title: legalsData.pageName == Legals.privacyPolicy.name ? AppStrings.myAccount_legals_pp_screen_title: AppStrings.myAccount_legals_foss_screen_title),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              horizontal: screenHPadding, vertical: screenVPadding),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                HtmlWidget(
                  legalsData.content ?? '',
                ),
              ]),
        ));
  }
}
