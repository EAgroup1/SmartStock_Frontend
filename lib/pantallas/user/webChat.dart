//'mateapp' creates a template of our static view (stateless) 
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
//here we don't need the navigator
//import '../../my_navigator.dart';

//import two models: user with chatmodel (sockets) & messages (webChat) 
import '../../models/user.dart';
import '../../models/chatmodel.dart';
//also import the model of message
import '../../models/message.dart';

class ChatPage extends StatefulWidget {
  final User friend;
  ChatPage(this.friend);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  final TextEditingController textEditingController = TextEditingController();

  //one widget
  Widget buildSingleMessage(Message message){
    return Container(
      alignment: message.senderID == widget.friend.id
        ? Alignment.centerLeft
        : Alignment.centerRight,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(10.0),
      child: Text(message.text),
    );
  }

  //chat
  Widget buildChatList(){
    return ScopedModelDescendant<ChatModel>(
      builder: (context, child, model){
        //receive the list of messages from one user with X id = ChatID
        List<Message> messages = model.getMessagesForChatID(widget.friend.id);

        return Container(
          height: MediaQuery.of(context).size.height*0.75,
          child: ListView.builder(
            itemCount: messages.length,
            itemBuilder: (BuildContext context, int index){
              return buildSingleMessage(messages[index]);
            },
          ),
        );
      },
    );
  }

  Widget buildChatArea(){
    return ScopedModelDescendant<ChatModel>(
      builder: (context, child, model){
        return Container(
          child: Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width*0.8,
                child: TextField(
                  controller: textEditingController,
                ),
              ),
              SizedBox(width: 10.0),
              FloatingActionButton(
                onPressed: (){
                  model.sendMessage(textEditingController.text, widget.friend.id);
                },
                elevation: 0,
                child: Icon(Icons.send),
              ),
            ],
          ),
        );
      },
    );
  }

  //build all areas
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.friend.userName)
      ),
      body: ListView(
        children: <Widget>[
          //something
          buildChatList(),
          buildChatArea(),
        ],
      ),
    );
  }
}