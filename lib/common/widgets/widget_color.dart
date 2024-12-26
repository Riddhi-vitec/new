import 'package:flutter/material.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/resources/app_color.dart';

Color getChatBubbleColor({required isSentByMe}){
  return isSentByMe?   AppColor.colorPrimary
  : AppColor.colorSecondary;
}
