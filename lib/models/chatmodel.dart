import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rlbasic/models/globalData.dart';
import 'package:rlbasic/models/userChat.dart';
import 'package:rlbasic/pantallas/company/config_company.dart';
import 'package:rlbasic/services/userServices.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:socket_io/socket_io.dart';
import 'package:flutter/material.dart';
import 'package:stack/stack.dart';
import 'package:rlbasic/pantallas/webChat.dart';

//import 'package:flutter_socket_io/flutter_socket_io.dart';// -- NO NULL SAFETY
//import 'package:flutter_socket_io/socket_io_manager.dart';// -- NO NULL SAFETY
import 'package:socket_io_client/socket_io_client.dart' as IO;



import 'dart:convert';
import 'package:rlbasic/models/user.dart';
import 'package:rlbasic/models/message.dart';
import 'dart:async' show Future;

import 'globalData.dart';

class ChatModel extends Model with ChangeNotifier {
  //actual user, property late
  //late User currentUser = UserServices().getUserChat(GlobalData.getInstance()!.getId());

  String? myId = GlobalData.getInstance()?.getId();

  //Separated _ID used for chatID
  var chatIDvect;

  //Concatenation of chatIDvect sorted. This one will be the chat we are speaking to
  var chatID;

  //rooms where put sockets. All sockets with your friend sorted
  var rooms = [];

  //(Actually fake) list users this.id, this.userName, this.email, this.bank, this.role, list<_id friends>
  late List<UserChat>? friendList=[];


  var test;
  //Prepares rooms value
  setLists() async{

    await UserServices().getUserChat(myId.toString()).then((value) => {friendList=value});
    await UserServices().getListMessages(myId.toString()).then((value) => {test=value});
    print("Cosas de test");
    //print(test['senderID']);
    //Message mensaje = test[0];
    //print(mensaje);
    //print(mensaje.senderID);
    print("FIN DE TEST");
    for (var i = 0; i < friendList!.length; i++) {
      if (myId != friendList?[i].id) {
        List<String?> provisionalroom = [myId, ""];
        provisionalroom[1] =
            friendList?[i].id; //Lista provisional con myId y _id amigo
        provisionalroom.sort(); //Sort
        var prov =
            provisionalroom[0].toString() + provisionalroom[1].toString();
        rooms.add(prov);
      }
    }
    print("salas");
    print(rooms);
    print("mensajes");
    print(messages);
  }

  //Define (actual fake) messages list for conversation
  late List<Message> messages = [];// = <Message>[
    /*new Message("HOLA", "60c4f100aaaa0a33e4e27ebd", "60c4f116aaaa0a33e4e27ebe"),
    new Message("PRUEBA", "60c4f100aaaa0a33e4e27ebd", "2222"),
    new Message("HOLA", "60c4f116aaaa0a33e4e27ebe", "60c4f100aaaa0a33e4e27ebd"),
    new Message(
        "Que tal?", "60c4f100aaaa0a33e4e27ebd", "60c4f116aaaa0a33e4e27ebe"),
    new Message("bien", "60c4f116aaaa0a33e4e27ebe", "60c4f100aaaa0a33e4e27ebd"),
    new Message("PRUEBA", "1111", "60c4f100aaaa0a33e4e27ebd"),
  ];*/

  //Create socket (but no connect it yet)
  IO.Socket socket = IO.io('http://backend:3000', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });

  //adds room for socket
  void addroom(String newroom) {
    rooms.add(newroom);
  }

  //deletes room for socket
  void delroom(String room) {
    rooms.remove(room);
  }

  //initiates socket
  init() async {
    Future.delayed(Duration(seconds: 5));
    //Connect the socket and joins the rooms
    socket.connect();
    socket.emit('joinrooms', rooms);

    //Different listening events from client
    socket.on('connect', (_) {
      print('Socket listening');
    });
    socket.on('newmsg', (data) {
      print('New message');
      Message newmsg = new Message(data['text'],data['origin'],data['destination']);
      //messages.add(newmsg);

      UserServices().addMessageList(myId.toString(), messages);
      Fluttertoast.showToast(msg: "Nuevo mensaje: " + data['text'].toString());
      print(data);
    });
    socket.on('escribiendo', (data) {
      print('Writing with ChatID: ' + data);
      if (chatID == data){
        Fluttertoast.showToast(msg: "Escribiendo...");
      }
    });
  }
  //Different emit to server

  //send a message to sockets joined
  void sendMessage(String text) {
    String dest;
    if (chatIDvect[0] == myId) {
      dest = chatIDvect[1].toString();
    } else {
      dest = chatIDvect[0].toString();
    }
    var _data = {
      "destination": dest,
      "text": text,
      "origin": myId,
      "room": chatID
    };
    socket.emit('newmsg', _data);
  }

  //send "writing" flag to receiver
  void sendEscribiendo() {
    socket.emit('escribiendo', chatID);
  }

  //DISCONNECT ACTUALLY NOT IN USE AS WE NEED ALL ROOMS TO LISTEN CHATS

  /*//disconnect from all sockets
  void sendBye(){
    try{
      socket.emit('disconnect', rooms);
      print("Socket disconnected");
    }
    catch(e){
      print("Already disconnected");
    }
  }*/

  List<Message> getMessagesForChatID(String chatID) {
    return messages
        .where((msg) => msg.senderID == chatID || msg.receiverID == chatID)
        .toList();
  }
}
