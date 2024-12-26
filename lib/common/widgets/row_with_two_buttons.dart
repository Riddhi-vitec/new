import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:template_flutter_mvvm_repo_bloc/common/widgets/custom_button.dart';

import '../../imports/common.dart';

class RowWithTwoButtons extends StatelessWidget {
  const RowWithTwoButtons({super.key, required this.leftButtonText,
    required this.rightButtonText, required this.leftButtonVariant,
    required this.rightButtonVariant, this.leftButtonSize, this.rightButtonSize,
    this.leftButtonOnTap, this.rightButtonOnTap
  });

  final String leftButtonText, rightButtonText;
  final ButtonVariant leftButtonVariant, rightButtonVariant;
  final ButtonSize? leftButtonSize, rightButtonSize;
  final Function()? leftButtonOnTap, rightButtonOnTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            text: leftButtonText,
            variant: leftButtonVariant,
            buttonSize: leftButtonSize,
            onTap: leftButtonOnTap
          ),
        ),
         SizedBox(width: 10.w),
        Expanded(
          child: CustomButton(
            text: rightButtonText,
            variant: rightButtonVariant,
            buttonSize: rightButtonSize,
            onTap: rightButtonOnTap,
          ),
        ),
      ],
    );
  }
}