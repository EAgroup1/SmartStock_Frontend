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
  late List<UserChat>? friendList=[]; // = currentUser.friends;
/*   [
    //new User('60aee312c0903a384cfc8544','Javier','javier@gmail.com','ES8200000000000000000000','Business',["60c9cc2b9202363c30c31d46"],""),
    //new User('60c9cc2b9202363c30c31d46','AAAAAAAAAAAAA','a@a.com','safdsfdghvm,bjn','Storage',["60aee312c0903a384cfc8544"],""),
    new User('60c4f100aaaa0a33e4e27ebd','test1','1@a.c','sadfdsgfdhf','Deliverer',["60c4f116aaaa0a33e4e27ebe"],""),
    new User('60c4f116aaaa0a33e4e27ebe','test2','2@a.c','asxdvfxvcgbvnhm','Storage',["60c4f100aaaa0a33e4e27ebd"],"")
  ]; */

  //Prepares rooms value
  void setLists() {
    late Future<List<UserChat>?> list =
        UserServices().getUserChat(GlobalData.getInstance()!.getId());
        list.then((value) => {friendList=value});
    for (var i = 0; i < friendList!.length; i++) {
      if (myId != friendList?[i].id) {
        List<String?> provisionalroom = [myId, ""];
        provisionalroom[1] =
            friendList?[i].id; //Lista provisional con myId y _id amigo
        print(provisionalroom);
        provisionalroom.sort(); //Sort
        var prov =
            provisionalroom[0].toString() + provisionalroom[1].toString();
        rooms.add(prov);
      }
    }
  }

  //Define (actual fake) messages list for conversation
  List<Message>? messages = <Message>[
    new Message("HOLA", "60c4f116aaaa0a33e4e27ebe", "60c4f100aaaa0a33e4e27ebd"),
    new Message("HOLA", "60c4f100aaaa0a33e4e27ebd", "60c4f116aaaa0a33e4e27ebe"),
    new Message(
        "Que tal?", "60c4f116aaaa0a33e4e27ebe", "60c4f100aaaa0a33e4e27ebd"),
    new Message("bien", "60c4f100aaaa0a33e4e27ebd", "60c4f116aaaa0a33e4e27ebe")
  ];

  //Create socket (but no connect it yet)
  IO.Socket socket = IO.io('http://localhost:3000', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });

  Widget build(BuildContext context) {
    print("AQUI PASO");
    FutureBuilder(
        future: UserServices().getUserChat(GlobalData.getInstance()!.getId()),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          print("LLEGO AQUI");
          if (snapshot.hasError) {
            print("NO VA");
          }
          if (snapshot.hasData) {
            //currentUser = snapshot.data;
            //friendList = [(currentUser!.friends) as User];
            print("EUREKA");
            return Container();
          } else {
            print("NO HAY NADA");
            return Container();
          }
        });
    return Container();
  }

  //adds room for socket
  void addroom(String newroom) {
    rooms.add(newroom);
  }

  //deletes room for socket
  void delroom(String room) {
    rooms.remove(room);
  }

  //initiates socket
  void init() {
    //Connect the socket and joins the rooms
    socket.connect();
    socket.emit('joinrooms', rooms);

    //Different listening events from client
    socket.on('connect', (_) {
      print('Socket listening');
    });
    socket.on('newmsg', (data) {
      print('New message');
      Fluttertoast.showToast(msg: "Nuevo mensaje: " + data.toString());
      print(data);
    });
    socket.on('escribiendo', (data) {
      print('Writing with ChatID: ' + data);
      Fluttertoast.showToast(msg: "Escribiendo...");
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
    return messages!
        .where((msg) => msg.senderID == chatID || msg.receiverID == chatID)
        .toList();
  }
}
