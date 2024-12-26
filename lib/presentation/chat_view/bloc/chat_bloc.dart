import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;


import 'package:template_flutter_mvvm_repo_bloc/common/widgets/widget_color.dart';
import 'package:template_flutter_mvvm_repo_bloc/di/di.dart';

import '../../../common/resources/app_strings.dart';
import '../../../imports/common.dart';

import '../../../services/socket_io_services.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  TextEditingController chatController= TextEditingController();
  List<File> sentMultimediaFiles = [];

  getPlayStatus(int index, Map<bool, int> isChatPlayingMap) {
    return isChatPlayingMap.containsKey(true) &&
        isChatPlayingMap[true] == index;
  }

  /**
   chat is a dummy list here
      must be empty initially
   */
  List<Message> chatData = [
    Message(
        message: "hai",
        date: DateTime.now(),
        type: ChatType.text,
        isSentByMe: true,
        isNetwork: true,
        chatBubbleColor: getChatBubbleColor(isSentByMe: true)),
    Message(
        message: "how are you..",
        date: DateTime.now(),
        type: ChatType.text,
        isSentByMe: false,
        isNetwork: true,
        chatBubbleColor: getChatBubbleColor(isSentByMe: false)),
    Message(
        message: "dhfsvg  fghpjuis fdyh",
        date: DateTime.now(),
        type: ChatType.text,
        isSentByMe: true,
        isNetwork: true,
        chatBubbleColor: getChatBubbleColor(isSentByMe: true)),
    Message(
        message: "rghfdyhugf yidtgfsy feswrewsrf",
        date: DateTime.now(),
        type: ChatType.text,
        isSentByMe: false,
        isNetwork: true,
        chatBubbleColor: getChatBubbleColor(isSentByMe: false)),
    Message(
        message: "kxghzfoidgs iyhpdyhs iyupweo",
        date: DateTime.now(),
        type: ChatType.text,
        isSentByMe: true,
        isNetwork: true,
        chatBubbleColor: getChatBubbleColor(isSentByMe: true)),
    Message(
        message: "dhfsvg  fghpjuis fdyh",
        date: DateTime.now(),
        type: ChatType.text,
        isSentByMe: true,
        isNetwork: true,
        chatBubbleColor: getChatBubbleColor(isSentByMe: true)),
    Message(
        message: "dhfsvg  fghpjuis fdyh",
        date: DateTime.now(),
        type: ChatType.text,
        isSentByMe: true,
        isNetwork: true,
        chatBubbleColor: getChatBubbleColor(isSentByMe: true)),
    Message(
        message: "dhfsvg  fghpjuis fdyh",
        date: DateTime.now(),
        type: ChatType.text,
        isSentByMe: true,
        isNetwork: true,
        chatBubbleColor: getChatBubbleColor(isSentByMe: true)),
    Message(
        message: "dhfsvg  fghpjuis fdyh oshigb",
        date: DateTime.now(),
        type: ChatType.text,
        isSentByMe: true,
        isNetwork: true,
        chatBubbleColor: getChatBubbleColor(isSentByMe: true)),
    Message(
        message:
            "dhfsvg  fghpjuis fdyh iuidgfspighfuh iudgfuias vlhjbgxzgf sidegf asyudfgpoasy",
        date: DateTime.now(),
        type: ChatType.text,
        isSentByMe: false,
        isNetwork: true,
        chatBubbleColor: getChatBubbleColor(isSentByMe: false)),
    Message(
        message: "dhfsvg  fghpjuis fdyh yiuwoyrtgfaueisgfuisg",
        date: DateTime.now(),
        type:ChatType.text,
        isSentByMe: false,
        isNetwork: true,
        chatBubbleColor: getChatBubbleColor(isSentByMe: false)),
    Message(
        message: "dhfsvg  fghpjuis fdyh oiugfapigdspohgudhshoiho[ih",
        date: DateTime.now(),
        type: ChatType.text,
        isSentByMe: true,
        isNetwork: true,
        chatBubbleColor: getChatBubbleColor(isSentByMe: true)),
    Message(
        message:
            "https://actions.google.com/sounds/v1/alarms/digital_watch_alarm_long.ogg",
        date: DateTime.now(),
        type: ChatType.audio,
        isSentByMe: false,
        isNetwork: true,
        chatBubbleColor: getChatBubbleColor(isSentByMe: false)),
  ].reversed.toList();

  ChatBloc() : super(ChatInitial()) {
    audioPlayer = AudioPlayer();
    audioRecorder = AudioRecorder();

    on<TriggerChatSendEvent>(_onTriggerChatSendEvent);
    on<TriggerChatRecordStartEvent>(_onTriggerChatRecordStartEvent);
    on<TriggerChatRecordStopEvent>(_onTriggerChatRecordStopEvent);
    on<TriggerChatRecordPlayEvent>(_onTriggerChatRecordPlayEvent);
    on<TriggerChatRecordPauseEvent>(_onTriggerChatRecordPauseEvent);
    on<TriggerSocketConnectionToLoadChat>(_onTriggerSocketConnectionToLoadChat);
    on<TriggerReceiveMessage>(_onTriggerReceiveMessage);
    on<TriggerPickMultiMedia>(_onTriggerPickMultiMedia);
  }
  late AudioRecorder audioRecorder;
  late AudioPlayer audioPlayer;
  String? audioPath;
  SocketService socketService = instance<SocketService>();
  String successMessageFromBE = '';

  String roomId = 'ASK BE IF ROOM ID IS NEEDED';

  FutureOr<void> _onTriggerChatSendEvent(
      TriggerChatSendEvent event, Emitter<ChatState> emit) {
    Message message = Message(
        date: DateTime.now(),
        message: chatController.text,
        isSentByMe: true,
        type: ChatType.text,
        isNetwork: false,
        chatBubbleColor: getChatBubbleColor(isSentByMe: true));
    chatData.add(message);

    socketService.sendMessage(message: message, roomId: roomId);

    chatController.clear();
    emit(ChatRefresh(
        chatData: chatData,
        isRecording: false,
        connectStatus: {true: successMessageFromBE},
        chatPlayIndex: const {false: -1}));
    emit(ChatLoaded(
        chatData: chatData,
        isRecording: false,
        connectStatus: {true: successMessageFromBE},
        chatPlayIndex: const {false: -1}));
  }

  FutureOr<void> _onTriggerChatRecordStartEvent(
      TriggerChatRecordStartEvent event, Emitter<ChatState> emit) async {
    emit(ChatRefresh(
      chatData: chatData,
      isRecording: false,
      connectStatus: {true: successMessageFromBE},
      chatPlayIndex: const {false: -1},
    ));
    try {
      if (await audioRecorder.hasPermission()) {
        const encoder = AudioEncoder.wav;
        const config = RecordConfig(encoder: encoder);

        final dir = await getApplicationDocumentsDirectory();
        audioPath = p.join(
          dir.path,
          'audio_${DateTime.now().millisecondsSinceEpoch}.m4a',
        );

        await audioRecorder.start(config, path: audioPath!);
        emit(ChatLoaded(
            chatData: chatData,
            isRecording: true,
            connectStatus: {true: successMessageFromBE},
            chatPlayIndex: const {false: -1}));
      }
    } catch (e) {
      emit(ChatLoaded(
          chatData: chatData,
          isRecording: false,
          connectStatus: {false: e.toString()},
          chatPlayIndex: const {false: -1}));
    }
  }

  FutureOr<void> _onTriggerChatRecordStopEvent(
      TriggerChatRecordStopEvent event, Emitter<ChatState> emit) async {
    emit(ChatRefresh(
        chatData: chatData,
        isRecording: false,
        connectStatus: {true: successMessageFromBE},
        chatPlayIndex: const {false: -1}));
    try {
      audioPath = await audioRecorder.stop();

      chatData.add(Message(
          date: DateTime.now(),
          message: audioPath!,
          isSentByMe: true,
          type: ChatType.audio,
          isNetwork: false,
          chatBubbleColor: getChatBubbleColor(isSentByMe: true)));
      emit(ChatLoaded(
        chatData: chatData,
        isRecording: false,
        connectStatus: {true: successMessageFromBE},
        chatPlayIndex: const {false: -1},
      ));
    } catch (e) {
      emit(ChatLoaded(
          chatData: chatData,
          isRecording: false,
          connectStatus: {false: e.toString()},
          chatPlayIndex: const {false: -1}));
    }
  }

  FutureOr<void> _onTriggerChatRecordPlayEvent(
      TriggerChatRecordPlayEvent event, Emitter<ChatState> emit) async {
    Source source = UrlSource((chatData[event.index].message));

    downloadMultimedia(
        fileNameWithExtension: chatData[event.index].message,
        sourceUrl: chatData[event.index].message);
    // Source source = UrlSource('https://file-examples.com/wp-content/storage/2017/11/file_example_MP3_700KB.mp3');

    try {
      await audioPlayer.play(source);

      emit(ChatRefresh(
          chatData: chatData,
          isRecording: false,
          connectStatus: {true: successMessageFromBE},
          chatPlayIndex: {true: event.index}));
      emit(ChatLoaded(
          chatData: chatData,
          isRecording: false,
          connectStatus: {true: successMessageFromBE},
          chatPlayIndex: {true: event.index}));
      audioPlayer.onPlayerComplete.listen((_) {
        add(TriggerChatRecordPauseEvent(index: event.index));
      });
    } catch (e) {
      emit(ChatLoaded(
          chatData: chatData,
          isRecording: false,
          connectStatus: {false: e.toString()},
          chatPlayIndex: {false: event.index}));
    }
  }

  FutureOr<void> _onTriggerChatRecordPauseEvent(
      TriggerChatRecordPauseEvent event, Emitter<ChatState> emit) async {
    emit(ChatRefresh(
        chatData: chatData,
        isRecording: false,
        connectStatus: {true: successMessageFromBE},
        chatPlayIndex: {true: event.index}));
    try {
      await audioPlayer.pause();
      emit(ChatLoaded(
          chatData: chatData,
          isRecording: false,
          connectStatus: {true: successMessageFromBE},
          chatPlayIndex: {false: event.index}));
    } catch (e) {
      emit(ChatLoaded(
          chatData: chatData,
          isRecording: false,
          connectStatus: {false: e.toString()},
          chatPlayIndex: {false: event.index}));
    }
  }

  Future<FutureOr<void>> _onTriggerSocketConnectionToLoadChat(
      TriggerSocketConnectionToLoadChat event, Emitter<ChatState> emit) async {
    socketService.connect();
    socketService.joinRoom(roomId);
    socketService.socket.on(
      'newMessage',

      ///Check this parameter with BE
      (data) {
        Message message = Message(
            date: DateTime.now(),
            message: data,
            isSentByMe: false,
            type: ChatType.text,
            isNetwork: true,
            chatBubbleColor: getChatBubbleColor(isSentByMe: false));
        add(TriggerReceiveMessage(message: message));
      },
    );

    emit(ChatLoading());
    try {
      // final response =  ;
      // response.fold((failure) => emit(ChatSentFailure(message: failure.message)), (success) {
      //   for (var chats in success.responseData!.chats!) {
      //     chatData.add(chats);
      //   }

      emit(ChatLoaded(
          chatData: chatData,
          isRecording: false,
          connectStatus: {true: successMessageFromBE},
          chatPlayIndex: const {false: -1}));
      // });
    } catch (e) {
      emit(ChatLoaded(
        chatData: chatData,
        isRecording: false,
        connectStatus: {false: e.toString()},
        chatPlayIndex: const {false: -1},
      ));
    }
  }

  FutureOr<void> _onTriggerReceiveMessage(
      TriggerReceiveMessage event, Emitter<ChatState> emit) {
    emit(ChatRefresh(
      chatData: chatData,
      isRecording: false,
      connectStatus: {true: successMessageFromBE},
      chatPlayIndex: const {false: -1},
    ));
    chatData.add(event.message);
    emit(ChatLoaded(
        chatData: chatData,
        isRecording: false,
        connectStatus: {true: successMessageFromBE},
        chatPlayIndex: const {false: -1}));
  }

  FutureOr<void> _onTriggerPickMultiMedia(
      TriggerPickMultiMedia event, Emitter<ChatState> emit) async {
    emit(ChatRefresh(
      chatData: chatData,
      isRecording: false,
      connectStatus: {true: successMessageFromBE},
      chatPlayIndex: const {false: -1},
    ));
    sentMultimediaFiles = await pickMultimedia(
      alreadyPickedMultimediaFiles: [],
      multimediaFileTypes: MultimediaFileType.allTypes,
    );
    for (int i = 0; i < sentMultimediaFiles.length; i++) {
      if (sentMultimediaFiles[i].path.contains('.jpg') ||
          sentMultimediaFiles[i].path.contains('.png') ||
          sentMultimediaFiles[i].path.contains('.jpeg')) {
        chatData.add(Message(
            isNetwork: false,
            date: DateTime.now(),
            message: sentMultimediaFiles[i],
            isSentByMe: true,
            type: ChatType.image,
            chatBubbleColor: getChatBubbleColor(isSentByMe: true)));
      } else if (sentMultimediaFiles[i].path.contains('.mp4')) {
        chatData.add(Message(
          isNetwork: false,
          date: DateTime.now(),
          message: sentMultimediaFiles[i].path,
          chatBubbleColor: getChatBubbleColor(isSentByMe: true),
          isSentByMe: true,
          type: ChatType.video,
        ));


      } else if (sentMultimediaFiles[i].path.contains('.pdf') ||
          sentMultimediaFiles[i].path.contains('.doc')) {
        chatData.add(Message(
            isNetwork: false,
            date: DateTime.now(),
            message: sentMultimediaFiles[i].path,
            chatBubbleColor: getChatBubbleColor(isSentByMe: true),
            isSentByMe: true,
            type: ChatType.pdfDoc));
      } else {
        chatData.add(Message(
            isNetwork: false,
            date: DateTime.now(),
            chatBubbleColor: getChatBubbleColor(isSentByMe: true),
            message: sentMultimediaFiles[i].toString(),
            isSentByMe: true,
            type: ChatType.text));
      }
    }
    emit( ChatLoaded(chatData: chatData, isRecording: false, connectStatus:  {true: successMessageFromBE}, chatPlayIndex: const {false:-1}));

  }
}

