import 'package:flutter/material.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/resources/app_color.dart';

Widget buildCalendarTheme(BuildContext context, Widget? child) {
  return Theme(
    data: Theme.of(context).copyWith(
      // hoverColor: ColorManager.primaryDark,
      colorScheme: ColorScheme.light(
        primary: AppColor.colorPrimary,
        onPrimary: AppColor.colorPrimaryInverse,
        onSurface: AppColor.colorAccent,
        background: AppColor.colorPrimary,

      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColor.colorPrimary,
        ),
      ),
    ),
    child: child!,
  );
}