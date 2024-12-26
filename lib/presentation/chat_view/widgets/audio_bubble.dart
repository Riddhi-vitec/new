import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/resources/app_color.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/dimensions/radius.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/resources/app_strings.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/resources/style.dart';

class AudioBubble extends StatelessWidget {
  const AudioBubble(
      {super.key,
      required this.onPressed,
      required this.chatBubbleColor,
      required this.isPlaying});

  final Color chatBubbleColor;
  final void Function() onPressed;
  final bool isPlaying;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110.w,
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(cardRadius),
        color: chatBubbleColor,
      ),
      child: Row(
        children: [
          IconButton(
              onPressed: onPressed,
              icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow_sharp, color: AppColor.colorPrimaryInverse,)),
           Text('-----------', style: Style.textFieldInputStyle(),)
        ],
      ),
    );
  }
}
