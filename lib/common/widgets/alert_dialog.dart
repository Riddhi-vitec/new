import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



import '../../imports/common.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({super.key, required this.title, this.leftButtonText, this.rightButtonText,
    this.subTitle, required this.onTapLeftButton,required this.body, this.onTapRightButton
  });
  final String title;
  final String? subTitle;
  final Widget? body;
  final Function()? onTapLeftButton;
  final Function()? onTapRightButton;
  final String? rightButtonText;
  final String? leftButtonText;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: screenHPadding, vertical: screenVPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title,
                textAlign: TextAlign.center,
                style: Style.titleBoldStyle()
              ),
               SizedBox(height: 15.h),
              if(subTitle !=null)...[
              Text(subTitle!,
                textAlign: TextAlign.center,
                style: Style.subTitleStyle()
              ),
                SizedBox(height: 15.h),
              ],
              if(body !=null)...[
                body!,
                SizedBox(height: 10.h),
              ],
              RowWithTwoButtons(
                leftButtonText: leftButtonText ?? AppStrings.confirmationDialog_yesBtn,
                leftButtonVariant: ButtonVariant.btnPrimary,
                leftButtonSize: ButtonSize.small,
                leftButtonOnTap: onTapLeftButton ?? (){
                  Navigator.pop(context);
                },
                rightButtonVariant: ButtonVariant.btnPrimary,
                rightButtonText: rightButtonText ?? AppStrings.confirmationDialog_noBtn,
                rightButtonSize: ButtonSize.small,
                rightButtonOnTap: onTapRightButton ?? (){
                    Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}