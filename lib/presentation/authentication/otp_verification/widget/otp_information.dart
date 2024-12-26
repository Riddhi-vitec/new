import 'package:flutter/cupertino.dart';

import '../../../../imports/common.dart';





class OtpInformation extends StatelessWidget {
  const OtpInformation({
    super.key,
    required this.message,
  });


  final String message;
  @override
  Widget build(BuildContext context) {
    return Text(
        message,
        textAlign: TextAlign.center,
        style: Style.subTitleStyle());
  }
}