import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../device_variables.dart';
import '../../../imports/common.dart';

GestureDetector buildMenu(BuildContext context,
    {required dynamic argument,
      required String routeName,
      required String menuTitle,
      required String iconUrl}) {
  return GestureDetector(
    onTap: () async {
      if(routeName == RouteName.routeRateUs){
        try {
          await launchUrl(DeviceVariables.urlLauncher);
        } catch (e) {
          Toast.nullableIconToast(message: e.toString(), isErrorBooleanOrNull: true);
        }
      }else {
        Navigator.pushNamed(context, routeName, arguments: argument);
      }

    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColor.colorPrimaryInverse,
      ),
      height: 40.h,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
      margin: EdgeInsets.only(bottom: widgetBottomPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(top: 5.h),
            width: 40.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.r),
              color: AppColor.colorScaffold,
            ),
            child: Center(
              child: SvgPicture.asset(
                iconUrl,
                height: 20.h,
                width: 20.w,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Row(
              children: [
                Text(
                  menuTitle,
                  style: Style.menuCardLabelStyle(
                    color: AppColor.colorPrimary,
                  ),
                ),
                const Spacer(),
                // Adds a flexible space to push the arrow to the right
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColor.colorPrimary,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}