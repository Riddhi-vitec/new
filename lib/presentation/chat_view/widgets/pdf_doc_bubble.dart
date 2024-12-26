import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:template_flutter_mvvm_repo_bloc/common/resources/style.dart';

import '../../../imports/common.dart';


class PdfDocBubble extends StatelessWidget {
  const PdfDocBubble(
      {super.key,
      required this.chatBubbleColor,
      required this.message,
      required this.isSentByMe,
      required this.onTap});

  final Color chatBubbleColor;
  final String message;
  final void Function() onTap;
  final bool isSentByMe;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: BubbleSpecialThree(
        text: extractFileNameFromUrl(message),
        color: chatBubbleColor,
        tail: true,
        isSender: isSentByMe,
        textStyle: Style.underlinedText(),
      ),
    );
  }
}
