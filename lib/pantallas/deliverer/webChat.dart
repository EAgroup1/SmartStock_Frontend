import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

//possibly deleted
//instance of this socket
late IO.Socket socket;

@override
void initState() { 
  //super.initState();
  connectToServer();
  
}

void connectToServer(){
  try{
    socket = IO.io('http://127.0.0.1:3000', <String, dynamic>{
      'transports': ['websockets'],
      'autoConnect': false,
    });

    //connect to websocket
    socket.connect();

    //handle socket events
    socket.on('connect', (_) => print('connect: ${socket.id}'));
  } catch(e){
    print(e.toString());
  }


}