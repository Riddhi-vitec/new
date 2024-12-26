import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../imports/common.dart';

class Suggestion extends StatelessWidget {
  const Suggestion({
    super.key, required this.suggestionText, required this.onPressed, required this.buttonText,
  });
  final String suggestionText;
  final String buttonText;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(bottom: widgetBottomPadding),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              suggestionText,
              style: Style.subTitleStyle(
                  color: AppColor.colorSecondaryText),
            ),
            TextButton(
              onPressed: onPressed,
              child: Text(buttonText,
                  style: Style.subTitleStyle()),
            ),
          ],
        ),
      ),
    );
  }
}