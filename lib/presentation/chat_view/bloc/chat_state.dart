part of 'chat_bloc.dart';

@immutable
abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<Message> chatData;
  final Map<bool, int> chatPlayIndex;
  final bool isRecording;
  final Map<bool, String> connectStatus;

  const ChatLoaded(
      {required this.chatData,
      required this.isRecording,
      required this.chatPlayIndex,
      required this.connectStatus});

  @override
  List<Object?> get props =>
      [chatData, isRecording, chatPlayIndex, connectStatus];
}

class ChatRefresh extends ChatState {
  final List<Message> chatData;
  final Map<bool, int> chatPlayIndex;
  final bool isRecording;
  final Map<bool, String> connectStatus;

  const ChatRefresh(
      {required this.chatData,
      required this.isRecording,
      required this.chatPlayIndex,
      required this.connectStatus});

  @override
  List<Object?> get props =>
      [chatData, isRecording, chatPlayIndex, connectStatus];
}

class Message {
  dynamic message;
  ChatType type;
  DateTime date;
  bool isSentByMe;
  bool isNetwork;
  Color chatBubbleColor;


  Message(
      {required this.date,
      required this.message,
      required this.chatBubbleColor,

      required this.isSentByMe,
      required this.type,
      required this.isNetwork});

  @override
  List<Object?> get props => [
        date,
        message,
        isSentByMe,
        type,
        isNetwork,
        chatBubbleColor,

      ];
}
