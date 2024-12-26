import 'package:flutter/cupertino.dart';

import 'package:template_flutter_mvvm_repo_bloc/common/widgets/custom_video_player.dart';
import 'package:video_player/video_player.dart';

import '../../../imports/common.dart';

class VideoBubble extends StatelessWidget {
  const VideoBubble({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: CustomVideoPlayer(
          videoSizeType: VideoSizeType.smallChatVideoFrame,
          autoplay: false,
          looping: false,
          videoPlayerController:
              VideoPlayerController.networkUrl(Uri.parse(message))),
    );
  }
}
