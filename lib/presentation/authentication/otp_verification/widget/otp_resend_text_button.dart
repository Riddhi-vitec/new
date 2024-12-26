import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../imports/common.dart';

class OtpResendTextButton extends StatefulWidget {
  OtpResendTextButton({
    super.key,
    required this.onTap,
    required this.hasAnimationStarted,
  });

  final Function() onTap;
  bool hasAnimationStarted;

  @override
  State<OtpResendTextButton> createState() => _OtpResendTextButtonState();
}

class _OtpResendTextButtonState extends State<OtpResendTextButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(generalPadding),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(children: [
          if (widget.hasAnimationStarted)
            TextSpan(
                text: AppStrings.authentication_otp_validityInformation_text,
                style: Style.titleStyle()),
          if (!widget.hasAnimationStarted) ...[
            TextSpan(
                text: AppStrings.authentication_otp_timeOut_text,
                style: Style.titleStyle()),
            TextSpan(
                text: AppStrings.authentication_otp_resendOtp_action,
                recognizer: TapGestureRecognizer()..onTap = widget.onTap,
                style: Style.titleStyle(color: AppColor.colorAccent))
          ]
        ]),
      ),
    );
  }
}
