import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/resources/app_color.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/dimensions/font_size.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/dimensions/radius.dart';

import '../../imports/common.dart';


// /**
//  Please note, you have to adhere to figma suggested font sizes, colors, and family.
//     This template has no font family added
//  */
class FontFamilies {
  static final String squada = "squada-one";
  static final String outfit = "Outfit";
}

class Style {
  // Bars
  static TextStyle appBarTitleStyle({Color? color}) {
    return TextStyle(
      fontFamily: FontFamilies.squada,
      fontWeight: FontWeight.w400,
      fontSize: title,
      color: color ?? AppColor.colorPrimary,
    );
  }
  static TextStyle extraLargeTitleStyle({Color? color}) {
    return TextStyle(
      fontFamily: FontFamilies.squada,
      fontWeight: FontWeight.w400,
      fontSize: titleLarge,
      color: color ?? AppColor.colorPrimary,
    );
  }

  static TextStyle navBarTitleStyle({required bool isSelected}) {
    return TextStyle(
      fontFamily: FontFamilies.outfit,
      fontWeight: FontWeight.w600,
      fontSize: normal,
      color: isSelected ? AppColor.colorPrimary : AppColor.colorTertiaryText,
    );
  }

  static TextStyle tabBarTitleStyle({required bool isSelected}) {
    return TextStyle(
      fontFamily: FontFamilies.squada,
      fontWeight: FontWeight.w400,
      fontSize: subHeaderTitle,
      color: isSelected ? AppColor.colorPrimaryInverse : AppColor.colorPrimary,
    );
  }

  // Header, Sub-header, and body
  static TextStyle titleStyle({Color? color}) {
    return TextStyle(
      fontFamily: FontFamilies.squada,
      fontWeight: FontWeight.w400,
      fontSize: headerTitle,
      color: color ?? AppColor.colorPrimary,
    );
  }

  static TextStyle titleBoldStyle({Color? color}) {
    return TextStyle(
      fontFamily: FontFamilies.squada,
      fontWeight: FontWeight.bold,
      fontSize: headerTitle,
      color: color ?? AppColor.colorPrimary,
    );
  }

  static TextStyle subTitleStyle({Color? color}) {
    return TextStyle(
      fontFamily: FontFamilies.outfit,
      fontWeight: FontWeight.w400,
      fontSize: subHeaderTitle,
      color: color ?? AppColor.colorAccent,
    );
  }

  static TextStyle subTitleBoldStyle({Color? color}) {
    return TextStyle(
      fontFamily: FontFamilies.outfit,
      fontWeight: FontWeight.bold,
      fontSize: subHeaderTitle,
      color: color ?? AppColor.colorAccent,
    );
  }

  static TextStyle paragraphStyle({Color? color}) {
    return TextStyle(
      fontFamily: FontFamilies.outfit,
      fontWeight: FontWeight.w400,
      fontSize: normal,
      color: color ?? AppColor.colorTertiaryText,
    );
  }

  //Textfields
  static TextStyle hintStyle() {
    return TextStyle(
      fontFamily: FontFamilies.outfit,
      fontWeight: FontWeight.w400,
      fontSize: normal,
      color: AppColor.colorTertiaryText,
    );
  }

  static TextStyle errorStyle({Color? color}) {
    return TextStyle(
      fontFamily: FontFamilies.outfit,
      fontWeight: FontWeight.w400,
      fontSize: normal,
      color: color ?? AppColor.colorError,
    );
  }

  static TextStyle textFieldInputStyle() {
    return TextStyle(
      fontFamily: FontFamilies.outfit,
      fontWeight: FontWeight.w400,
      fontSize: normal,
      color: AppColor.colorPrimary,
    );
  }

  static TextStyle labelStyle({Color? color}) {
    return TextStyle(
      fontFamily: FontFamilies.outfit,
      fontWeight: FontWeight.w400,
      fontSize: regular,
      color: color ?? AppColor.colorPrimary,
    );
  }

  // buttonLabel
  static TextStyle buttonLabel({required ButtonSize buttonSize, Color? color}) {
    return TextStyle(
      fontFamily: FontFamilies.squada,
      fontWeight: FontWeight.w400,
      fontSize: buttonSize == ButtonSize.large
          ? headerTitle
          : buttonSize == ButtonSize.medium
          ? subHeaderTitle
          : regular,
      color: color ?? AppColor.colorPrimaryInverse,
    );
  }

  static TextStyle textButtonStyle({Color? color}) {
    return TextStyle(
      fontFamily: FontFamilies.squada,
      fontWeight: FontWeight.w400,
      fontSize: subHeaderTitle,
      color: color ?? AppColor.colorSecondaryText,
    );
  }

  static TextStyle menuCardLabelStyle({Color? color}) {
    return TextStyle(
      fontFamily: FontFamilies.squada,
      fontWeight: FontWeight.w400,
      fontSize: regular,
      color: color ?? AppColor.colorAccent,
    );
  }

  static TextStyle dropdownTitlesStyle({Color? color}) {
    return TextStyle(
      fontFamily: FontFamilies.squada,
      fontWeight: FontWeight.w400,
      fontSize: normal,
      color: AppColor.colorPrimary,
    );
  }

  static TextStyle underlinedText({Color? color}) {
    return TextStyle(
        color: color ?? AppColor.colorPrimaryInverse,
        decoration: TextDecoration.underline,
        fontSize: normal);
  }

  static ShapeBorder bottomSheetShape() {
    return RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(bottomSheetRadius),
            topRight: Radius.circular(bottomSheetRadius)));
  }

}