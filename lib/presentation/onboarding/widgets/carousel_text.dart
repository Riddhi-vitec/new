import 'package:flutter/cupertino.dart';

import '../../../imports/common.dart';

class CarouselText extends StatelessWidget {
  const CarouselText({
    Key? key,
    required this.text,
    required this.textColor,
    required this.isTitle,

  }) : super(key: key);

  final String text;
  final Color textColor;
  final bool isTitle;


  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      style: isTitle? Style.appBarTitleStyle(color: textColor):Style.subTitleStyle(color: textColor),
      textAlign: TextAlign.center,
    );
  }
}