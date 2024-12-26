import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/resources/app_color.dart';

import 'package:template_flutter_mvvm_repo_bloc/common/resources/style.dart';

import '../../../imports/common.dart';


class ChatDateGroupingHeader extends StatelessWidget {
  ChatDateGroupingHeader({super.key, required this.dateTime});

  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: Center(
        child: Card(
          color: AppColor.colorAccent,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
                extractDateOnlyFromDateTime(dateTime),
              style:  Style.textFieldInputStyle(),
            ),
          ),
        ),
      ),
    );
  }
}
