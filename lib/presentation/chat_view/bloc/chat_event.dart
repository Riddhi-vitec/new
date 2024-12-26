part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent extends Equatable {
  const ChatEvent();
  @override

  List<Object?> get props => [];
}

class TriggerChatSendEvent extends ChatEvent{
  const TriggerChatSendEvent();
}

class TriggerChatRecordStartEvent extends ChatEvent{}
class TriggerChatRecordStopEvent extends ChatEvent{}
class TriggerChatRecordPlayEvent extends ChatEvent{
  final int index;
 // final bool isSentByMe;
  const TriggerChatRecordPlayEvent( {required this.index,
   // required this.isSentByMe,
  });
  @override
  List<Object?> get props => [index,
   // isSentByMe
  ];
}
class TriggerChatRecordPauseEvent extends ChatEvent{
  final int index;
  const TriggerChatRecordPauseEvent({required this.index});
  @override
  List<Object?> get props => [index];
}
class TriggerReceiveMessage extends ChatEvent{
  final Message message;
  const TriggerReceiveMessage({required this.message});
  @override
  List<Object?> get props => [message];
}
class TriggerPickMultiMedia extends ChatEvent{}
class TriggerSocketConnectionToLoadChat extends ChatEvent{
  final String roomId;
  const TriggerSocketConnectionToLoadChat({required this.roomId});
  @override
  List<Object?> get props => [roomId];
}