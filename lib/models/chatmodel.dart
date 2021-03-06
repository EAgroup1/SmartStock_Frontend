
// import 'package:scoped_model/scoped_model.dart'; -- NO NULL SAFETY
// import 'package:flutter_socket_io/flutter_socket_io.dart'; -- NO NULL SAFETY
// import 'package:flutter_socket_io/socket_io_manager.dart'; -- NO NULL SAFETY
// import 'package:flutter_socket_io/socket_io_client.dart';


import 'dart:convert';
import './user.dart';
import './message.dart';

class ChatModel /*extends Model*/{

  //fake list users this.id, this.userName, this.email, this.bank, this.role
  List<User> users = [
    User('1', 'user1', 'user1@hotmail.es', 'ES93123', 'user', 'palafox'),
    User('3', 'deliverer2', 'deliverer2@hotmail.es', 'ES93789', 'deliverer', 'palafox'),
    User('4', 'store1', 'store1@hotmail.es', 'ES94123', 'store', 'palafox'),
  ];
  
  //actual user, property late
  late User currentUser;

  //We create two lists: one for the friends and the other for the messages
  List<User> friendList = <User>[];
  List<Message> messages = <Message>[];

  // //socket for connections
  // late SocketIO socketIO;

  void init() {
    //prove with the current user is the number 1
    currentUser = users[0];
    friendList = users.where((user) => user.id != currentUser.id).toList();


    //create the socket trough URL 4000 or 3000? server port?
    // socketIO = SocketIOManager().createSocketIO(
    //   'http://localhost:4000', '/',
    //   query: 'id=${currentUser.id}');


    //init the socket
    // socketIO.init();
    

    //add subscribers to the same socket
    // socketIO.subscribe('receive_message', (jsonData) {
    //   //Convert the JSON data received into a Map
    //   Map<String, dynamic> data = json.decode(jsonData);
    //   messages.add(Message(
    //     data['content'], data['senderChatID'], data['receiverChatID']));
    //   notifyListeners();
    // });


    // socketIO.connect();
  }

  void sendMessage(String text, String receiverChatID) {
    messages.add(Message(text, currentUser.id, receiverChatID));
    // socketIO.sendMessage(
    //   'send_message',
    //   json.encode({
    //     'receiverChatID': receiverChatID,
    //     'senderChatID': currentUser.id,
    //     'content': text,
    //   }),
    // );
    // notifyListeners();
  }
  

  List<Message> getMessagesForChatID(String chatID) {
    return messages
        .where((msg) => msg.senderID == chatID || msg.receiverID == chatID)
        .toList();
  }
}
