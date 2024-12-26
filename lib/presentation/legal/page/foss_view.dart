import 'package:flutter/material.dart';

import '../../../imports/common.dart';
import '../../../oss_licenses.dart';
import '../widget/foss_list_item_view.dart';


class FossView extends StatelessWidget {
  const FossView({super.key});


  @override
  Widget build(BuildContext context) {
    return    Scaffold(
        appBar: const CustomAppBar(
            centerTitle: false, title: AppStrings.myAccount_legals_foss_screen_title),
        body: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: screenHPadding, vertical: screenVPadding),
          itemCount: ossLicenses.length,
          itemBuilder: (context, index) {
            var data = ossLicenses[index];
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RouteName.routeFossDetailView,
                    arguments: {
                      "title": "${data.name}  ${data.version}",
                      "licence": "${data.license}"
                    });
              },
              child: FossItemWidget(

                  title: "${data.name.toUpperCase()}  ${data.version}",
                  licence: data.description,
                  copyright: data.license ?? ''),
            );
          },
          separatorBuilder: (context, index) {
            return Padding(padding: EdgeInsets.only(bottom: listItemSpaceInBetween));
          },
        ));

  }
}