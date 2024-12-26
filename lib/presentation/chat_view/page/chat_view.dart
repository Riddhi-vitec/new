import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:open_filex/open_filex.dart';
import 'package:video_player/video_player.dart';

import '../../../imports/common.dart';

import '../bloc/chat_bloc.dart';
import '../widgets/audio_bubble.dart';
import '../widgets/chat_date_grouping_header.dart';
import '../widgets/image_bubble.dart';
import '../widgets/message_field.dart';
import '../widgets/pdf_doc_bubble.dart';
import '../widgets/video_bubble.dart';


class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final ChatBloc chatBloc = ChatBloc();

  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;

  @override
  void initState() {
    chatBloc.add(const TriggerSocketConnectionToLoadChat(
        roomId: 'ASK BE IF IT IS NEEDED'));
    super.initState();
  }

  @override
  void dispose() {
    chatBloc.audioPlayer.dispose();
    chatBloc.audioRecorder.dispose();
    chatBloc.socketService.socket.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => chatBloc,
      child: BlocListener<ChatBloc, ChatState>(
        listener: (context, state) {
          //Use it for any kind of toasts
        },
        child: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            return (state is ChatLoaded)
                ? buildChatLayout(
                    isPlaying: state.chatPlayIndex,
                    isRecording: state.isRecording,
                    chatData: state.chatData,
                    context: context)
                : state is ChatRefresh
                    ? buildChatLayout(
                        isPlaying: state.chatPlayIndex,
                        isRecording: state.isRecording,
                        chatData: state.chatData,
                        context: context)
                    : CustomLoader(
                        child: buildChatLayout(
                            isPlaying: {false: -1},
                            isRecording: false,
                            chatData: [],
                            context: context));
          },
        ),
      ),
    );
  }

  Scaffold buildChatLayout(
      {required BuildContext context,
      required List<Message> chatData,
      required Map<bool, int> isPlaying,
      required isRecording}) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.chat_myChats_screen_title,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: AppColor.colorPrimaryInverse,
        child: Column(children: [
          Padding(
            padding: EdgeInsets.all(widgetBottomPadding),
            child: Text(AppStrings.chat_myChats_greetingMessage_text,
                textAlign: TextAlign.center,
                style: Style.paragraphStyle()),
          ),
          Expanded(
            child: GroupedListView<Message, DateTime>(
              padding: const EdgeInsets.all(3),
              reverse: true,
              order: GroupedListOrder.DESC,
              elements: chatData,
              groupBy: (chatData) => DateTime(
                chatData.date.year,
                chatData.date.month,
                chatData.date.day,
              ),
              groupHeaderBuilder: (Message message) =>
                  ChatDateGroupingHeader(dateTime: message.date),
              itemBuilder: (context, Message message) => Align(
                alignment: message.isSentByMe
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: message.isSentByMe
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 5.0.h),
                      child: message.type ==
                              ChatType.audio
                          ? AudioBubble(
                              isPlaying: chatBloc.getPlayStatus(
                                  chatData.indexOf(message), isPlaying),
                              onPressed: () {
                                if (!isPlaying.containsKey(true)) {
                                  chatBloc.add(TriggerChatRecordPlayEvent(
                                      index: chatData.indexOf(message)));
                                } else {
                                  chatBloc.add(TriggerChatRecordPauseEvent(
                                      index: chatData.indexOf(message)));
                                }
                              },
                              chatBubbleColor: message.chatBubbleColor,
                            )
                          : message.type ==
                                  ChatType.text
                              ? PdfDocBubble(
                                  message: message.message,
                                  isSentByMe: message.isSentByMe,
                                  chatBubbleColor: message.chatBubbleColor,
                                  onTap: () {
                                    if (!message.isNetwork) {
                                      OpenFilex.open(message.message);
                                    } else {
                                      downloadMultimedia(
                                          fileNameWithExtension:
                                              extractFileNameFromUrl(
                                                  message.message),
                                          sourceUrl: message.message);
                                    }
                                  },
                                )
                              : message.type ==
                                      ChatType.image
                                  ? ImageBubble(
                                      message: message.message,
                                      isNetwork: message.isNetwork,
                                    )
                                  : message.type ==
                                          ChatType.video
                                      ?
                                      VideoBubble(
                                          message: message.message,
                                        )
                                      : BubbleSpecialThree(
                                          text: message.message,
                                          color: message.chatBubbleColor,
                                          tail: true,
                                          isSender: message.isSentByMe,
                                          textStyle:
                                              Style.textFieldInputStyle(),
                                        ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Text(extractTimeOnlyFromDateTime(message.date),
                          style: Style.subTitleStyle()),
                    )
                  ],
                ),
              ),
            ),
          ),
          MessageField(
            isRecording: isRecording,
            pickMultiMedia: () {
              chatBloc.add(TriggerPickMultiMedia());
            },
            startOrStopVoiceRecord: !isRecording
                ? () {
                    chatBloc.add(TriggerChatRecordStartEvent());
                  }
                : () {
                    chatBloc.add(TriggerChatRecordStopEvent());
                  },
            chatController: chatBloc.chatController,
            sendMessage: () {
              chatBloc.add(const TriggerChatSendEvent());
            },
          )
        ]),
      ),
    );
  }
}
