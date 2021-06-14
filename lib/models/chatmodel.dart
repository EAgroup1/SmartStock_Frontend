import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rlbasic/models/globalData.dart';
import 'package:rlbasic/pantallas/company/config_company.dart';
import 'package:rlbasic/services/userServices.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:socket_io/socket_io.dart';
//import 'package:flutter_socket_io/flutter_socket_io.dart';// -- NO NULL SAFETY
//import 'package:flutter_socket_io/socket_io_manager.dart';// -- NO NULL SAFETY
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'dart:convert';
import 'package:rlbasic/models/user.dart';
import 'package:rlbasic/models/message.dart';
import 'dart:async' show Future;

class ChatModel extends Model with ChangeNotifier {

  //fake list users this.id, this.userName, this.email, this.bank, this.role, list<_id friends>
  //String friend = UserServices().getUser(GlobalData.getInstance()!.getId()).friends[0];
  /*List<User>? users = [
    UserServices().getUser(UserServices().getUser(GlobalData.getInstance()!.getId()).friends[0])
  ];*/
  //actual user, property late
  //late User? currentUser = UserServices().getUser(GlobalData.getInstance()!.getId());
  //We create two lists: one for the friends and the other for the messages
  late User user;
  late List<User>? friendList;// = [UserServices().getUser("60c4f116aaaa0a33e4e27ebe")];
  /* = [ //FALLO AQUI
    user
    //UserServices().getUser("60c4f116aaaa0a33e4e27ebe")
    //UserServices().getUser(GlobalData.getInstance()!.getId()).friends[0]
  ];*/
  Widget build(BuildContext context) {
    print("AQUI PASO");
    FutureBuilder(
      future: UserServices().getUser("60c4f116aaaa0a33e4e27ebe"),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        print("LLEGO AQUI");
        if (snapshot.hasError) {
          print("NO VA");
        }
        if (snapshot.hasData) {
          user = snapshot.data;
          friendList = [
            user
          ];
          print("EUREKA");
          return Container();
        } else {
          print("NO HAY NADA");
          return Container();
        }
      }
    );
    return Container();
  }
  
  List<Message>? messages = <Message>[];
  IO.Socket socket = IO.io('http://localhost:3000', <String, dynamic>{'transports': ['websocket'],'autoConnect': false,});
  
  
  void init() {
    //prove with the current user is the number 1
    /*currentUser = users![0];
    friendList = users?.where((user) => user.id != currentUser?.id).toList();*/
    //create the socket trough URL 3000 server port?    
    socket.connect();
    var receiverSocket;
    socket.on('connect',(_) {
      print('Socket listening');
    });
    socket.on('MyReceiverSocket',(data){
      print('Receiver socket at: '+data);
      receiverSocket = data;
    });
    socket.on('newmsg', (data) {
      print('New message');
      Fluttertoast.showToast(msg: "Nuevo mensaje: " + data.toString());
      print(data);
    });
    socket.on('escribiendo',(data) {
      print('Writing with id: '+data);
      Fluttertoast.showToast(msg: "Escribiendo...");
    });
  }

  void sendMessage(String text, String receiverChatID){
    var _data = {
      "receiverChatID": receiverChatID,
      "text": text,
      "origin": socket.id,
    };
    socket.emit('newmsg', _data);
  }
  
  void sendEscribiendo(){
    socket.emit('escribiendo', socket.id);
  }
  
  void sendBye(){
    socket.emit('disconnect', socket.id);
  }

  List<Message> getMessagesForChatID(String chatID) {
    return messages!
        .where((msg) => msg.senderID == chatID || msg.receiverID == chatID)
        .toList();
  }

}
