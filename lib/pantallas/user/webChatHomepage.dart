//'mateapp' creates a template of our static view (stateless) 
import 'package:socket_io_client/socket_io_client.dart';
import 'package:flutter/material.dart';
 
// void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'MaterialApp', home: MyWebPage());
  }
}

//on the other 'statefulW' create a statefull widget (reactive)
//statefull widget only takes one class
//two implementations: three widgets & 
class MyWebPage extends StatefulWidget {
  MyWebPage({Key? key}) : super(key: key);

//return the state of our widget
  @override
  _MyWebPage createState() => _MyWebPage();
}

class _MyWebPage extends State<MyWebPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

void initSocket(){
  try{
    //connect the client to the socket
    // //socket = IO.io('https://localhost:3001',
    //   <String, dynamic>{
    //     'transports': ['websocket'],
    //   });
  } catch(e){
    print(e);
  }
}