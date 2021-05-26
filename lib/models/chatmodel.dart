<<<<<<< HEAD
// import 'package:scoped_model/scoped_model.dart';
// import 'package:flutter_socket_io/flutter_socket_io.dart';
// import 'package:flutter_socket_io/socket_io_manager.dart';

=======
import 'package:http/io_client.dart';
import 'package:scoped_model/scoped_model.dart';
//import 'package:flutter_socket_io/flutter_socket_io.dart';
//import 'package:flutter_socket_io/socket_io_manager.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io/socket_io.dart';
>>>>>>> 3c92ee777005ea6871c710f84fafe82093c741ab
import 'dart:convert';
import './user.dart';
import './message.dart';

<<<<<<< HEAD
class ChatModel /*extends Model*/{

=======
class ChatModel extends Model {
>>>>>>> 3c92ee777005ea6871c710f84fafe82093c741ab
  //fake list users this.id, this.userName, this.email, this.bank, this.role
  List<User> users = [
    User('1', 'user1', 'user1@hotmail.es', 'ES93123', 'user'),
    User('2', 'deliverer1', 'deliverer1@hotmail.es', 'ES93456', 'deliverer'),
    User('3', 'deliverer2', 'deliverer2@hotmail.es', 'ES93789', 'deliverer'),
    User('4', 'store1', 'store1@hotmail.es', 'ES94123', 'store'),
    User('3', 'user2', 'user2@hotmail.es', 'ES94567', 'user'),
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
<<<<<<< HEAD
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
=======
    socketIO = SocketIOManager().createSocketIO('http://localhost:4000', '/',
    query: 'id=${currentUser.id}');
 
    //init the socket
    socketIO.init();

    //add subscribers to the same socket
    socketIO.subscribe('receive_message', (jsonData) {
      //Convert the JSON data received into a Map
      Map<String, dynamic> data = json.decode(jsonData);
      messages.add(Message(
          data['content'], data['senderChatID'], data['receiverChatID']));
      notifyListeners();
    });

    socketIO.connect();
>>>>>>> 3c92ee777005ea6871c710f84fafe82093c741ab
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
