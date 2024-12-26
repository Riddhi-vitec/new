import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter_mvvm_repo_bloc/common/resources/app_color.dart';

import 'package:template_flutter_mvvm_repo_bloc/common/resources/style.dart';
import 'package:video_player/video_player.dart';

import '../../imports/common.dart';

class CustomVideoPlayer extends StatefulWidget {
  const CustomVideoPlayer({super.key, required this.videoPlayerController,
    required this.looping, required this.autoplay, required this.videoSizeType});

  final VideoPlayerController videoPlayerController;
  final bool looping;
  final bool autoplay;
  final VideoSizeType videoSizeType;

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  ChewieController? chewieController;

  @override
  void initState() {
    chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      aspectRatio:5/8,
      autoInitialize: true,
      autoPlay: widget.autoplay,
      looping: widget.looping,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: Style.errorStyle(color: AppColor.colorPrimaryInverse),
          ),
        );
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.videoSizeType == VideoSizeType.smallChatVideoFrame? 200.h: null, //null will cover full screen; adjust as per need.
      width: widget.videoSizeType == VideoSizeType.smallChatVideoFrame? 200.w: null, //null will cover full screen; adjust as per need.
      child: Chewie(
        controller: chewieController!,
      ),
    );
  }
}