import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../imports/common.dart';
import 'otp_input_field.dart';

class WrapOfOtpFields extends StatefulWidget {
   WrapOfOtpFields({
    super.key,
    required this.fields,
    required this.fieldFunction,
    required this.fieldErrors,
    required this.message,
    required this.isEmptyFieldError,
  });

   List<TextEditingController> fields;
  final Function(String val, int index) fieldFunction;
   List<String?> fieldErrors;
  String message;
  bool isEmptyFieldError;

  @override
  State<WrapOfOtpFields> createState() => _WrapOfOtpFieldsState();
}

class _WrapOfOtpFieldsState extends State<WrapOfOtpFields> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 10.w,
          children: [
            for (int i = 0; i < widget.fields.length; i++)
              OtpInputField(
                controller: widget.fields[i],
                addListeners: (val) {
                  widget.fieldFunction(widget.fields[i].text, i);
                },
                isEmptyFieldError:widget.isEmptyFieldError
              ),
          ],
        ),
        SizedBox(height: 5.h,),
        if (widget.isEmptyFieldError)
          Text(
            widget.message,
            style: TextStyle(color: AppColor.colorError),
          ),
      ],
    );
  }
}
