import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../../imports/common.dart';

class OtpInputField extends StatefulWidget {
  TextEditingController controller;

  final Function(String val) addListeners;
  final bool isEmptyFieldError;

  OtpInputField(
      {Key? key,
      required this.isEmptyFieldError,
      required this.controller,

      required this.addListeners})
      : super(key: key);

  @override
  State<OtpInputField> createState() => _OtpInputFieldState();
}

class _OtpInputFieldState extends State<OtpInputField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      width: 40.w,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.lightBlue.withOpacity(0.1),
              // Adjust opacity as needed
              spreadRadius: 5.r,
              blurRadius: 7.r,
              offset: Offset(0, 3.h), // changes position of shadow
            ),
          ],
          color: AppColor.colorPrimaryInverse, // Background color
          borderRadius: BorderRadius.all(
              Radius.circular(8.0.r)), // Adjust radius as needed
        ),
        child: TextFormField(
          showCursor: true,
          autofocus: false,
          textInputAction: TextInputAction.previous,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],

          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          controller: widget.controller,
          cursorColor: Theme.of(context).primaryColor,
          style: TextStyle(color: AppColor.colorAccent),
          // Set the input text color here
          decoration: InputDecoration(
            fillColor: Colors.transparent,
            // Set this to transparent
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.colorPrimary, width: 2.w),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: widget.isEmptyFieldError
                      ? AppColor.colorError
                      : AppColor.colorPrimary,
                  width: 2.w),
            ),
            counterText: '',
            hintStyle: TextStyle(color: Colors.black, fontSize: 12.sp),
          ),
          onChanged: (value) {
            if (value.length == 1) {

              FocusScope.of(context).nextFocus();
            } else if (value.length == 2) {

              widget.addListeners(value);
              FocusScope.of(context).unfocus();
            } else {
              FocusScope.of(context).previousFocus();
            }
          },
          validator: (value) {},
        ),
      ),
    );
  }
}
