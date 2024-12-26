import 'package:flutter/cupertino.dart';

import '../../../imports/common.dart';





class AuthenticationInformationText extends StatelessWidget {
  const AuthenticationInformationText({
    super.key,
    required this.message,
  });


  final String message;
  @override
  Widget build(BuildContext context) {
    return Text(
        message,
        textAlign: TextAlign.center,
        style: Style.labelStyle(color: AppColor.colorSecondaryText));
  }
}