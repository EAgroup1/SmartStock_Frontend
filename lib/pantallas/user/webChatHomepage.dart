//'mateapp' creates a template of our static view (stateless) 
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import '../../my_navigator.dart';

//import the models
import '../../models/user.dart';
import '../../models/message.dart';

// void main() => runApp(MyApp());
 
// class MyWebPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(title: 'MaterialApp', home: MyWebPage());
//   }
// }

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