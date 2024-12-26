import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../imports/common.dart';



class CustomCheckbox extends StatefulWidget {
  const CustomCheckbox({Key? key, required this.isChecked, this.isLink = false,
    this.isCenter= false, this.text, required this.onChanged}) : super(key: key);

  final bool isChecked, isLink, isCenter;
  final String? text;
  final Function(bool?)? onChanged;

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      //if you want to set text and check box center align set isCenter = true while use this widget
      crossAxisAlignment:  CrossAxisAlignment.start,
      children: [
        Checkbox(
          side: BorderSide(color: AppColor.colorPrimary),
          value: widget.isChecked,
          onChanged: widget.onChanged,
          activeColor: AppColor.colorPrimary,
          checkColor: AppColor.colorPrimaryInverse,
          visualDensity: const VisualDensity(horizontal: VisualDensity.minimumDensity, vertical: VisualDensity.minimumDensity),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          //Above two lines added to remove default internal padding of radio widget
        ),
        const SizedBox(width: 5),
        widget.isLink
            ? Expanded(
                child: Container(
                  margin:  EdgeInsets.only(left: 2.w, bottom: 15.h),
                  child: RichText(
                    text: TextSpan(
                      children: [

                        TextSpan(
                          text: AppStrings.authentication_signup_checkBox_preceding_text,
                          style: Style.labelStyle(color: AppColor.colorAccent),
                        ),
                        TextSpan(
                            text: AppStrings.authentication_signup_checkBox_GTC_action,
                            style: Style.labelStyle(),
                            //use this recognizer if you need onclick event
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {}),
                        TextSpan(
                          text: AppStrings.authentication_signup_checkBox_joiner_text,
                          style: Style.labelStyle(color: AppColor.colorAccent),
                        ),
                        TextSpan(
                            text: AppStrings.authentication_signup_checkBox_PP_action,
                            style: Style.labelStyle(),
                            //use this recognizer if you need onclick event
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {}),
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              )
            : Expanded(
              child: Text(
                  widget.text!,
                  style: Style.subTitleStyle(),
                ),
            ),
      ],
    );
  }
}