import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/resources/app_color.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/dimensions/paddings.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/dimensions/radius.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/resources/style.dart';

class PasswordValidationStatement extends StatelessWidget {
  final String text;
  final bool isChecked;

  const PasswordValidationStatement(
      {super.key, required this.text, required this.isChecked});

  @override
  Widget build(BuildContext context) {
    return RawChip(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      showCheckmark: false,
      labelPadding: EdgeInsets.zero,
      label: Text(text,
          textAlign: TextAlign.center,
          style: Style.paragraphStyle(
            color: isChecked ? AppColor.colorPrimaryInverse : AppColor.colorTertiaryText,
          )),
      selected: isChecked,
      backgroundColor: AppColor.colorDisable,
      selectedColor: AppColor.colorPrimary,
      shape: isChecked
          ? RoundedRectangleBorder(
              side: BorderSide(color: AppColor.colorPrimary),
              borderRadius: BorderRadius.circular(containerBoxRadius))
          : RoundedRectangleBorder(
              side: BorderSide(color: AppColor.colorTertiaryText),
              borderRadius: BorderRadius.circular(containerBoxRadius)),
      onSelected: (value) {
        // onSelectedChipView?.call(value);
      },
    );
  }
}