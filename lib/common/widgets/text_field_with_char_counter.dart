import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/resources/app_color.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/dimensions/paddings.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/dimensions/radius.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/resources/style.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/widgets/custom_text_field.dart';

class TextFieldWithCharCounter extends StatefulWidget {
  const TextFieldWithCharCounter(
      {super.key,
        required this.controller,
        this.textAlign = TextAlign.start,
        this.hintText,
        this.label = '',
        this.validator,
        this.textInputAction,
        this.textInputType,
        this.onFieldSubmit,
        this.isError = false,
        this.error,
        this.onChanged,
        this.focusNode,
        this.hasFocus =false,
        this.maxLength = 250,
        this.maxLines = 4,
        this.onTap});

  final bool isError;
  final String? error;
  final TextEditingController controller;
  final String? hintText;
  final TextAlign textAlign;
  final FormFieldValidator<String>? validator;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final Function(void)? onFieldSubmit;
  final Function()? onTap;

  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  final int maxLines;
  final int maxLength;
  final bool hasFocus;
  final String label;

  @override
  State<TextFieldWithCharCounter> createState() =>
      _TextFieldWithCharCounterState();
}

class _TextFieldWithCharCounterState
    extends State<TextFieldWithCharCounter> {

  // this text field with the counter of the text char length
  @override
  Widget build(BuildContext context) {

    return Stack(children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label,
              style: Style.labelStyle()),
          Container(
            padding:  EdgeInsets.only(bottom: 5.h),
            decoration:
            widget.isError
                ? BoxDecoration(
              color: AppColor.colorError,
              borderRadius: BorderRadius.circular(containerBoxRadius,),
            )
                :
            const BoxDecoration(),
            child: Container(
              alignment: Alignment.centerLeft,
              padding:  EdgeInsets.symmetric(horizontal: textFieldHPadding, vertical: textFieldVPadding),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: widget.hasFocus && !widget.isError
                          ? AppColor.colorPrimary
                          : AppColor.colorTextFieldBorders),
                  borderRadius:  BorderRadius.all(Radius.circular(textFieldRadius)),
                  color: AppColor.colorPrimaryInverse),
              child:

              Column(
                children: [
                  TextFormField(
                    focusNode: widget.focusNode,
                    textAlign: TextAlign.left,
                    autofocus: true,
                    enabled: true,
                    maxLength: widget.maxLength,
                    maxLines: widget.maxLines,
                    controller: widget.controller,
                    keyboardType: widget.textInputType,
                    textInputAction: widget.textInputAction,
                    style: Style.textFieldInputStyle(),
                    validator: widget.validator,
                    onChanged: widget.onChanged,
                    onFieldSubmitted: widget.onFieldSubmit,
                    onTap: widget.onTap,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: widget.hintText,
                        errorText: '',
                        errorStyle: Style.errorStyle(color: widget.isError? AppColor.colorError: AppColor.colorAccent),
                        hintStyle: Style.hintStyle(),
                        isDense: true,
                        focusColor: widget.isError ? AppColor.colorError : AppColor.colorAccent
                    ),
                  ),
                ],
              ),
            ),
          ),
          widget.isError
              ? Padding(
              padding:  EdgeInsets.only(top: 6.0.h),
              child: Text(widget.error!,
                  style: Style.errorStyle()))
              : const SizedBox(),
        ],
      ),
    ]);
  }
}