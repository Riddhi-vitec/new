import 'package:socket_io_client/socket_io_client.dart' as io;

import '../app_configuration/app_environments.dart';



class SocketService {
  static final String serverURL =
      AppEnvironments.socketUrl; // Replace with your server URL

  final io.Socket socket = io.io(serverURL, <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });

  void joinRoom(String roomId) {
    socket.emit('joinRoom', {"room_id": roomId});
  }
  ///Ask BE FOR BODY STRUCTURE
  void sendMessage({required  message, required roomId}) {
    socket.emit('sendMessage', {
      "message":message,
      "room_id": roomId
    });
  }

  void connect() {
    socket.connect();
  }

  void disconnect() {
    socket.disconnect();
  }
}