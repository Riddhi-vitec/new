import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/resources/app_color.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/resources/app_strings.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/widgets/button_with_icon.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/widgets/custom_text_field.dart';

class MessageField extends StatefulWidget {
  const MessageField(
      {super.key,
      required this.chatController,
      required this.pickMultiMedia,
      required this.startOrStopVoiceRecord,
      required this.sendMessage,
      required this.isRecording});

  final void Function() pickMultiMedia;
  final void Function() startOrStopVoiceRecord;
  final bool isRecording;
  final void Function() sendMessage;
  final TextEditingController chatController;

  @override
  State<MessageField> createState() => _MessageFieldState();
}

class _MessageFieldState extends State<MessageField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      color: AppColor.colorAccent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ButtonWithIcon(
              onTap: widget.pickMultiMedia,
              widget: Icon(
                Icons.attachment_sharp,
                color: AppColor.colorPrimaryInverse,
              )),
          ButtonWithIcon(
              onTap: widget.startOrStopVoiceRecord,
              widget: !widget.isRecording
                  ? Icon(
                Icons.mic,
                color: AppColor.colorPrimaryInverse,
              )
                  : widget.isRecording
                  ? SizedBox(
                height: 10.h,
                width: 10.w,
                child: const CircularProgressIndicator(),
              )
                  : const Icon(Icons.mic_off)),
          Expanded(
            child: Container(
              padding:
              EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
              child: CustomTextField(
                controller: widget.chatController,
                hintText: AppStrings.chat_myChats_textfield_addMessage_hint,
              ),
            ),
          ),
          ButtonWithIcon(
              onTap: widget.sendMessage,
              widget: Icon(
                Icons.send,
                color: AppColor.colorPrimaryInverse,
              )),
        ],
      ),
    );
  }
}