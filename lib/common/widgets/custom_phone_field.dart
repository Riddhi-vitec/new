import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../imports/common.dart';

class CustomPhoneField extends StatefulWidget {
  const CustomPhoneField({
    super.key,
    required this.hint,
    required this.label,
    required this.onChanged,
    this.onTap,
    required this.hasFocus,
    required this.hasError,
    required this.mobileController,
    required this.mobileFocusNode,
    this.errorMessage,
  });

  final String hint;
  final String label;
  final void Function(PhoneNumber? value) onChanged;
  final void Function()? onTap;
  final bool hasFocus;
  final bool hasError;
  final String? errorMessage;
  final TextEditingController mobileController;
  final FocusNode mobileFocusNode;

  @override
  State<CustomPhoneField> createState() => _CustomPhoneFieldState();
}

class _CustomPhoneFieldState extends State<CustomPhoneField> {
  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.label,
                style: Style.labelStyle()),
            Container(
              height: 50.h,
              padding: EdgeInsets.only(bottom: 5.h),
              decoration: widget.hasError
                  ? BoxDecoration(
                color: AppColor.colorError,
                borderRadius: BorderRadius.circular(
                  containerBoxRadius,
                ),
              )
                  : const BoxDecoration(),
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(
                    left: 5.w,
                    right: textFieldHPadding,
                    top: 7.h
                ),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: widget.hasFocus && !widget.hasError
                            ? AppColor.colorPrimary
                            : AppColor.colorTextFieldBorders),
                    borderRadius:
                    BorderRadius.all(Radius.circular(textFieldRadius)),
                    color: AppColor.colorPrimaryInverse),
                child: IntlPhoneField(
                  textAlign: TextAlign.start,
                  controller: widget.mobileController,
                  focusNode: widget.mobileFocusNode,
                  autovalidateMode: AutovalidateMode.disabled,
                  style: Style.paragraphStyle(
                      color: AppColor.colorPrimary),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 30.h),
                      border: InputBorder.none,
                      hintText: AppStrings.textfield_addMobileNo_hint,
                      errorText: '',
                      errorStyle: Style.errorStyle(
                          color: widget.hasError
                              ? AppColor.colorError
                              : AppColor.colorAccentText),
                      hintStyle: Style.hintStyle(),
                      isDense: true,
                      focusColor: widget.hasError
                          ? AppColor.colorError
                          : AppColor.colorAccent),
                  initialCountryCode: 'DE',
                  onTap: widget.onTap,
                  onChanged: (value) {
                    widget.onChanged(value);
                  },
                ),
              ),
            ),
            widget.hasError
                ? Container(
                padding: EdgeInsets.only(top: 2.0.h),
                child: Text(widget.errorMessage!,
                    style: Style.errorStyle()))
                : const SizedBox(),
          ],
        ),
      ],
    );
  }
}