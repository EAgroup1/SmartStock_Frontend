import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rlbasic/models/globalData.dart';
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

class ChatModel extends Model with ChangeNotifier {

 
  //actual user, property late
  //late User? currentUser = UserServices().getUser(GlobalData.getInstance()!.getId());
  late User user; //USUARIO YA VEREMOS QUE HACEMOS CON ESTO

  //rooms where put sockets. rooms(0) = own _id, rooms(1) = receiver _id
  var rooms = [];

  //fake list users this.id, this.userName, this.email, this.bank, this.role, list<_id friends>
  late List<User>? friendList = [
    new User('60aee312c0903a384cfc8544','Javier','javier@gmail.com','ES8200000000000000000000','Business',["60c9cc2b9202363c30c31d46"],""),
    new User('60c9cc2b9202363c30c31d46','AAAAAAAAAAAAA','a@a.com','safdsfdghvm,bjn','Storage',["60aee312c0903a384cfc8544"],""),
    new User('60c4f100aaaa0a33e4e27ebd','test1','1@a.c','sadfdsgfdhf','Deliverer',["60c4f116aaaa0a33e4e27ebe"],""),
    new User('60c4f116aaaa0a33e4e27ebe','test2','2@a.c','asxdvfxvcgbvnhm','Storage',["60c4f100aaaa0a33e4e27ebd"],"")
  ];// = [UserServices().getaUser("60b0b46e13d24f3c585c7c72")];// = [UserServices().getUser("60c4f116aaaa0a33e4e27ebe")];
  /* = [ //FALLO AQUI
    user
    //UserServices().getUser("60b0b46e13d24f3c585c7c72")
    //UserServices().getUser(GlobalData.getInstance()!.getId()).friends[0]
  ];*/
  
  //Define messages list for conversation
  List<Message>? messages = <Message>[
    new Message("HOLA", "60c4f116aaaa0a33e4e27ebe", "60c4f100aaaa0a33e4e27ebd"),
    new Message("HOLA", "60c4f100aaaa0a33e4e27ebd", "60c4f116aaaa0a33e4e27ebe"),
    new Message("Que tal?", "60c4f116aaaa0a33e4e27ebe", "60c4f100aaaa0a33e4e27ebd"),
    new Message("bien", "60c4f100aaaa0a33e4e27ebd", "60c4f116aaaa0a33e4e27ebe")
  ];

  //Create socket (but no connect it yet)
  IO.Socket socket = IO.io('http://localhost:3000', <String, dynamic>{'transports': ['websocket'],'autoConnect': false,});

  Widget build(BuildContext context) {
    print("AQUI PASO");
    FutureBuilder(
      future: UserServices().getUser("60b0b46e13d24f3c585c7c72"),
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
  
  
  //adds room for socket
  void addroom(String newroom){
    rooms.add(newroom);
    print(rooms);
  }

  //deletes room for socket
  void delroom(String room){
    rooms.remove(room);
    print(rooms);
  }

  //initiates socket
  void init() { 
    socket.connect();
    socket.on('connect',(_) {
      print('Socket listening');
      socket.emit('rooms',rooms);
    });
    socket.on('newmsg', (data) {
      print('New message');
      //print ("AQUI COÑO "+ GlobalData.getInstance()!.getId());
      //if (data['origin'] != GlobalData.getInstance()?.getId()){
        Fluttertoast.showToast(msg: "Nuevo mensaje: " + data.toString());
        print(data);
      /*}
      else{
        print("Your own message");
      }*/
    });
    socket.on('escribiendo',(data) {
      print('Writing with id: '+data);
      Fluttertoast.showToast(msg: "Escribiendo...");
    });
  }

  //join the rooms for socket
  void sendRooms(){
    socket.emit('rooms',rooms);
    print("Connected to rooms");
  }

  //send a message to sockets joined
  void sendMessage(String text){
    var _data = {
      "destination": rooms[1],
      "text": text,
      "origin": rooms[0],
    };
    socket.emit('newmsg', _data);
  }
  
  //send "writing" flag to receiver
  void sendEscribiendo(){
    socket.emit('escribiendo', rooms[1]);
  }
  
  //disconnect from socket chat, and delete it
  void sendBye(){
    try{
      socket.emit('disconnect', rooms[1]);
      rooms.remove(rooms[1]);
      print("Chat disconnected");
    }
    catch(e){
      print("Already disconnected");
    }
  }

  List<Message> getMessagesForChatID(String chatID) {
    return messages!
        .where((msg) => msg.senderID == chatID || msg.receiverID == chatID)
        .toList();
  }

}
