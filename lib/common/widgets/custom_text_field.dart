import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/resources/app_color.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/resources/assets.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/dimensions/radius.dart';

import 'package:template_flutter_mvvm_repo_bloc/common/resources/style.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/widgets/image_view.dart';

import '../../imports/common.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.errorText,
    this.isReadOnly = false,
    this.focusNode,
    this.validator,
    this.inputFormatters,
    this.autofocus = false,
    this.isObscureText,
    this.onFieldSubmit,
    this.isError = false,
    this.onChanged,
    this.nextFocusNode,
    this.onTap,
    this.variant,
    this.filledColor,
    this.autoValidate = false,
    this.errorTextLength = 2,
    this.onTapPassword,
    this.isDone = false,
    this.label = '',
    this.textInputType = TextInputType.text,
  });

  final bool isError;
  final bool autoValidate;
  final bool isReadOnly;
  final TextEditingController controller;
  final String? hintText;
  final String? errorText;
  final FocusNode? focusNode, nextFocusNode;
  final bool? autofocus;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final bool? isObscureText;
  final Function(void)? onFieldSubmit;
  final Function()? onTap;
  final ValueChanged<String>? onChanged;
  final TextFieldVariant? variant;
  final Color? filledColor;
  final int errorTextLength;
  final Function()? onTapPassword;
  final bool isDone;
  final String label;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Style.labelStyle()),
        Stack(
          children: [
            isError
                ? Container(
                    height: MediaQuery.of(context).size.height / 13.h,
                    decoration: BoxDecoration(
                        color: AppColor.colorError,
                        borderRadius:
                            BorderRadius.circular(containerBoxRadius)))
                : const SizedBox(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  autovalidateMode: autoValidate
                      ? AutovalidateMode.onUserInteraction
                      : AutovalidateMode.disabled,
                  controller: controller,
                  focusNode: focusNode,
                  autofocus: autofocus!,
                  textAlign: TextAlign.start,
                  keyboardType: variant != null
                      ? setTextInputType(variant: variant)
                      : textInputType,
                  textAlignVertical: TextAlignVertical.center,
                  enabled: true,
                  style: Style.textFieldInputStyle(),
                  obscureText: isObscureText ?? false,
                  inputFormatters:
                      inputFormatters ?? setInputFormatter(variant: variant),
                  readOnly: isReadOnly,
                  textInputAction:
                      isDone ? TextInputAction.done : TextInputAction.next,
                  maxLines: 1,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                        top: variant != null ? 0 : 12.h,
                        bottom: variant != null ? 0 : 12.h,
                        left: variant != null ? 0 : 15.w,
                        right: 18.w),
                    isDense: true,
                    fillColor: filledColor ?? AppColor.colorPrimaryInverse,
                    filled: true,
                    hintText: hintText ?? "",
                    hintStyle: Style.hintStyle(),
                    errorText: errorText,
                    errorMaxLines: errorTextLength,
                    errorStyle: Style.errorStyle(),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(cardRadius),
                        borderSide: BorderSide(
                            color: AppColor
                                .colorTextFieldBorders) //use color manager
                        ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(cardRadius),
                        borderSide: BorderSide(
                            color: AppColor
                                .colorPrimary) //change this according to requirement
                        ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(cardRadius),
                        borderSide:
                            BorderSide(color: AppColor.colorTextFieldBorders)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(cardRadius),
                        borderSide:
                            BorderSide(color: AppColor.colorTextFieldBorders)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(cardRadius),
                        borderSide:
                            BorderSide(color: AppColor.colorTextFieldBorders)),
                    prefixIcon: variant != null
                        ? Container(child: setPrefix(variant: variant))
                        : null,
                    suffixIcon: isObscureText == null
                        ? null
                        : GestureDetector(
                            onTap: onTapPassword,
                            child: Container(
                              width: 60.w,

                              // height: 60.h,
                              child: Align(
                                alignment: Alignment(0.3.w, 0),
                                child: Icon(
                                  isObscureText!
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: isReadOnly
                                      ? AppColor.colorSecondary
                                      : null,
                                ),
                              ),
                            ),
                          ),
                  ),
                  validator: validator,
                  onChanged: onChanged,
                  onFieldSubmitted: onFieldSubmit,
                  onTap: onTap,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  //edit the parameters to change icons SVG
  setPrefix({TextFieldVariant? variant}) {
    switch (variant) {
      case TextFieldVariant.email:
        return Icon(
          Icons.email,
          color: isReadOnly ? AppColor.colorSecondary : null,
        );
      case TextFieldVariant.password:
        return Icon(
          Icons.lock,
          color: isReadOnly ? AppColor.colorSecondary : null,
        );
      case TextFieldVariant.user:
        return Icon(
          Icons.person_2_rounded,
          color: isReadOnly ? AppColor.colorSecondary : null,
        );
      case TextFieldVariant.mobileNumber:
        return Icon(
          Icons.call,
          color: isReadOnly ? AppColor.colorSecondary : null,
        );
      case TextFieldVariant.address:
        return Icon(
          Icons.location_on,
          color: isReadOnly ? AppColor.colorSecondary : null,
        );
      case TextFieldVariant.date:
        return Icon(
          Icons.calendar_month,
          color: isReadOnly ? AppColor.colorSecondary : null,
        );
      default:
        return const SizedBox();
    }
  }

  setInputFormatter({TextFieldVariant? variant}) {
    switch (variant) {
      case TextFieldVariant.item:
        return setInputFormatter();
      case TextFieldVariant.user:
        return setUserNameFormat();
      case TextFieldVariant.mobileNumber:
        setMobileNumberFormat();
      case TextFieldVariant.realNumber:
        return setRealNumFormat();
      case TextFieldVariant.integerNumber:
        return setIntegerFormat();
      case TextFieldVariant.password:
        return [LengthLimitingTextInputFormatter(24)];
      default:
        return null;
    }
  }

  setTextInputType({TextFieldVariant? variant}) {
    switch (variant) {
      case TextFieldVariant.email:
        return TextInputType.emailAddress;
      case TextFieldVariant.mobileNumber:
        return TextInputType.phone;
      case TextFieldVariant.realNumber:
        return TextInputType.number;
      case TextFieldVariant.integerNumber:
        return const TextInputType.numberWithOptions(decimal: false);
      case TextFieldVariant.password:
        return TextInputType.visiblePassword;
      case TextFieldVariant.address:
        return TextInputType.streetAddress;
      default:
        return TextInputType.text;
    }
  }
}
